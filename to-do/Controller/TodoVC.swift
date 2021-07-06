//
//  ViewController.swift
//  to-do
//
//  Created by Павел Тимофеев on 03.07.2021.
//

import UIKit

class TodoVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var todoItemTxt: UITextField!
    @IBOutlet var prioritySegment: UISegmentedControl!
    @IBOutlet var todoTable: UITableView!
    
    var todos = Array<Todo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTable.delegate = self
        todoTable.dataSource = self
        
        getTodos()
    }

    func getTodos() {
        NetworkService.shared.getTodos(onSuccess: {todos in
            self.todos = todos.items
            self.todoTable.reloadData()
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }

    }

    @IBAction func addTodo(_ sender: Any) {
        guard let todoItem = todoItemTxt.text else {return}
       
        let todo = Todo(item: todoItem, priority: prioritySegment.selectedSegmentIndex)
        NetworkService.shared.addTodo(todo: todo, onSuccess: {todos in
            self.todoItemTxt.text = ""
            self.todos = todos.items
            self.todoTable.reloadData()
        }, onError: { errorMessage in
            debugPrint(errorMessage)
        })
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
            cell.updateCell(todo: todos[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

