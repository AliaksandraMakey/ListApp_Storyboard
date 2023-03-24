//
//  TaskCaretaker.swift
//  ListApp
//
//  Created by aaa on 24/03/2023.
//

import Foundation

final class TaskCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "task_"
    /// save
    func save(_ task: [Task]) {
        do {
            let data = try self.encoder.encode(task)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error) }
    }
    /// retrieve
    func retrieveTask() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try self.decoder.decode([Task].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
