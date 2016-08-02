//
//  LoginViewController.swift
//  GitHubOAuth
//
//  Created by Joel Bell on 7/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Locksmith
import SafariServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var imageBackgroundView: UIView!
    
    let numberOfOctocatImages = 10
    var octocatImages: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageViewAnimation()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(safariLogin), name: Notification.closeSafariVC, object: nil)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if imageBackgroundView.layer.cornerRadius == 0 {
            configureButton()
        }
    }
    
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let url = NSURL(string: GitHubAPIClient.URLRouter.oauth)!
        let safari = SFSafariViewController.init(URL: url)
        self.presentViewController(safari, animated: true, completion: nil)
        
    }
    
    
    func safariLogin(notification: NSNotification) {
        print("safari login")
        if let object = notification.object as? NSString {
            let splitObject = object.componentsSeparatedByString("githuboauthlab-12345://callback?code=")
            Secrets.userCode = splitObject[1]
            print("user code: \(Secrets.userCode)")
        } else {
            print(notification.object)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}


// MARK: Set Up View
extension LoginViewController {
    
    private func configureButton()
    {
        self.imageBackgroundView.layer.cornerRadius = 0.5 * self.imageBackgroundView.bounds.size.width
        self.imageBackgroundView.clipsToBounds = true
    }
    
    private func setUpImageViewAnimation() {
        
        for index in 1...numberOfOctocatImages {
            if let image = UIImage(named: "octocat-\(index)") {
                octocatImages.append(image)
            }
        }
        
        self.loginImageView.animationImages = octocatImages
        self.loginImageView.animationDuration = 2.0
        self.loginImageView.startAnimating()
        
    }
}







