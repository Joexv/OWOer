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
import iOSDropDown

//TODO: Convert this to load from a json for easier management
class TableViewController: UITableViewController {
    let group = UserDefaults.init(suiteName: "group.OWO")
    let defaults = UserDefaults.standard
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
        
        maxEmoji_Step.value = defaults.double(forKey: "MaxEmoji").rounded()
        maxEmoji.text = "Maximum Emojis: \(Int(maxEmoji_Step.value.rounded()))"
        
        zalgoSwitch.isOn = defaults.bool(forKey: "zalgoAlways")
        clapperBoi.isOn = defaults.bool(forKey: "iGotTheClaps")
        clearSwitch.isOn = defaults.bool(forKey: "delaySend")
        
        capsSwitch.isOn = defaults.bool(forKey: "capsRandom")
        prefixSwitch.isOn = defaults.bool(forKey: "oldPrefix")
        spellSwitch.isOn = defaults.bool(forKey: "spellCheck")
        
        heartSwitch.isOn = defaults.bool(forKey: "hearts")
        
        adDisabler.isOn = defaults.bool(forKey: "DisableAds")
        
        if(defaults.bool(forKey: "Ad_Removal")){
            adButt.titleLabel?.text = "Thank you for supporting us!"
            adButt.isEnabled = false
        }
        
        PitchStepper.value = defaults.double(forKey: "Pitch")
        RateStepper.value = defaults.double(forKey: "Rate")
        RateLabel.text = "\(RateStepper.value / 10)"
        PitchLabel.text = "\(PitchStepper.value / 10)"
        
        SpeakSwitcher.isOn = defaults.bool(forKey: "SpeakEmojis")
        print(OSSVoiceEnum.allCases)
    
        var LangStrings: [String] = []
        for word in OSSVoiceEnum.allCases{
            LangStrings.append("(\(word)) " + word.rawValue)
        }
        LangStrings.sort()
        
        VoiceDropDown.optionArray = LangStrings
        VoiceDropDown.placeholder = defaults.string(forKey: "VoiceLanguage") ?? "en-US"
        
