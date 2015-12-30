//
//  NotificationsViewController.swift
//  ActionButtonApp
//
//  Created by teklabsco on 12/22/15.
//  Copyright © 2015 Teklabs, LLC. All rights reserved.
//

import Foundation



class NotificationsViewController: UIViewController {
    var notification:Notification?
    var notificationToPass:Notification?
    //var notifs:[Notification] = []
    @IBOutlet weak var tableView: UITableView!
            let notifItems = ["Notif Item 1", "Notif Item 2", "Notif Item 3", "Notif Item 4", "Notif Item 5"]
    @IBAction func dissmissNotifications() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNotificationsDetailViewController" {
            notification = Notification(name: nameTextField.text, category:category, note: noteTextField.text)
        }
        /*
        if segue.identifier == "PickCategory" {
            if let categoryPickerViewController = segue.destinationViewController as? CategoryPickerViewController {
                categoryPickerViewController.selectedCategory = category
            }
        }
        */
    }
*/
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNotificationsDetailViewController" {
            var vc = segue.destinationViewController as! NotificationsDetailViewController
            vc.notificationToReceive = notificationToPass
            //notification = Notification(data: Notification))
            //let controller = segue.destinationViewController
            //controller.transitioningDelegate = self
            //controller.modalPresentationStyle = .Custom
            //userDefaults.setBool(true, forKey: "FEEDBACK")
            //userDefaults.synchronize()
        }
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
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //self.presentViewController(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        //var notif = notifications(indexPath)
        //notification = notifications(indexPath)
        //self.prepareForSegue(segue: showNotificationsDetailViewController, sender: AnyObject?)
        print("You have selected cell #\(indexPath.row)!")
        self.performSegueWithIdentifier("showNotificationsDetailViewController", sender: self)
        //self.presentViewController(viewControllerToPresent: NotificationsDetailViewController, animated: true, completion: nil)
    }
    
}