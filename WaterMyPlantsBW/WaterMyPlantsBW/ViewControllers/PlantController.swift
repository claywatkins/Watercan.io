//
//  PlantController.swift
//  WaterMyPlantsBW
//
//  Created by BrysonSaclausa on 8/21/20.
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
    
    private let baseURL = URL(string: "https://watercan-io-bw.herokuapp.com/")!
    private lazy var signUpURL = baseURL.appendingPathComponent("api/auth/register")
    private lazy var signInURL = baseURL.appendingPathComponent("api/auth/login")
    private lazy var plantsURL = baseURL.appendingPathComponent("api/plants") //plants endpoint
    
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
    
    
    // MARK: - CRUD
    

    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void

    func fetchEntriesFromServer(completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        
        guard let bearer = bearer else {
            completion(.failure(.noToken))
            return
        }
        var request = URLRequest(url: plantsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                print("Error fetching entries: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.noToken))
                return
            }
            guard let data = data else {
                print("No data returned by data task.")
                completion(.failure(.noData))
                return
            }
            do {
                let plantRepresentations = Array(try JSONDecoder().decode([String: PlantRepresentation].self, from: data).values)
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

    //Put the task to the server
    func sendPlantToServer(plant: Plant, completion: @escaping CompletionHandler = {_ in}) {
        
        guard let bearer = bearer else {
            completion(.failure(.noToken))
            return
        }
        var signInRequest = postRequest(for: signInURL)
        signInRequest.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        guard let id = plant.id else {
            completion(.failure(.noToken))
            return
        }
        
        let requestURL = baseURL.appendingPathComponent(id).appendingPathExtension(".json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
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
        
        let task = URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("Error PUTting task to server: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            
            completion(.success(true))
        }
        
        task.resume()
    }

    func deletePlantFromServer(_ plant: Plant, completion: @escaping CompletionHandler = { _ in }) {
        
        guard let bearer = bearer else {
            completion(.failure(.noToken))
            return
        }
        var signInRequest = postRequest(for: signInURL)
        signInRequest.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        guard let id = plant.id else {
            completion(.failure(.noToken))
            return
        }
        
        
        let requestURL = baseURL.appendingPathComponent(id).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response!)
            completion(.success(true))
        }
        
        task.resume()
    }

    func updatePlants(with representations: [PlantRepresentation]) throws {
        //let context = CoreDataStack.shared.container.newBackgroundContext()
        let identifiersToFetch = representations.compactMap({UUID(uuidString: $0.identifier)})
        
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        var entriesToCreate = representationsByID
        
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)
        
        let context = CoreDataStack.shared.mainContext
        
        do {
            let existingPlants = try context.fetch(fetchRequest)
            
            // Update Existing
            for plants in existingPlants {
                guard let id = plant.identifier,
                    let representation = representationsByID[id] else { continue }
                
                plant.userID = representation.userID
                plant.species = representation.species
                plant.nickname = representation.nickname
                plant.id = representation.id
                plant.h2ofrequency = representation.h2ofrequency
                
                plantsToCreate.removeValue(forKey: id)
            }
            for representation in plantsToCreate.values {
                Plant(plantRepresentation: representation, context: context)
            }
        } catch {
            print("Error fetching entries for UUIDs: \(error)")
        }
        try CoreDataStack.shared.mainContext.save()
    }

    func update(plant: Plant, representation: PlantRepresentation) {
        plant.userID = representation.userID
        plant.species = representation.species
        plant.nickname = representation.nickname
        plant.id = representation.id
        plant.h2ofrequency = representation.h2ofrequency
    }






}
}
