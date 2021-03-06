//
//  Network Service.swift
//  to-do
//
//  Created by Павел Тимофеев on 04.07.2021.
//

import Foundation

typealias Onsuccess = (Todos) -> Void
typealias OnError = (String) -> Void
class NetworkService {
    
    static let shared = NetworkService()
    let URL_BASE = "http://localhost:3003"
    let URL_ADD_TODO = "/add"

    let session = URLSession(configuration: .default)
    
    func getTodos(onSuccess: @escaping Onsuccess, onError: @escaping OnError) {
        guard let url = URL(string: "\(URL_BASE)") else {return}
        
        let task = session.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Ivalid data of responce!")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(Todos.self, from: data)
                        onSuccess(items)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func addTodo(todo: Todo, onSuccess: @escaping Onsuccess, onError: @escaping OnError) {
        let url = URL(string: "\(URL_BASE)\(URL_ADD_TODO)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let body = try JSONEncoder().encode(todo)
            request.httpBody = body
            
            let task = session.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        onError(error.localizedDescription)
                        return
                    }
                    
                    guard let data = data, let response = response as? HTTPURLResponse else {
                        onError("Ivalid data of responce!")
                        return
                    }
                    
                    do {
                        if response.statusCode == 200 {
                            let item = try JSONDecoder().decode(Todos.self, from: data)
                       onSuccess(item)
                        } else {
                            let err = try JSONDecoder().decode(APIError.self, from: data)
                            onError(err.message)
                        }
                        
                    } catch {
                        onError(error.localizedDescription)
                    }
                }
            }
            task.resume()
            
        } catch {
            onError(error.localizedDescription)
        }
    }
}
