//
//  AppDelegate.swift
//  ActionButtonApp
//
//  Created by teklabsco on 12/20/15.
//  Copyright © 2015 Teklabs, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var networkStatus: Reachability.NetworkStatus?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // ****************************************************************************
        // Parse initialization
        Parse.setApplicationId("oUuHAfy2K9KHPOj12TumNGe7tx2GSbyhCXjHCz8o", clientKey: "fJ2fqkZ1lsRqXfRiS2z6EM2A7egK7xQQirnSx77J")
        PFFacebookUtils.initializeFacebook()
        //PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        // TODO: V4      PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        // ****************************************************************************
        
        //UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        
        // Use Reachability to monitor connectivity
        self.monitorReachability()
        
        
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
}

