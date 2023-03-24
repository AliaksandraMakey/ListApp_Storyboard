//
//  Subtask.swift
//  ListApp
//
//  Created by aaa on 24/03/2023.
//

import UIKit

class Subtask: Codable {
    var ownerTask: Task
    var subtask: String
    init(_ subtask: String, _ task: Task) {
        self.subtask = subtask
        self.ownerTask = task
    }
}
