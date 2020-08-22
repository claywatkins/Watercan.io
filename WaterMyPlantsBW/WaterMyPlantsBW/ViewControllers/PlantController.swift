//
//  PlantController.swift
//  WaterMyPlantsBW
//
//  Created by BrysonSaclausa on 8/21/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation

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
    }
    
    var bearer: Bearer?
    
    var plants: [Plant] = []
    
    private let baseURL = URL(string: "https://watercan-io-bw.herokuapp.com/")!
    private lazy var signUpURL = baseURL.appendingPathComponent("api/auth/register")
    private lazy var signInURL = baseURL.appendingPathComponent("api/auth/login")
    private lazy var plantsURL = baseURL.appendingPathComponent("api/plants") //plants endpoint
    
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
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        print("Sign up was unsuccesful")
                        completion(.failure(.failedSignUp))
                        return
                }
                completion(.success(true))
            }
            task.resume()
        } catch {
            print("Error encoding user: \(error)")
            completion(.failure(.failedSignUp))
        }
    }
    
    private func postRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
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
                do {
                    self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
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
    
    func getPlants(completion: @escaping (Result<[Plant], NetworkError>) -> Void) {
        guard let bearer = bearer else {
            completion(.failure(.noToken))
            return
        }
        var request = URLRequest(url: plantsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving gig data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.noToken))
                return
            }
            guard let data = data else {
                print("No data received from getGigs")
                completion(.failure(.noData))
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            do {
                let plants = try jsonDecoder.decode([Plant].self, from: data)
                completion(.success(plants))
                
            } catch {
                print("Error decoding gig data: \(error)")
                completion(.failure(.tryAgain))
            }
        }
        task.resume()
    }
    
    func createPlant(with plant: Plant, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        guard let bearer = bearer else {
            completion(.failure(.noToken))
            return
        }
        var request = postRequest(for: plantsURL)
        request.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.dateEncodingStrategy = .iso8601
            let jsonData = try jsonEncoder.encode(plant)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
                if let error = error {
                    print("Error creating plant: \(error)")
                    completion(.failure(.tryAgain))
                    return
                }
                if let response = response as? HTTPURLResponse,
                    response.statusCode == 401 {
                    completion(.failure(.noToken))
                    return
                }
                self.plants.append(plant)
                completion(.success(true))
            }
            task.resume()
        } catch {
            print("Error encoding plant: \(error)")
            completion(.failure(.tryAgain))
        }
    }
    
}
