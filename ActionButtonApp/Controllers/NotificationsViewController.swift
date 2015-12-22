//
//  NotificationsViewController.swift
//  ActionButtonApp
//
//  Created by teklabsco on 12/22/15.
//  Copyright © 2015 Teklabs, LLC. All rights reserved.
//

import Foundation



class NotificationsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
            let notifItems = ["Notif Item 1", "Notif Item 2", "Notif Item 3", "Notif Item 4", "Notif Item 5"]
    @IBAction func dissmissNotifications() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
    
extension NotificationsViewController: UITableViewDelegate {
    
}

extension NotificationsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = notifItems[indexPath.row]
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}