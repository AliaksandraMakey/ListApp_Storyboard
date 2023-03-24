//
//  AddSubtasksViewController.swift
//  ListApp
//
//  Created by aaa on 22/03/2023.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var taskLabel: UILabel!
    @IBOutlet var subtasksTableView: UITableView!
    
    var task: Task?
    var subtasks = [Subtask]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.title = "Subtasks"
        taskLabel.text = task!.name
        subtasksTableView.delegate = self
        subtasksTableView.dataSource = self
        
        /// SetupSubtask
        if !UserDefaults().bool(forKey: "setupSubtask") {
            UserDefaults().set(true, forKey: "setupSubtask")
            UserDefaults().set(0, forKey: "countSubtask")
        }
        updateSubtasks()
    }
    
    func updateSubtasks() {
        subtasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "countSubtask") as? Int else {return}
        
        for x in 0..<count {
            if let subtask = UserDefaults().value(forKey: "subtask_\(x+1)") as? String {
                subtasks.append(Subtask(subtask, task!))
            }
        }
        subtasksTableView.reloadData()
    }
    
    @IBAction func didTapAddSubtask() {
         let vc = storyboard?.instantiateViewController(withIdentifier: "addSubtask") as! AddSubtaskViewController
        vc.title = "Add new subtask"
        vc.updateSubtask = {
            DispatchQueue.main.async {
                self.updateSubtasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}
extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subtasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subTaskCell", for: indexPath)
         let task = subtasks[indexPath.row].subtask
        cell.textLabel?.text = "\(task)"
        return cell
    }
    
    
}
