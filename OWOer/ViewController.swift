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
    }
    
    override func loadView() {
        super.loadView()
        RemoveAds()
    }

    let NBQ = NotificationBannerQueue()
    
    func showBanner(_ Title: String, _ Text: String = "", _ Error: Bool = false){
        NBQ.removeAll()
        let banner = NotificationBanner(title: Title, subtitle: Text, style: (Error ? BannerStyle.danger : BannerStyle.success))
        banner.show(queue: NBQ)
    }

    @IBOutlet weak var FontSwitch: UISegmentedControl!
    
    func Clipboard(_ Text: String){
        let pasteboard = UIPasteboard.general
        pasteboard.string = Text
    }
    
    @IBOutlet weak var Optiosn: UISegmentedControl!
    @IBOutlet weak var TextBox: UITextField!
    @IBOutlet weak var TextBox_2: UITextView!
    
    @IBAction func fontChange(_ sender: Any) {
        zalgoLabel.isHidden = (FontSwitch.selectedSegmentIndex != 2)
        zalgoSlider.isHidden = (FontSwitch.selectedSegmentIndex != 2)
        fontStyles.isHidden = (FontSwitch.selectedSegmentIndex != 1)
    }
    
    @IBAction func undoText(_ sender: Any) {
        let temp: String = TextBox_2.text ?? ""
        TextBox_2.text = undoString
        undoString = temp
    }
    
    @IBOutlet weak var fontStyles: UISegmentedControl!

    var undoString: String = ""
    @IBAction func Convert(_ sender: Any) {
        undoString = TextBox_2.text ?? ""
        switch Optiosn.selectedSegmentIndex{
            case 1:
                TextBox_2.text = o.SpongeBoB(TextBox_2.text ?? "")
            case 2:
                TextBox_2.text = o.Clap(TextBox_2.text ?? "")
            case 3:
                TextBox_2.text = o.OWO(TextBox_2.text ?? "", o.uwu)
            case 4:
                TextBox_2.text = o.yeMold(TextBox_2.text ?? "")
        default:
            NSLog("No Change")
        }
        
        switch FontSwitch.selectedSegmentIndex{
        case 1:
            fontChanger()
        case 2:
            TextBox_2.text = o.doZalgo(TextBox_2.text ?? "", Int(zalgoSlider.value))
        default:
            break
        }
        
        convertCount += 1
        if(convertCount > adNum && !defaults.bool(forKey: "Ad_Removal")){
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
    
    func fontChanger(){
        switch fontStyles.selectedSegmentIndex{
        case 0:
            TextBox_2.text = o.OWO(TextBox_2.text ?? "", o.fancy)
        case 1:
            TextBox_2.text = o.OWO_Alt(String(TextBox_2.text ?? ""), o.upsideDown)
            TextBox_2.text = String((TextBox_2.text ?? "").reversed())
        case 2:
            TextBox_2.text = o.OWO(String(TextBox_2.text ?? ""), o.Fraktur)
        case 3:
            TextBox_2.text = o.OWO((TextBox_2.text ?? "").uppercased(), o.bubbles)
        default:
            break
        }
    }
    

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
            group?.set(true, forKey: "Unlocked")
        }else{
            bannerView.isHidden = false
            bannerView.rootViewController = self
            addBannerViewToView(bannerView)
            bannerView.load(GADRequest())
            print("There is a banner!")
        }
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