        VoiceDropDown.listDidDisappear {
            self.defaults.set(self.VoiceDropDown.text, forKey: "VoiceLanguage")
        }
    }
    @IBAction func Rate_Change(_ sender: Any) {
        RateLabel.text = "\(RateStepper.value / 10)"
        defaults.set(RateStepper.value, forKey: "Rate")
    }
 
    @IBOutlet weak var RateStepper: UIStepper!
    @IBOutlet weak var PitchStepper: UIStepper!
    @IBAction func Pitch_Change(_ sender: Any) {
        PitchLabel.text = "\(PitchStepper.value / 10)"
        defaults.set(PitchStepper.value, forKey: "Pitch")
    }
    
    @IBOutlet weak var VoiceDropDown: DropDown!
    
    @IBOutlet weak var SpeakSwitcher: UISwitch!
    @IBAction func Speak_Switch(_ sender: Any) {
        defaults.set(SpeakSwitcher.isOn, forKey: "SpeakEmojis")
    }

    @IBOutlet weak var RateLabel: UILabel!
    @IBOutlet weak var PitchLabel: UILabel!
    
    @IBAction func reportButton(_ sender: Any) {
        if let url = URL(string: "https://www.github.com/joexv/OWOer/issues/new") {
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBAction func heartButt(_ sender: Any) {
        display("Info", "Enabling this will make the 'Hearts' text adjustment replace ONLY spaces instead of adding a heart to every letter")
    }
    @IBOutlet weak var heartSwitch: UISwitch!
    @IBAction func heartChange(_ sender: Any) {
        defaults.set(heartSwitch.isOn, forKey: "hearts")
        group?.set(heartSwitch.isOn, forKey: "hearts")
    }
    
    @IBOutlet weak var labelCell: UITableViewCell!
    override func viewDidAppear(_ animated: Bool) {
        if(defaults.bool(forKey: "Ad_Removal")){
            adButt.titleLabel?.text = "Thank you for supporting us!"
            adButt.isEnabled = false
            labelCell.isHidden = true
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
    
    @IBAction func removeAdButt(_ sender: Any) {
        if(!(group?.bool(forKey: "Unlocked") ?? false)){
            BuyProd()
        }
        
        if(defaults.bool(forKey: "Ad_Removal")){
            adButt.titleLabel?.text = "Thank you for supporting us!"
            adButt.isEnabled = false
            labelCell.isHidden = true
        }
    }
    @IBAction func restoreButt(_ sender: Any) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                print("Restore Failed: \(results.restoreFailedPurchases)")
                self.showBanner("Failed!", "Error: \(results.restoreFailedPurchases)", false)
            }
            else if results.restoredPurchases.count > 0 {
                self.showBanner("Success!", "Ads will be removed when you restart the app, and the iMessage and keyboard extensions should fully function!")
                print("Restore Success: \(results.restoredPurchases)")
                self.defaults.set(true, forKey: "Ad_Removal")
                self.group?.set(true, forKey: "Unlocked")
            }
            else {
                self.showBanner("Failed!", "No purchases found on this account!", false)
            }
        }
    }
    
    func BuyProd(){
        SwiftyStoreKit.purchaseProduct("Ad_Removal", quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                self.showBanner("Success!", "Ads will be removed when you restart the app, and the iMessage and keyboard extensions should fully function!")
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
                    print("Privacy Error")
                case .unauthorizedRequestData:
                    print("Unauthorized Request")
                case .invalidOfferIdentifier:
                    print("Invalid Offer ID")
                case .invalidSignature:
                    print("Invalid Signature")
                case .missingOfferParams:
                    print("Missing Offer Params")
                case .invalidOfferPrice:
                    print("Invalid Offer Price")
                @unknown default:
                    print("Unknown Error")
                }
            }
        }
    }
    
    @IBAction func zalgoHelp(_ sender: Any) {
        display("Info", "When enabled, the Zalgo style will ALWAYS be added to text. When off, you must manually select Zalgo under the Font Styles.")
    }
    @IBOutlet weak var zalgoSwitch: UISwitch!
    @IBAction func zalgoChange(_ sender: Any) {
        defaults.set(zalgoSwitch.isOn, forKey: "zalgoAlways")
        group?.set(zalgoSwitch.isOn, forKey: "zalgoAlways")
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
    @IBAction func clapsButt(_ sender: Any){
        display("Info", "Capitalizes ALL text when using the clapping text adjustment.")
    }
    @IBAction func correctButt(_ sender: Any) {
        display("Info", "Enables or disables autocorrection for the textbox")
    }
    @IBAction func delayButt(_ sender: Any) {
        display("Info", "When enabled, the iMessage extension will not automatically send converted text in your conversation, and manually pressing send will be required. iOS 11+ only")
    }
    @IBAction func clearButt(_ sender: Any) {
        display("Info", "If \"Delay message sending\" is enabled, the textbox in the iMessage app will be cleared after sending your converted text. Otherwise you will have to manually delete the old text.")
    }
    @IBAction func maxEmojiButt(_ sender: Any) {
        display("Info", "Set the maximum amount of emojis to generate when using the \"Emojifier\" adjustment. Default is 3")
    }
    @IBAction func disableAdButt(_ sender: Any) {
        display("Info", "We get it ads suck. So to show our grattitude to our users you can now disable ads for free! This won't unlock the iMessage Extension or the keyboard, but it will allow you to use the main app in peace.")
    }
    
    @IBOutlet weak var adDisabler: UISwitch!
    @IBAction func disableAds(_ sender: Any) {
        defaults.set(adDisabler.isOn, forKey: "DisableAds")
    }
    
    
    @IBAction func maxEmoji_Stepper(_ sender: Any) {
        maxEmoji.text = "Maximum Emojis: \(Int(maxEmoji_Step.value))"
        defaults.set(maxEmoji_Step.value, forKey: "MaxEmoji")
        group?.set(maxEmoji_Step.value, forKey: "MaxEmoji")
    }
    @IBOutlet weak var maxEmoji_Step: UIStepper!
    @IBOutlet weak var maxEmoji: UILabel!
    
    let dispGroup = DispatchGroup()
    @IBAction func updateEmojifier(_ sender: Any) {
        dispGroup.enter()
        let dlFile = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("emojis-Downloaded.json")
        let dlURL = URL(string: "https://raw.githubusercontent.com/Joexv/OWOer/master/emojis-Download.json")
        
        var StatusCode: Int = 0
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url: dlURL!)

        try? FileManager.default.removeItem(at: dlFile)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    StatusCode = statusCode
                    print("Status code: \(statusCode)")
                }

                if(FileManager.default.fileExists(atPath: tempLocalUrl.path)){
                    do {
                        try FileManager.default.copyItem(at: tempLocalUrl, to: dlFile)
                    } catch (let writeError) {
                        print("Error creating a file \(dlFile) : \(writeError)")
                    }
                }
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
            }
            self.dispGroup.leave()
        }
        task.resume()
        
        dispGroup.notify(queue: DispatchQueue.main){
            switch StatusCode{
                case 200:
                        self.display("Completed!", "The updated Emoji mappings have been downloaded! Restart the app and then use Emojifier as you normally would!")
                        self.saveToGroup(path: dlFile)
                default:
                    self.display("Error Code: \(StatusCode)!", "Please check your internet connection and try again!")
            }
        }
    }
    
    func saveToGroup(path: URL){
        do {
            let data = try Data(contentsOf: path, options: .alwaysMapped)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            group?.set(json, forKey: "EmojiDic")
        }catch let error {
            print("Error saving to group \(error)")
        }
    }
    
    func display(_ Title: String, _ Body: String){
        let alert = UIAlertController(title: Title, message: Body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
