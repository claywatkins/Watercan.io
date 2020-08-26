//
//  PlantController.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/25/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation
import CoreData

class PlantController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum NetworkError: Error {
        case noData
        case failedSignUp
        case failedSignIn
        case noToken
        case tryAgain
        case noDecode
        case noEncode
        case noRep
    }
    
    var bearer: Bearer?
    var userId: Int?
    var plantId: Int?
    
    static let shared = PlantController()
    
    private let baseURL = URL(string: "https://watercan-io-bw.herokuapp.com/")!
    private lazy var signUpURL = baseURL.appendingPathComponent("api/auth/register")
    private lazy var signInURL = baseURL.appendingPathComponent("api/auth/login")
    private lazy var plantsURL = baseURL.appendingPathComponent("api/plants") //plants endpoint
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    private func postRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    // MARK: - SignUp/Login
    func signUp(with user: User, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        print("signUpURL = \(signUpURL.absoluteString)")
        var request = postRequest(for: signUpURL)
        do {
            let jsonData = try JSONEncoder().encode(user)
            print(String(data: jsonData, encoding: .utf8)!)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
                if let error = error {
                    print("SignUp failed with error: \(error)")
                    completion(.failure(.failedSignUp))
                    return
                }
                
//                if let response = response {
//                    print(response)
//                }
//                guard let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 else {
//                        print("Sign up was unsuccesful")
//                        completion(.failure(.failedSignUp))
//                        return
//                }
                completion(.success(true))
            }
            task.resume()
        } catch {
            print("Error encoding user: \(error)")
            completion(.failure(.failedSignUp))
        }
    }
    
    func signIn(with user: User, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        var request = postRequest(for: signInURL)
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Sign in failed with error: \(error)")
                    completion(.failure(.failedSignIn))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        print("Sign in was unsuccessful")
                        completion(.failure(.failedSignIn))
                        return
                }
                guard let data = data else {
                    print("Data was not received")
                    completion(.failure(.noData))
                    return
                }
                // Getting the bearer and UserID
                do {
                    self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
                    let userID = try JSONDecoder().decode(UserIdGetter.self, from: data)
                    self.userId = userID.user.id
                    completion(.success(true))
                } catch {
                    print("Error decoding bearer: \(error)")
                    completion(.failure(.noToken))
                }
                
            }
            task.resume()
        } catch {
            print("Error encoding user: \(error.localizedDescription)")
            completion(.failure(.failedSignIn))
        }
    }
    
    // MARK: - CRUD
    //Put the task to the server
    func sendPlantToServer(plant: Plant, completion: @escaping (Result<PlantRepresentation, NetworkError>) -> Void) {
        
        guard let bearer = bearer else {
            completion(.failure(.noToken))
            return
        }
        guard let id = userId else { return }
        
        let requestURL = plantsURL.appendingPathComponent("\(id)")
        print(requestURL.absoluteString)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("Bearer \(bearer.jwt)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print()
        do {
            guard let representation = plant.plantRepresentation else {
                completion(.failure(.noRep))
                return
            }
            do {
                request.httpBody = try JSONEncoder().encode(representation)
            } catch {
                print("Error encoding task \(plant): \(error)")
                completion(.failure(.noEncode))
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error PUTting task to server: \(error)")
                    completion(.failure(.tryAgain))
                    return
                }
                
                if let response = response {
                    print(response)
                }
                
                guard let data = data else {
                    return
                }
                
                do {
                    let returnedPlant = try JSONDecoder().decode(PlantRepresentation.self, from: data)
                    self.plantId = returnedPlant.id
//                    guard let newPlant = Plant(plantRepresentartion: returnedPlant) else { return }
                    completion(.success(returnedPlant))

                } catch {
                    print("Error getting plant ID: \(error)")
                }
                
            }
            
            task.resume()
        }
    }
    
}
