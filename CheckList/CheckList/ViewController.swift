//
//  ViewController.swift
//  CheckList
//
//  Created by JunHeeJo on 10/23/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    var tasks = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    var doneButton: UIBarButtonItem?

    // MARK: @IBOutlet
    // weak면 done button으로 변경시 edit button이 사라지므로 strong
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: @IBAction
    @IBAction func tapEditButton(_ sender: UIBarButtonItem) {
        // 비어있으면 편집모드 X
        guard !self.tasks.isEmpty else {
            return
        }
        
        self.navigationItem.leftBarButtonItem = self.doneButton
        self.tableView.setEditing(true, animated: true)
    }
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        let alert: UIAlertController = UIAlertController(title: "등록", message: nil, preferredStyle: .alert)
        let registerButton: UIAlertAction = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            // debugPrint(alert.textFields?.first?.text)
            guard let title = alert.textFields?.first?.text else { return }
            let task: Task = Task(title: title, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData()
        })
        let cancelButton: UIAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(registerButton)
        alert.addAction(cancelButton)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "할 일을 입력해주세요."
            
        })
        present(alert, animated: true, completion: nil)
    }
    
    func saveTasks() {
        let data = tasks.map {
            [
                "title": $0.title,
                "done": $0.done
            ]
        }
        UserDefaults.standard.set(data, forKey: "tasks")
    }
    
    func loadTasks() {
        guard let data = UserDefaults.standard.object(forKey: "tasks") as? [[String: Any]] else { return }
        self.tasks = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return Task(title: title, done: done)
        }
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        tableView.dataSource = self
        tableView.delegate = self
        self.loadTasks()
    }
    
    @objc func tapDoneButton() {
        navigationItem.leftBarButtonItem = editButton
        tableView.setEditing(false, animated: true)
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.title
        
        if task.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if tasks.isEmpty {
            tapDoneButton()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tasks = self.tasks
        let task = tasks[sourceIndexPath.row]
        
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        
        self.tasks = tasks
    }
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasks[indexPath.row].done = !tasks[indexPath.row].done
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
