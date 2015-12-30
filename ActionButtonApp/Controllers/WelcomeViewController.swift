import UIKit
//import Synchronized
//import Parse
//import ParseFacebookUtilsV4

var appIntroStatus:String?
var welcomeView:WelcomeViewController?
var appIntroViewController:AppIntroViewController?

let kAppIntroStatus:String = "0"
let BLANK_STATUS:String = "(New Status)"

var user: PFObject?
var newUser: Bool?
var userIsNew: Bool?

class WelcomeViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    private var _presentedLoginViewController: Bool = false
    private var _facebookResponseCount: Int = 0
    private var _expectedFacebookResponseCount: Int = 0
    private var _profilePicData: NSMutableData? = nil

    // MARK:- UIViewController
    override func loadView() {
        let backgroundImageView: UIImageView = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImageView.image = UIImage(named: "Default.png")
        self.view = backgroundImageView
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (PFUser.currentUser() == nil) {
            let loginViewController = LoginViewController()
            loginViewController.delegate = self
            loginViewController.fields = [.UsernameAndPassword, .LogInButton, .PasswordForgotten, .SignUpButton, .Facebook, .Twitter]
            loginViewController.emailAsUsername = true
            loginViewController.signUpController?.emailAsUsername = true
            loginViewController.signUpController?.delegate = self
            self.presentViewController(loginViewController, animated: false, completion: nil)
        } else {
            presentLoggedInAlert()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        presentLoggedInAlert()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        presentLoggedInAlert()
    }
    
    func presentLoggedInAlert() {
        let alertController = UIAlertController(title: "You're logged in", message: "Welcome to Vay.K", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }




    // MARK:- NSURLConnectionDataDelegate
/*
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        _profilePicData = NSMutableData()
    }

    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        _profilePicData!.appendData(data)
    }

    func connectionDidFinishLoading(connection: NSURLConnection) {
        PAPUtility.processFacebookProfilePictureData(_profilePicData!)
    }

    // MARK:- NSURLConnectionDelegate
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        print("Connection error downloading profile pic data: \(error)")
    }
*/
}
