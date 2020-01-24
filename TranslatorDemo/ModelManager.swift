//
//  ModelManager.swift
//  TranslatorDemo
//
//  Created by meet ratanpara on 24/01/20.
//  Copyright © 2020 meet ratanpara. All rights reserved.
//

import UIKit

class ModelManager: NSObject
{
    let TRANSLATE_APIKey: String = "trnsl.1.1.20190713T035516Z.9d7b01f9c5880679.d52e78fa6e7db0aab95924827b697fba0b6c3671"
    
    typealias RequestCompletionHandler = (Any?, NSError?) -> Void
    
    class var sharedInstance: ModelManager
    {
        return ModelManager()
    }
    
    func callToTranslate(withText txt: String, withLang lang: String, withCompletionHandler handler:@escaping RequestCompletionHandler)
    {
        let strURL: String = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=\(TRANSLATE_APIKey)&text=\(txt)&lang=\(lang)"
        
        let urlAddress = strURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        NetworkManager.shared.callWebService(URL(string: urlAddress!)!, withHTTPMethod: .httpMethodGet, withBody: nil) { (error, response) in
            
            error != nil ?  handler(nil, error) :  handler(response, nil)
        }
    }
    
}
