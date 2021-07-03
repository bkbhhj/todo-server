//
//  ViewController.swift
//  to-do
//
//  Created by Павел Тимофеев on 03.07.2021.
//

import UIKit

class TodoVC: UIViewController {

    @IBOutlet var todoItemTxt: UITextField!
    
    @IBOutlet var prioritySegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func addTodo(_ sender: Any) {
    }
}

