//
//  AddTaskViewController.swift
//  ListApp
//
//  Created by aaa on 22/03/2023.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    var caretaker = TaskCaretaker()
    
    @IBOutlet var fieldTask: UITextField!
    var updateTask: ((Task) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        fieldTask.delegate = self
        navigationItem.titleView?.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save Task", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask() {
        guard let text = fieldTask.text,
              !text.isEmpty else {return}
        caretaker.save([Task(text)])
     
        
        updateTask?(Task(text))
        navigationController?.popViewController(animated: true)
    }
}
