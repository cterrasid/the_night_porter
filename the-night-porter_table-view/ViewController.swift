//
//  ViewController.swift
//  the-night-porter_table-view
//
//  Created by Clarette Terrasi on 27/12/2019.
//  Copyright © 2019 Clarette Terrasi Díaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    @IBOutlet weak var taskTableView: UITableView!
    
    
    // MARK: OPTION 1. Create [String] arrays of tasks. It's a simple way to begin, but it's better with OPTION 2...
    //    let dailyTasks = ["Check all windows",
    //                      "Check all doors",
    //                      "Is the boiler fueled?",
    //                      "Check the mailbox",
    //                      "Empty trash containers",
    //                      "If freezing, check water pipes",
    //                      "Document \"strange and unusual\" occurrences",]
    //
    //    let weeklyTasks = ["Check inside all cabins",
    //                       "Flush all lavatories in cabins",
    //                       "Walk the perimeter of property",
    //                       ]
    //
    //    let monthlyTasks = ["Test security alarm",
    //                        "Test motion detectors",
    //                        "Test smoke alarms",
    //                        ]
    
    // MARK: OPTION 2. Create arrays of strings instances of Task
    var dailyTasks = [
        Task(name: "Check all windows", type: .daily, isCompleted: false, lastCompleted: nil),
        Task(name: "Check all doors", type: .daily, isCompleted: false, lastCompleted: nil),
        Task(name: "Is the boiler fueled?", type: .daily, isCompleted: false, lastCompleted: nil),
        Task(name: "Check the mailbox", type: .daily, isCompleted: false, lastCompleted: nil),
        Task(name: "Empty trash containers", type: .daily, isCompleted: false, lastCompleted: nil),
        Task(name: "If freezing, check water pipes", type: .daily, isCompleted: false, lastCompleted: nil),
        Task(name: "Document \"strange and unusual\" occurrences", type: .daily, isCompleted: false, lastCompleted: nil)
    ]
    
    var weeklyTasks = [
        Task(name: "Check inside all cabins", type: .weekly, isCompleted: false, lastCompleted: nil),
        Task(name: "Flush all lavatories in cabins", type: .weekly, isCompleted: false, lastCompleted: nil),
        Task(name: "Walk the perimeter of property", type: .weekly, isCompleted: false, lastCompleted: nil)
    ]
    
    var monthlyTasks = [
        Task(name: "Test security alarm", type: .monthly, isCompleted: false, lastCompleted: nil),
        Task(name: "Test motion detectors", type: .monthly, isCompleted: false, lastCompleted: nil),
        Task(name: "Test smoke alarms", type: .monthly, isCompleted: false, lastCompleted: nil)
    ]
    
    // MARK: Methods
    @IBAction func toggleDarkMode(_ sender: Any) {
        let mySwitch = sender as! UISwitch
        if mySwitch.isOn {
            view.backgroundColor = UIColor.darkGray
        } else {
            view.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func resetList(_ sender: Any) {
        // Sow a pop-up whe reset the list. I need to define:
        // first, the container of the alert with the UIAlertController
        let confirm = UIAlertController(title: "Are you sure?", message: "Really reset the list?", preferredStyle: .alert)
        
        // second, the actions of the alert with UIAlertAction
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) {
            action in
            for i in 0..<self.dailyTasks.count {
                self.dailyTasks[i].isCompleted = false
            }
            
            for i in 0..<self.weeklyTasks.count {
                self.weeklyTasks[i].isCompleted = false
            }
            
            for i in 0..<self.monthlyTasks.count {
                self.monthlyTasks[i].isCompleted = false
            }
            
            //Update this info in the table
            self.taskTableView.reloadData()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) {
            action in
            print("That was a close one!")
        }
        
        // add actions to the alert controller
        confirm.addAction(yesAction)
        confirm.addAction(noAction)
        
        // show the alert
        present(confirm, animated: true, completion: nil)
    }
    
    
    // MARK: Table View Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected row \(indexPath.row) in section \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create a new action object with an instance of UIContextualAction, an enum in whichI set this parameters:
        // - style: .normal, because if I set it as .destructive, the backgroundColor will be red
        // - title: a string with the label of the button
        let completeAction = UIContextualAction(style: .normal, title: "Complete") { (action: UIContextualAction, view: UIView, actionPerformed: (Bool) -> Void) in
            // find the right object and set it to completed
            switch indexPath.section {
            case 0:
                self.dailyTasks[indexPath.row].isCompleted = true
            case 1:
                self.weeklyTasks[indexPath.row].isCompleted = true
            case 2:
                self.monthlyTasks[indexPath.row].isCompleted = true
            default:
                break
            }
            
            // The tableView must to refresh itself, to make sure it updates the cell when it's needed
            tableView.reloadData()
            
            actionPerformed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    // MARK: Table View Data Source Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        // Set transparent color to each section of the tableView
        tableView.backgroundColor = UIColor.clear
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dailyTasks.count
        case 1:
            return weeklyTasks.count
        case 2:
            return monthlyTasks.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. Traditional way: Instantiate a new Table View Cell
        //let cell = UITableViewCell()
        
        // 2. Dequeuing and reusing cells:
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell", for: indexPath)
        
        //Set the description of each cell
        cell.detailTextLabel?.text = "Description of the task"
        
        // OPTION 1 to set all the tasks
//        switch indexPath.section {
//        case 0:
//            cell.textLabel?.text = dailyTasks[indexPath.row]
//        case 1:
//            cell.textLabel?.text = weeklyTasks[indexPath.row]
//        case 2:
//            cell.textLabel?.text = monthlyTasks[indexPath.row]
//        default:
//            cell.textLabel?.text = "This shouldn't happen"
//        }
        
        //OPTION 2  to hold the current task
        var currentTask: Task!
        
        switch indexPath.section {
        case 0:
            currentTask = dailyTasks[indexPath.row]
        case 1:
            currentTask = weeklyTasks[indexPath.row]
        case 2:
            currentTask = monthlyTasks[indexPath.row]
        default:
            break
        }
        
        // OPTION 2: Use the name property to set the value of each cell
        cell.textLabel!.text = currentTask.name
        
        // Condition when isCompleted is true
        if currentTask.isCompleted {
            cell.textLabel?.textColor = UIColor.lightGray
            cell.detailTextLabel?.textColor = UIColor.lightGray
            cell.accessoryType = .checkmark
        } else {
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
            cell.accessoryType = .none
        }
        
        // Set transparent color to each cell
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Daily Tasks"
        case 1:
            return "Weekly Tasks"
        case 2:
            return "Monthly Tasks"
        default:
            return nil
        }
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        self.title = "List of tasks"
//    }

}

