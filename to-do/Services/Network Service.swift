//
//  Network Service.swift
//  to-do
//
//  Created by Павел Тимофеев on 04.07.2021.
//

import Foundation


class NetworkService {
    
    static let shared = NetworkService()
    
    let URL_BASE = "http://localhost:3003"
    let URL_ADD_TODO = "/add "

    let session = URLSession(configuration: .default)
    
    func getTodos() {
        guard let url = URL(string: "\(URL_BASE)") else {return}
        
        let task = session.dataTask(with: url) { (data, response, error) in
            debugPrint(data)
     
        }
        task.resume()
    }
    
    func addTodo(todo: Todo) {
        
    }
}
