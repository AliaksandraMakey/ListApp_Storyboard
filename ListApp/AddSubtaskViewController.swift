//
//  AddSubtaskViewController.swift
//  ListApp
//
//  Created by aaa on 23/03/2023.
//

import UIKit

class AddSubtaskViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var fieldSubtask: UITextField!
    var updateSubtask: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        fieldSubtask.delegate = self
        navigationItem.titleView?.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save Subtask", style: .done, target: self, action: #selector(saveSubtask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveSubtask()
        return true
    }
    
    @objc func saveSubtask() {
        
        guard let text = fieldSubtask.text,
              !text.isEmpty else {return}
        
        guard let count = UserDefaults().value(forKey: "countSubtask") as? Int else {return}
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "countSubtask")
        UserDefaults().set(text, forKey: "subtask_\(newCount)")
        
        updateSubtask?()
        
        navigationController?.popViewController(animated: true)
    }
}
