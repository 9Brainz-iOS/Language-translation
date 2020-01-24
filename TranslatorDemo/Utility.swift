//
//  Utility.swift
//  TranslatorDemo
//
//  Created by meet ratanpara on 24/01/20.
//  Copyright © 2020 meet ratanpara. All rights reserved.
//

import UIKit


class Utility: NSObject {
    
    static func objOfAppDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
   
    static func showAlertWithTitleFromVC(vc:UIViewController, title:String?, andMessage message:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for index in 0..<buttons.count  {
            
            let action = UIAlertAction(title: buttons[index], style: .default, handler: {
                
                (alert: UIAlertAction!) in
                
                if(completion != nil) {
                    
                    completion(index)
                }
            })
            
            alertController.addAction(action)
        }
        
        DispatchQueue.main.async {
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    static func setUserDefaults(withObject object: AnyObject, forKey key: String)
    {
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getUserDefaults(forKey key: String) -> AnyObject
    {
        return UserDefaults.standard.object(forKey: key) as AnyObject
    }
    
   
    
    
    static func showActionSheetWithTitleFromVC(vc:UIViewController, title:String, andMessage message:String, buttons:[String],canCancel:Bool, completion:((_ index:Int) -> Void)!) -> Void
    {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for index in 0..<buttons.count  {
            
            let action = UIAlertAction(title: buttons[index], style: .default, handler: {
                
                (alert: UIAlertAction!) in
                
                if(completion != nil){
                    
                    completion(index)
                }
            })
            
            alertController.addAction(action)
        }
        
        if canCancel {
            
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (alert: UIAlertAction!) in
                
                if completion != nil {
                    
                    completion(buttons.count)
                }
            })
            
            alertController.addAction(action)
        }
        vc.present(alertController, animated: true, completion: nil)
    }
    
}
