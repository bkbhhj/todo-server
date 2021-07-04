//
//  todo.swift
//  to-do
//
//  Created by Павел Тимофеев on 04.07.2021.
//

import Foundation

struct Todos: Codable {
    let items: Array<Todo>
    
}

struct Todo: Codable {
    let item: String
    let priority: Int
    
}

