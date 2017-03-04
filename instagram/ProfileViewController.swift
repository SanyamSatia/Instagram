//
//  ProfileViewController.swift
//  instagram
//
//  Created by Sanyam Satia on 3/3/17.
//  Copyright © 2017 Sanyam Satia. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            else {
                NotificationCenter.default.post(name: User.userDidLogoutNotification, object: nil)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
