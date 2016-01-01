//
//  ViewController.swift
//  ActionButtonApp
//
//  Created by teklabsco on 12/20/15.
//  Copyright © 2015 Teklabs, LLC. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    var logInViewController: PFLogInViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser() != nil) {
            ///self.presentLoggedInAlert()
            print("Logged in with user: ", PFUser.currentUser())
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        // No user logged in
        let signupButtonBackgroundImage: UIImage = getImageWithColor(UIColor.aTLBlueColor(), size: CGSize(width: 10.0, height: 10.0))
        
        // Create the log in view controller
        self.logInViewController = PFLogInViewController()
        
        self.logInViewController.logInView!.passwordForgottenButton!.setTitleColor(UIColor.aTLBlueColor(), forState: UIControlState.Normal)
        self.logInViewController.logInView!.signUpButton!.setBackgroundImage(signupButtonBackgroundImage, forState: UIControlState.Normal)
        self.logInViewController.logInView!.signUpButton!.backgroundColor = UIColor.aTLBlueColor()
        self.logInViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.logInViewController.fields = ([PFLogInFields.UsernameAndPassword, PFLogInFields.LogInButton, PFLogInFields.SignUpButton, PFLogInFields.PasswordForgotten])
        self.logInViewController.delegate = self
        let logoImageView: UIImageView = UIImageView(image: UIImage(named:"LayerParseLogin"))
        logoImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.logInViewController.logInView!.logo = logoImageView;
        
        // Create the sign up view controller
        let signUpViewController: PFSignUpViewController = PFSignUpViewController()
        signUpViewController.signUpView!.signUpButton!.setBackgroundImage(signupButtonBackgroundImage, forState: UIControlState.Normal)
        self.logInViewController.signUpController = signUpViewController
        signUpViewController.delegate = self
        let signupImageView: UIImageView = UIImageView(image: UIImage(named:"LayerParseLogin"))
        signupImageView.contentMode = UIViewContentMode.ScaleAspectFit
        signUpViewController.signUpView!.logo = signupImageView
        
        self.presentViewController(self.logInViewController,  animated: true, completion:nil)
    }
    
    // MARK - PFLogInViewControllerDelegate
    
    // Sent to the delegate to determine whether the log in request should be submitted to the server.
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username:String, password: String) -> Bool {
        if (!username.isEmpty && !password.isEmpty) {
            return true // Begin login process
        }
        
        let title = NSLocalizedString("Missing Information", comment: "")
        let message = NSLocalizedString("Make sure you fill out all of the information!", comment: "")
        let cancelButtonTitle = NSLocalizedString("OK", comment: "")
        UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: cancelButtonTitle).show()
        
        return false // Interrupt login process
    }
    
    
    // Sent to the delegate when a PFUser is logged in.
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        //self.loginLayer()
        print("Made it to login....success")
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        if let description = error?.localizedDescription {
            let cancelButtonTitle = NSLocalizedString("OK", comment: "")
            UIAlertView(title: description, message: nil, delegate: nil, cancelButtonTitle: cancelButtonTitle).show()
        }
        print("Failed to log in...")
    }
    
    // MARK: - PFSignUpViewControllerDelegate
    
    // Sent to the delegate to determine whether the sign up request should be submitted to the server.
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        var informationComplete: Bool = true
        
        // loop through all of the submitted data
        for (key, _) in info {
            if let field = info[key] as? String {
                if field.isEmpty {
                    informationComplete = false
                    break
                }
            }
        }
        
        // Display an alert if a field wasn't completed
        if (!informationComplete) {
            let title = NSLocalizedString("Signup Failed", comment: "")
            let message = NSLocalizedString("All fields are required", comment: "")
            let cancelButtonTitle = NSLocalizedString("OK", comment: "")
            UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: cancelButtonTitle).show()
        }
        
        return informationComplete;
    }
    
    // Sent to the delegate when a PFUser is signed up.
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        //self.loginLayer()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("Failed to sign up...")
    }
    
    /*
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        presentLoggedInAlert()
    }
    
    func presentLoggedInAlert() {
        let alertController = UIAlertController(title: "You're logged in", message: "Welcome to ActionButtonApp", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
*/
    

    
    // MARK - Helper function
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

