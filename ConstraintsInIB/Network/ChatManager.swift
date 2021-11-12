//
//  ChatManager.swift
//  ConstraintsInIB
//
//  Created by Ignacio Cervino on 12/11/2021.
//

import Foundation

enum Errors: Error {
    case invalidResponse
    case wrongURL
    case fileNotFound
    case invalidData
    case decodingProblem(String)
    case serverError
    case pageNotFound
    case genericError
}

class MessageManager {
    
    func retrieveFromJson(onCompletion: @escaping (Result<[Chat], Errors>) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            let url = Bundle.main.url(forResource: "messages", withExtension: "json")
            guard let myUrl = url else {
                onCompletion(.failure(.fileNotFound))
                return
            }
            guard let myData = try? Data(contentsOf: myUrl) else {
                onCompletion(.failure(.invalidData))
                return
            }
            do {
                let messages = try JSONDecoder().decode([Chat].self, from: myData)
                onCompletion(.success(messages))
            } catch DecodingError.dataCorrupted(_) {
                onCompletion(.failure(.decodingProblem("Data corrupted")))
            } catch DecodingError.keyNotFound(let codingKey, _) {
                onCompletion(.failure(.decodingProblem(codingKey.stringValue)))
            } catch let error {
                onCompletion(.failure(.decodingProblem(error.localizedDescription)))
            }
        }
    }
    
}
