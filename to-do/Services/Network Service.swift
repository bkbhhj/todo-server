//
//  Network Service.swift
//  to-do
//
//  Created by Павел Тимофеев on 04.07.2021.
//

import Foundation

typealias OnApiSuccess = (Todos) -> Void
typealias onErrors = (String) -> Void

class NetworkService {
    
    static let shared = NetworkService()
    
    let URL_BASE = "http://localhost:3003"
    let URL_ADD_TODO = "/add "

    let session = URLSession(configuration: .default)
    
    func getTodos(onSuccess: @escaping OnApiSuccess, onError: @escaping onErrors) {
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
    
    func addTodo(todo: Todo) {
        
    }
}
