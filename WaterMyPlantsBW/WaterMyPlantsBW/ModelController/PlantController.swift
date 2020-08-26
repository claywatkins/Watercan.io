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
        case delete = "DELETE"
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
            let task = URLSession.shared.dataTask(with: request) { (_, _, error) in
                if let error = error {
                    print("SignUp failed with error: \(error)")
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
                    completion(.success(returnedPlant))
                    
                } catch {
                    print("Error getting plant ID: \(error)")
                }
                
            }
            
            task.resume()
        }
    }
    
    func deletePlantFromServer(_ plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        
        guard let bearer = bearer else {
            completion(.failure(.noToken))
            return
        }
        
        let requestURL = plantsURL.appendingPathComponent("\(self.userId!)")
        print(requestURL.absoluteString)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.addValue("Bearer \(bearer.jwt)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response!)
            completion(.success(true))
        }
        
        task.resume()
    }
    
    func fetchEntriesFromServer(completion: @escaping CompletionHandler = { _ in }) {
        guard let bearer = bearer else {
            completion(.failure(.noToken))
            return
        }
        guard let id = userId else { return }
        
        let requestURL = plantsURL.appendingPathComponent("\(id)")
        print(requestURL.absoluteString)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("Bearer \(bearer.jwt)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching entries: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                print(response)
                completion(.failure(.noToken))
                return
            }
            guard let data = data else {
                print("No data returned by data task.")
                completion(.failure(.noData))
                return
            }
            do {
                let plantRepresentations = try JSONDecoder().decode([PlantRepresentation].self, from: data)
                try self.updatePlants(with: plantRepresentations)
                completion(.success(true))
            } catch {
                print("Error decoding entry representations: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }
        task.resume()
    }
    
    func updatePlants(with representations: [PlantRepresentation]) throws {
        let context = CoreDataStack.shared.container.newBackgroundContext()
        
        let identifiersToFetch = representations.compactMap({$0.id})
        
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        var plantsToCreate = representationsByID
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@", identifiersToFetch)
        
        context.performAndWait {
            do {
                let existingPlants = try context.fetch(fetchRequest)
                
                // Update Existing
                for plant in existingPlants {
                    let id = Int(plant.id)
                    guard let representation = representationsByID[id] else { continue }
                    
                    self.update(plant: plant, representation: representation)
                    
                    plantsToCreate.removeValue(forKey: id)
                }
                for representation in plantsToCreate.values {
                    Plant(plantRepresentartion: representation, context: context)
                }
            } catch {
                print("Error fetching plants: \(error)")
            }
        }
        try CoreDataStack.shared.save(context: context)
    }
    
    func update(plant: Plant, representation: PlantRepresentation) {
        plant.species = representation.species
        plant.nickname = representation.nickname
        plant.id = Int16(representation.id!)
        plant.h2ofrequency = representation.h2ofrequency
    }
    
}
