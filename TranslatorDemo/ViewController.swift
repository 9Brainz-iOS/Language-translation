//
//  ViewController.swift
//  TranslatorDemo
//
//  Created by meet ratanpara on 24/01/20.
//  Copyright © 2020 meet ratanpara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var translateArr: [NSDictionary] = []
    var Desc = "Start Developing iOS Apps (Swift) is the perfect starting point for learning to create apps that run on iPhone and iPad. View this set of incremental lessons as a guided introduction to building your first app—including the tools, major concepts, and best practices that will ease your path.Each lesson contains a tutorial and the conceptual information you need to complete it. The lessons build on each other, walking you through a step-by-step process of creating a simple, real-world iOS app."

    @IBOutlet weak var lblData: UILabel!
    var id:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnTranslateTapped(_ sender: Any) {
 
        if !Utility.getUserDefaults(forKey: "isInternetConnectionAvailable").boolValue {
            
            DispatchQueue.main.async {
                
                Utility.showAlertWithTitleFromVC(vc: self, title: "No Internet", andMessage: "Please connect your Internet Connection!", buttons: ["Ok"], completion: nil)
            }
            
        } else {
            
            let arrOfTitle: [String] = ["Arabic (عربى)", "English (English)", "French (Français)", "German (Deutsche)", "Indonesian (bahasa Indonesia)", "Japanese (日本人)", "Portuguese (Português)", "Russian (русский)", "Simplified Chinese (简体中文)", "Spanish (Español)"]
            let arrOfLangCode: [String] = ["ar", "en", "fr", "de", "id", "ja", "pt", "ru", "zh", "es"]
         
            Utility.showActionSheetWithTitleFromVC(vc: self, title: "Translate Language", andMessage: "Choose your language in which you want to read the Information.", buttons: arrOfTitle, canCancel: true) { (intIndex) in
                
                if intIndex < arrOfLangCode.count {
                    self.translateAPIWithLangCode(code: arrOfLangCode[intIndex])
                }
            }
        }
    }
    
    
    func translateAPIWithLangCode(code: String)
    {
        if code == "en" {
            DispatchQueue.main.async {
                self.lblData.text = self.Desc
            }
            return
        }
    
        var isTranslateAvail: Bool = false
        for dict in self.translateArr {
            
            if "\(dict.value(forKey: "langID")!)" == "\(code)" {
                
                if "\(dict.value(forKey: "dictID")!)" == "\(self.id!)" {
                    
                    DispatchQueue.main.async {
                        
                        self.lblData.text = "\(dict.value(forKey: "translation")!)"
                    }
                    isTranslateAvail = true
                    break
                }
            }
        }
        if isTranslateAvail {
            return
        }
        
        
        ModelManager.sharedInstance.callToTranslate(withText: "\(self.Desc)", withLang: code) { (response, error) in
            
            print(response)
            
            if error == nil {
                
                DispatchQueue.main.async {
                    
                    self.lblData.text = "\(((response as! NSDictionary).object(forKey: "text") as! NSArray).firstObject!)"
                    
                    self.translateArr.append(NSDictionary(dictionary: [ "langID": code, "translation": "\(((response as! NSDictionary).object(forKey: "text") as! NSArray).firstObject!)"]))
                    
                }
            } else {
                
                DispatchQueue.main.async {
                    
                    Utility.showAlertWithTitleFromVC(vc: self, title: "Translate Issue", andMessage: error!.localizedDescription, buttons: ["Ok"], completion: nil)
                }
            }
        }
    }
}

