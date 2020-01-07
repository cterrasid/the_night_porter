//
//  Task.swift
//  the-night-porter_table-view
//
//  Created by Clarette Terrasi on 07/01/2020.
//  Copyright © 2020 Clarette Terrasi Díaz. All rights reserved.
//

import Foundation

// Create an enum to define the types of the tasks
enum TaskType {
    case daily, weekly, monthly
}

// Create an struct to define a model to the data? It uses the enum TaskType
struct Task {
    var name : String
    var type : TaskType
    var isCompleted : Bool
    var lastCompleted : NSDate?
}
