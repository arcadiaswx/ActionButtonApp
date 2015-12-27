//
//  Main1ViewController.swift
//  MHImageTabBar
//
//  Created by Mohamed Mohamed on 16/10/15.
//  Copyright © 2015 MHO. All rights reserved.
//

import UIKit
import ActionButton

class Main1ViewController: UIViewController {
    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var tableView: UITableView!
    
        let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    
    //@IBOutlet var segmentedControl: UISegmentedControl!
    var actionButton: ActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var controllerArray : [UIViewController] = []
        self.navigationItem.title = "ActionButtonApp"
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.navigationBarTitleTextColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor.navigationBarBackgroundColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = false
        
        // Do any additional setup after loading the view.
        let oneImage = UIImage(named: "one.png")!
        let twoImage = UIImage(named: "two.png")!
        
        let oneButton = ActionButtonItem(title: "Add Item", image: oneImage)
        oneButton.action = { item in print("Action Item 1...") }
        
        let twoButton = ActionButtonItem(title: "Item List", image: twoImage)
        twoButton.action = { item in print("Action Item 2...") }
        
        actionButton = ActionButton(attachedToView: self.view, items: [oneButton, twoButton])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: .Normal)
        
        actionButton.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 34.0/255.0, alpha:1.0)
        
        //segmentedControl.selectedSegmentIndex = 0
    }
    
    /*
    @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            mhTabBarViewController?.setTabBarVisible(true, animated: true)
        } else {
            mhTabBarViewController?.setTabBarVisible(false, animated: true)
        }
    }
   */
}
extension Main1ViewController: UITableViewDelegate {
}

extension Main1ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}