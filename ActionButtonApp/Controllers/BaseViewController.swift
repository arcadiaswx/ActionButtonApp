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
        var controllerArray : [UIViewController] = []
        self.navigationItem.title = "ActionButtonApp"
        
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


        let teamsShot = ShotCollectionViewController(nibName: "ShotCollectionViewController", bundle: nil)
        teamsShot.title = "My List"
        teamsShot.API_URL = Config.TEAMS_URL
        teamsShot.loadShots()
        controllerArray.append(teamsShot)
        
        let reboundsShot = ShotCollectionViewController(nibName: "ShotCollectionViewController", bundle: nil)
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

}
