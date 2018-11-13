//
//  ViewController.swift
//  SwiftGuide
//
//  Created by ticsmatic on 2018/10/18.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var dataArray = [
        "Tour",
        "The Basics",
        "Basic Operators",
        "Strings and Characters",
        "Collection Types",
        "Control Flow",
        "Functions",
        "Closures",
        "Enumerations",
        "Structures and Classes",
        "Properties",
        "Methods",
        "Subscripts",
        "Inheritance",
        "Initialization",
        "Deinitialization",
        "Optional Chaining",
        "Error Handling",
        "Type Casting",
        "Nested Types",
        "Extensions",
        "Protocols",
        "Generics",
        "Automatic Reference Counting",
        "Memory Safety",
        "Access Control",
        "Advanced Operators"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }

    func setupUI() {
        tableView = UITableView(frame:self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        self.view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let controller = TourViewController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 1 {
            let controller = TheBasicsViewController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 2 {
            let controller = BasicOperatorsController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 3 {
            let controller = StringsAndCharactersController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 4 {
            let controller = CollectionTypesController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 5 {
            let controller = ControlFlowController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 6 {
            let controller = FunctionsController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 7 {
            let controller = ClosuresController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 8 {
            let controller = EnumerationsController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 9 {
            let controller = StructuresAndClassesController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 10 {
            let controller = PropertiesController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 11 {
            let controller = MethodsController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 12 {
            let controller = SubscriptsController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 13 {
            let controller = InheritanceController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 14 {
            let controller = InitializationController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 15 {
            let controller = DeinitializationController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 16 {
            let controller = OptionalChainingController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 17 {
            let controller = ErrorHandlingController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 18 {
            let controller = TypeCastingController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 19 {
            let controller = NestedTypesController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 20 {
            let controller = ExtensionsController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 21 {
            let controller = ProtocolsController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 22 {
            let controller = GenericsController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 23 {
            let controller = AutomaticReferenceCountingController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 24 {
            let controller = MemorySafetyController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 25 {
            let controller = AccessControlController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 26 {
            let controller = AdvancedOperatorsController.init()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

