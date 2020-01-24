//
//  NetworkManager.swift
//  TranslatorDemo
//
//  Created by meet ratanpara on 24/01/20.
//  Copyright © 2020 meet ratanpara. All rights reserved.
//

import UIKit

class NetworkManager: NSObject
{
    
    enum HTTPMethod:Int {
        
        case httpMethodUnknown = 0
        case httpMethodPost = 1
        case httpMethodGet = 2
    }
    
    static let shared = NetworkManager()
    typealias APIRequestCompletionHandler = (NSError?, AnyObject?) -> Void
    
    func HTTPMethodForType(_ method: HTTPMethod) -> String
    {
        switch method {
            
        case HTTPMethod.httpMethodPost:
            return "POST"
        case HTTPMethod.httpMethodGet:
            return "GET"
        default:
            return ""
        }
    }
    
    func callWebService(_ url: URL, withHTTPMethod method: HTTPMethod, withBody dict: NSDictionary?, withCompletionHandler completionHandler: @escaping APIRequestCompletionHandler)
    {
        
        let objSession: URLSession = URLSession.shared
        var objRequest: URLRequest = URLRequest(url: url)
        objRequest.httpMethod = self.HTTPMethodForType(method)
        objRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        objRequest.setValue("text/json", forHTTPHeaderField: "Content-Type")
        objRequest.setValue("text/javascript", forHTTPHeaderField: "Content-Type")
        objRequest.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        objRequest.setValue("text/html", forHTTPHeaderField: "Content-Type")
        
        var objData: Data = Data()
        
        if dict != nil {
            do {
                objData = try JSONSerialization.data(withJSONObject: dict!, options: [])
            } catch {
                
                completionHandler(error as NSError?, nil)
            }
        }
        
        switch method {
            
        case .httpMethodGet:
            let objDataTask: URLSessionDataTask = objSession.dataTask(with: objRequest, completionHandler: { (data, response, error) -> Void in
                
                if (error != nil) {
                    completionHandler(error as NSError?, nil)
                } else {
                    if ((response?.isKind(of: HTTPURLResponse.self)) != nil) {
                        do {
                            let objResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                            completionHandler(nil, objResponse as AnyObject?)
                        } catch {
                           
                            completionHandler(error as NSError?, nil)
                        }
                    }
                }
            })
            
            objDataTask.resume()
            break
            
        case .httpMethodPost:
            
            let objUploadTask: URLSessionUploadTask = objSession.uploadTask(with: objRequest as URLRequest, from: objData, completionHandler: { (data, response, error) -> Void in
                
                if (error != nil) {
                    completionHandler(error as NSError?, nil)
                } else {
                    if ((response?.isKind(of: HTTPURLResponse.self)) != nil) {
                        do {
                            let objResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                            completionHandler(nil, objResponse as AnyObject?)
                        } catch {
                            
                            completionHandler(error as NSError?, nil)
                        }
                    }
                }
            })
            
            objUploadTask.resume()
            break
        default:
            
            break
        }
    }
    
}
