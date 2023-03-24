//
//  ViewController.swift
//  ListApp
//
//  Created by aaa on 22/03/2023.
//

import UIKit


class TasksListViewController: UIViewController {
    
    var caretaker = TaskCaretaker()
    
    @IBOutlet var tasksTableView: UITableView!
    
    var tasks: [Task]?
    var subtask: Subtask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.title = "Tasks"
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        updateTasks()
    }
    // регулярные выражения like - частичное совпадение
    func updateTasks() {
        if tasks != nil {
            tasks!.removeAll()
        }
        tasks = caretaker.retrieveTask()
        tasksTableView.reloadData()
    }
    
    @IBAction func didTapAdd() {
         let vc = storyboard?.instantiateViewController(withIdentifier: "addTask") as! AddTaskViewController
        vc.title = "Add new task"
        vc.updateTask = { resultTask in
            DispatchQueue.main.async {
                self.tasks?.append(resultTask)
                self.tasksTableView.reloadData()
//                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension TasksListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "Subtasks") as! TaskViewController
       vc.title = "Subtasks"
        vc.task = tasks![indexPath.row]
       navigationController?.pushViewController(vc, animated: true)
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(tasks![indexPath.row].name)"
        return cell
    }
}
