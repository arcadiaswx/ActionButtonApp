//
//  Main1ViewController.swift
//
//

import UIKit
import ActionButton

class BaseViewController: UIViewController {
    var pageMenu : CAPSPageMenu?
     
    var actionButton: ActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForUser()
        
        var controllerArray : [UIViewController] = []
        self.navigationItem.title = "ActionButtonApp"
        self.navigationItem.rightBarButtonItem = SettingsButtonItem(target: self, action: Selector("settingsButtonAction:"))
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.navigationBarTitleTextColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor.navigationBarBackgroundColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = false

        ///
        
        let popularShot = PrayerCollectionViewController(nibName: "PrayerCollectionViewController", bundle: nil)
        popularShot.title = "Today"
        popularShot.API_URL = Config.POPULAR_URL
        popularShot.parentNavigationController = self.navigationController!
        popularShot.loadShots()
        controllerArray.append(popularShot)


        let teamsShot = PrayerCollectionViewController(nibName: "PrayerCollectionViewController", bundle: nil)
        teamsShot.title = "My List"
        teamsShot.API_URL = Config.TEAMS_URL
        teamsShot.loadShots()
        controllerArray.append(teamsShot)
        
        let reboundsShot = PrayerCollectionViewController(nibName: "PrayerCollectionViewController", bundle: nil)
        reboundsShot.title = "Trending"
        reboundsShot.API_URL = Config.REBOUNDS_URL
        reboundsShot.loadShots()
        controllerArray.append(reboundsShot)
        
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor.scrollMenuBackgroundColor()),
            .ViewBackgroundColor(UIColor.viewBackgroundColor()),
            .SelectionIndicatorColor(UIColor.selectionIndicatorColor()),
            .BottomMenuHairlineColor(UIColor.bottomMenuHairlineColor()),
            .SelectedMenuItemLabelColor(UIColor.selectedMenuItemLabelColor()),
            .UnselectedMenuItemLabelColor(UIColor.unselectedMenuItemLabelColor()),
            .SelectionIndicatorHeight(2.0),
            .MenuItemFont(UIFont(name: "HiraKakuProN-W6", size: 13.0)!),
            .MenuHeight(34.0),
            .MenuItemWidth(80.0),
            .MenuMargin(0.0),
            // "useMenuLikeSegmentedControl": true,
            .MenuItemSeparatorRoundEdges(true),
            // "enableHorizontalBounce": true,
            // "scrollAnimationDurationOnMenuItemTap": 300,
            .CenterMenuItems(true)]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
        
        ///
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
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser() != nil) {
            ///self.presentLoggedInAlert()
            print("Logged in with user: ", PFUser.currentUser())
            //self.dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    func checkForUser() {
        if (PFUser.currentUser() == nil) {
            ///self.presentLoggedInAlert()
            print("Not logged in...", PFUser.currentUser())
            //self.nav
            self.dismissViewControllerAnimated(true, completion: nil)
            //self.navigationController!.pushViewController(AccountViewController,animated: true)
        }
        print("Logged in with ....: ", PFUser.currentUser())
    }

    func settingsButtonAction(sender: AnyObject) {
        
        
        let actionController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let myProfileAction = UIAlertAction(title: NSLocalizedString("My Profile", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in
            self.navigationController!.pushViewController(AccountViewController(user: PFUser.currentUser()!), animated: true)
        })
        let logOutAction = UIAlertAction(title: NSLocalizedString("Log Out", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in
            // Log out user and present the login view controller
            (UIApplication.sharedApplication().delegate as! AppDelegate).logOut()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        actionController.addAction(myProfileAction)
        actionController.addAction(logOutAction)
        actionController.addAction(cancelAction)
        
        //let accountViewController: AccountViewController = AccountViewController(user: PFUser.currentUser()!), animated:true)
        self.presentViewController(actionController, animated: true, completion: nil)
    }
    
}
