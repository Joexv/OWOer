//
//  TableViewController.swift
//  OWOer
//
//  Created by Joe Oliveira on 7/5/19.
//  Copyright © 2019 Alternative Apps Unlimited. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import NotificationBannerSwift

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delaySwitch.isOn = defaults.bool(forKey: "delaySend")
        if #available(iOSApplicationExtension 11.0, *){
            delaySwitch.isEnabled = true
        }else{
            delaySwitch.isEnabled = false
            delaySwitch.isOn = false
            defaults.set(false, forKey: "sendDelay")
        }
        
        clapperBoi.isOn = defaults.bool(forKey: "iGotTheClaps")
        clearSwitch.isOn = defaults.bool(forKey: "delaySend")
        
        capsSwitch.isOn = defaults.bool(forKey: "capsRandom")
        prefixSwitch.isOn = defaults.bool(forKey: "oldPrefix")
        spellSwitch.isOn = defaults.bool(forKey: "spellCheck")
        
        if(defaults.bool(forKey: "Ad_Removal")){
            adButt.titleLabel?.text = "Thank you for supporting us!"
            adButt.isEnabled = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(defaults.bool(forKey: "Ad_Removal")){
            adButt.titleLabel?.text = "Thank you for supporting us!"
            adButt.isEnabled = false
        }
        super.viewDidAppear(true)
    }

    @IBOutlet weak var adButt: UIButton!
    let NBQ = NotificationBannerQueue()
    func showBanner(_ Title: String, _ Text: String = "", _ Error: Bool = false){
        NBQ.removeAll()
        let banner = NotificationBanner(title: Title, subtitle: Text, style: (Error ? BannerStyle.danger : BannerStyle.success))
        banner.show(queue: NBQ)
    }
    let group = UserDefaults.init(suiteName: "group.OWO")
    @IBAction func removeAdButt(_ sender: Any) {
        if(!(group?.bool(forKey: "Unlocked") ?? false)){
            BuyProd()
        }
        
        if(defaults.bool(forKey: "Ad_Removal")){
            adButt.titleLabel?.text = "Thank you for supporting us!"
            adButt.isEnabled = false
        }
    }
    @IBAction func restoreButt(_ sender: Any) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                print("Restore Failed: \(results.restoreFailedPurchases)")
                self.showBanner("Failed!", "Error: \(results.restoreFailedPurchases)", false)
            }
            else if results.restoredPurchases.count > 0 {
                self.showBanner("Success!", "Ads will be removed when you restart the app")
                print("Restore Success: \(results.restoredPurchases)")
                self.defaults.set(true, forKey: "Ad_Removal")
                self.group?.set(true, forKey: "Unlocked")
            }
            else {
                self.showBanner("Failed!", "No purchases found on this account!", false)
            }
        }
    }
    
    let defaults = UserDefaults.standard
    
    func BuyProd(){
        SwiftyStoreKit.purchaseProduct("Ad_Removal", quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                self.showBanner("Success!", "Ads will be removed when you restart the app")
                self.defaults.set(true, forKey: "Ad_Removal")
                self.group?.set(true, forKey: "Unlocked")
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                case .privacyAcknowledgementRequired:
                    print("Unknown Error")
                case .unauthorizedRequestData:
                    print("Unknown Error")
                case .invalidOfferIdentifier:
                    print("Unknown Error")
                case .invalidSignature:
                    print("Unknown Error")
                case .missingOfferParams:
                    print("Unknown Error")
                case .invalidOfferPrice:
                    print("Unknown Error")
                @unknown default:
                    print("Unknown Error")
                }
            }
        }
    }
    
    @IBOutlet weak var capsSwitch: UISwitch!
    @IBAction func capsRandom(_ sender: Any) {
        defaults.set(capsSwitch.isOn, forKey: "capsRandom")
        group?.set(capsSwitch.isOn, forKey: "capsRandom")
    }

    @IBOutlet weak var prefixSwitch: UISwitch!
    @IBAction func prefixChange(_ sender: Any) {
        defaults.set(prefixSwitch.isOn, forKey: "oldPrefix")
        group?.set(prefixSwitch.isOn, forKey: "oldPrefix")
    }
    @IBOutlet weak var spellSwitch: UISwitch!
    @IBAction func spellChange(_ sender: Any) {
        defaults.set(spellSwitch.isOn, forKey: "spellCheck")
        group?.set(spellSwitch.isOn, forKey: "spellCheck")
    }
    
    @IBOutlet weak var clapperBoi: UISwitch!
    @IBAction func iGotTheClaps(_ sender: Any) {
        defaults.set(clapperBoi.isOn, forKey: "iGotTheClaps")
        group?.set(clapperBoi.isOn, forKey: "iGotTheClaps")
    }
    @IBOutlet weak var delaySwitch: UISwitch!
    @IBAction func delayChange(_ sender: Any) {
        defaults.set(delaySwitch.isOn, forKey: "delaySend")
        group?.set(delaySwitch.isOn, forKey: "delaySend")
    }
    @IBOutlet weak var clearSwitch: UISwitch!
    @IBAction func clearChange(_ sender: Any) {
        defaults.set(clearSwitch.isOn, forKey: "clearText")
        group?.set(clearSwitch.isOn, forKey: "clearText")
    }
    @IBAction func capsButt(_ sender: Any) {
        display("Info", "When changing your text to \"cApS\", instead of making every other character uppercase, it will make random characters uppercase.")
    }
    @IBAction func prefixButt(_ sender: Any) {
        display("Info", "When using the Ye Olde text, the prefixes won't be added to the ends of every word. Only certain words will be replaced with old timey versions of themselves.")
    }
    @IBAction func correctButt(_ sender: Any) {
        display("Info", "Enables or disables autocorrection for the textbox")
    }
    @IBAction func delayButt(_ sender: Any) {
        display("Info", "When enabled, the iMessage extension will not automatically send converted text in your conversation, and manually pressing send will be required.")
    }
    @IBAction func clearButt(_ sender: Any) {
        display("Info", "If \"Delay message sending\" is enabled, the textbox in the iMessage app will be cleared after sending your converted text. Otherwise you will have to manually delete the old text.")
    }
    
    func display(_ Title: String, _ Body: String){
        let alert = UIAlertController(title: Title, message: Body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
