//
//  TodoCell.swift
//  to-do
//
//  Created by Павел Тимофеев on 03.07.2021.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var priorityView: UIView!
    
    func updateCell(todo: Todo) {
        itemLabel.text = todo.item
        switch todo.priority {
        case 0:
            priorityView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            break
        case 1:
            priorityView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        default:
            priorityView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
    }
}
