//
//  AppDelegate.swift
//  ActionButtonApp
//
//  Created by teklabsco on 12/20/15.
//  Copyright © 2015 Teklabs, LLC. All rights reserved.
//

import UIKit
import Parse
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //var controller: ViewController!
    var networkStatus: Reachability.NetworkStatus?
    var navController: UINavigationController?
    
    //let LayerAppIDString: NSURL! = NSURL(string: "layer:///apps/staging/2fd26bbe-af1f-11e5-8f20-999c060029bf")
    let ParseAppIDString: String = "oUuHAfy2K9KHPOj12TumNGe7tx2GSbyhCXjHCz8o"
    let ParseClientKeyString: String = "fJ2fqkZ1lsRqXfRiS2z6EM2A7egK7xQQirnSx77J"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        setupParse()
        setupAppearance()
        Settings.registerDefaults()
        
        // Show View Controller
        //controller = ViewController()
        
        // Use Reachability to monitor connectivity
        self.monitorReachability()
        
        let userDefaults = NSUserDefaults.groupUserDefaults()
        
 
        /*
        self.window!.rootViewController = UINavigationController(rootViewController: controller)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        */
        
        
        
        if (!userDefaults.boolForKey(ComplexConstants.General.OnboardingShown.key())) {
            
            loadOnboardingInterface()
            
        } else if (PFUser.currentUser() != nil) {
            print("Else, else")
            loadMainInterface()
            checkVersion()
            
        }
        
            /*
        else {
            print("Else, else")
            loadLoginInterface()
            checkVersion()
        }
        */
        
       Fabric.with([Twitter.self])
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    /**
     Check the app version and perform required tasks when upgrading
     */
    func checkVersion() {
        let userDefaults = NSUserDefaults.groupUserDefaults()
        let current = userDefaults.integerForKey("BUNDLE_VERSION")
        if let versionString = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String, let version = Int(versionString) {
            if current < 13 {
                NotificationHelper.rescheduleNotifications()
            }
            userDefaults.setInteger(version, forKey: "BUNDLE_VERSION")
            userDefaults.synchronize()
        }
    }
    
    func isParseReachable() -> Bool {
        return self.networkStatus != .NotReachable
    }


    func monitorReachability() {
        guard let reachability = Reachability(hostname: "api.parse.com") else {
            return
        }
        
        reachability.whenReachable = { (reach: Reachability) in
            self.networkStatus = reach.currentReachabilityStatus
            if (self.isParseReachable() && PFUser.currentUser() != nil) {
            //if self.isParseReachable() && PFUser.currentUser() != nil && self.homeViewController!.objects!.count == 0 {
                // Refresh home timeline on network restoration. Takes care of a freshly installed app that failed to load the main timeline under bad network conditions.
                // In this case, they'd see the empty timeline placeholder and have no way of refreshing the timeline unless they followed someone.
                //self.homeViewController!.loadObjects()
            }
        }
        reachability.whenUnreachable = { (reach: Reachability) in
            self.networkStatus = reach.currentReachabilityStatus
        }
        
        reachability.startNotifier()
    }
    
    
    
    /**
     Present the onboarding controller if needed
     */
    func loadOnboardingInterface() {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() {
            self.window?.rootViewController = controller
        }
    }
    
    /**
     Present the login controller if needed
     */
    func loadLoginInterface() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() {
            self.window?.rootViewController = controller
        }
    }
    
    /**
     Present the main interface
     */
    func loadMainInterface() {
        //realmNotification = watchConnectivityHelper.setupWatchUpdates()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() {
            self.window?.rootViewController = controller
        }
    }

    /**
     Sets the main appearance of the app
     */
    func setupAppearance() {
        Globals.actionSheetAppearance()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        UITabBar.appearance().tintColor = .mainColor()
        
        if let font = UIFont(name: "KaushanScript-Regular", size: 22) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        
        UINavigationBar.appearance().barTintColor = .mainColor()
        UINavigationBar.appearance().tintColor = .whiteColor()
        
        window?.backgroundColor = .whiteColor()
    }

    
    func logOut() {
        // clear cache
        Cache.sharedCache.clear()
        
        // clear NSUserDefaults
        NSUserDefaults.standardUserDefaults().removeObjectForKey(kUserDefaultsCacheFacebookFriendsKey)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(kUserDefaultsActivityFeedViewControllerLastRefreshKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // Unsubscribe from push notifications by removing the user association from the current installation.
        PFInstallation.currentInstallation().removeObjectForKey(kInstallationUserKey)
        PFInstallation.currentInstallation().saveInBackground()
        
        // Clear all caches
        PFQuery.clearAllCachedResults()
        
        // Log out
        PFUser.logOut()
        //FBSession.setActiveSession(nil)
        // V4???       FBSDKAccessToken.currentAccessToken().tokenString
        
        // clear out cached data, view controllers, etc
        navController!.popToRootViewControllerAnimated(false)
        
        loadLoginInterface()
        
        //self.homeViewController = nil;
        //self.activityViewController = nil;
    }
    
    func setupParse() {
        // Enable Parse local data store for user persistence
        
        Parse.enableLocalDatastore()
        Parse.setApplicationId(ParseAppIDString, clientKey: ParseClientKeyString)


        // Set default ACLs
        let defaultACL: PFACL = PFACL()
        //defaultACL.setPublicReadAccess(true)
        //defaultACL.setReadAccess(true, forRoleWithName: Public)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
    }
}

