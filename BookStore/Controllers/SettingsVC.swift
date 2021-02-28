//
//  SettingsVC.swift
//  BookStore
//
//  Created by adol kazmy on 28/02/2021.
//

import UIKit


class SettingsVC: UIViewController {
    
    

    @IBAction func twitterPressed(_ sender: Any) {
            let screenName =  "AdelAwlaqi"
            let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
            let webURL = NSURL(string: "https://twitter.com/\(screenName)")!

            let application = UIApplication.shared

            if application.canOpenURL(appURL as URL) {
                application.openURL(appURL as URL)
            } else {
                application.openURL(webURL as URL)
            }
    }
    
    
}
