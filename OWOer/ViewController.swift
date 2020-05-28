//
//  ViewController.swift
//  OWOer
//
//  Created by Joe Oliveira on 5/18/19.
//  Copyright © 2019 Alternative Apps Unlimited. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import QuartzCore
import GoogleMobileAds
import PersonalizedAdConsent
import SwiftyStoreKit
import AdSupport
import iOSDropDown

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    let o = owo()
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var adMobBannerView = GADBannerView()
    let ADMOB_BANNER_UNIT_ID = "ca-app-pub-3426117205431266/7392122947"
    let ADMOB_FULL_UNIT_ID = "ca-app-pub-3426117205431266/9826714592"
    public static let adRemoval = "Ad_Removal"
    let defaults = UserDefaults.standard
    let group = UserDefaults.init(suiteName: "group.OWO")
    
    var convertCount: Int = 0
    var adNum: Int = 5
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                //view.backgroundColor = .darkGray
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TextBox_2.layer.borderWidth = 1
        TextBox_2.layer.borderColor = UIColor.purple.cgColor
        
        interstitial = GADInterstitial(adUnitID: ADMOB_FULL_UNIT_ID)
        let request = GADRequest()
        interstitial.load(request)
        
        convertCount = defaults.integer(forKey: "convertCount")
        
        self.TextBox_2.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        RemoveAds()
        TextBox_2.autocorrectionType = defaults.bool(forKey: "spellCheck") ? .yes : .no
        
        if(!defaults.bool(forKey: "Update112")){
            display("Update 1.1.2", "Adjustments to MegaUWU\n" +
            "Added more emoji mappings to Emojifier\n" +
            "Added update button for Emojifier\n" +
            "UwU what's this in the settings?\n" +
            "Some under the hood improvements\n")
            
            defaults.set(true, forKey: "Update112")
        }
    }
    
    override func loadView() {
        super.loadView()
        RemoveAds()
        
        styleDropDown.listDidDisappear {
            //self.zalgoSlider.isEnabled = self.styleDropDown.selectedIndex == 7
        }
        styleDropDown.optionArray = owo().styleArray
        optionsDropDown.optionArray = owo().optionsArray
        
    }

    let NBQ = NotificationBannerQueue()
    
    func showBanner(_ Title: String, _ Text: String = "", _ Error: Bool = false){
        NBQ.removeAll()
        let banner = NotificationBanner(title: Title, subtitle: Text, style: (Error ? BannerStyle.danger : BannerStyle.success))
        banner.show(queue: NBQ)
    }
    
    func display(_ Title: String, _ Body: String){
        let alert = UIAlertController(title: Title, message: Body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func Clipboard(_ Text: String){
        let pasteboard = UIPasteboard.general
        pasteboard.string = Text
    }

    @IBOutlet weak var TextBox_2: UITextView!
    
    @IBAction func fontChange(_ sender: Any) {

    }
    
    @IBAction func undoText(_ sender: Any) {
        let temp: String = TextBox_2.text ?? ""
        TextBox_2.text = undoString
        undoString = temp
    }

    var undoString: String = ""
    @IBAction func Convert(_ sender: Any) {
        undoString = TextBox_2.text ?? ""
        
        TextBox_2.text = o.textAdjustment((optionsDropDown.selectedIndex ?? 0) as Int, TextBox_2.text)
        TextBox_2.text = o.fontChanger((styleDropDown.selectedIndex ?? 0) as Int, TextBox_2.text, Zalgo: Int(zalgoSlider.value))
        
        convertCount += 1
        if(convertCount > adNum && !defaults.bool(forKey: "Ad_Removal") && !defaults.bool(forKey: "DisableAds")){
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
                convertCount = 0
            } else {
                print("Ad wasn't ready")
            }
        }
        
        defaults.set(convertCount, forKey: "convertCount")
    }
    @IBOutlet weak var zalgoLabel: UILabel!

    @IBOutlet weak var zalgoSlider: UISlider!
    
    @IBAction func Copy(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        if(TextBox_2.text == "" || TextBox_2.text == nil){
            showBanner("Nothing To Copy!", "", true)
        }else{
            Clipboard(TextBox_2.text ?? "")
            if(TextBox_2.text == pasteboard.string){
                showBanner("Text Copied", TextBox_2.text ?? "", false)
            }else{
                showBanner("Copy Failed!", "", true)
            }
        }
    }
    @IBAction func Clear(_ sender: Any) {
        TextBox_2.text = ""
    }
    @IBAction func Paste(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        TextBox_2.text = pasteboard.string
    }
    
    func RemoveAds(){
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.adUnitID = ADMOB_BANNER_UNIT_ID
        
        if(defaults.bool(forKey: "Ad_Removal")){
            bannerView.removeFromSuperview()
            bannerView.isHidden = true
            defaults.set(true, forKey: "Unlocked")
            group?.set(true, forKey: "Unlocked")
        }else if(defaults.bool(forKey: "DisableAds")){
            bannerView.removeFromSuperview()
            bannerView.isHidden = true
        }else{
            bannerView.isHidden = false
            bannerView.rootViewController = self
            addBannerViewToView(bannerView)
            bannerView.load(GADRequest())
            print("There is a banner!")
        }
        
        #if DEBUG
        bannerView.removeFromSuperview()
        bannerView.isHidden = true
        defaults.set(true, forKey: "Unlocked")
        group?.set(true, forKey: "Unlocked")
        #endif
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //self.view.endEditing(true)
        TextBox_2.text = TextBox_2.text! + "\n"
        return false
    }
    
    @IBAction func styleChange(_ sender: Any) {
        
    }
    @IBOutlet weak var styleDropDown: DropDown!
    
    @IBAction func optionsChange(_ sender: Any) {
    }
    
    @IBOutlet weak var optionsDropDown: DropDown!
}

extension UITextView{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @IBAction func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
    
}
