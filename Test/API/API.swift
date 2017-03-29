//
//  API.swift
//  Test
//
//  Created by Netccentric on 29/3/17.
//  Copyright © 2017 ngo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API: NSObject
{
    class func baseUrl() -> String
    {
        return  "http://test.gotouche.com/rest/"
    }
    
    class func apiKey() -> String
    {
        return "328c283cd27bd1877d9080ccb1604c91"
    }
    
    class func callMethod(method: String, parameters: [String:Any], completionHandler:@escaping (AnyObject?)->())
    {
        DispatchQueue.global(qos: .default).async
        {
            var params = parameters
            
//            //add api key to each method call
//            params["api_key"] = self.apiKey()
            
            //network request on background thread
            Alamofire.request( self.baseUrl() + method, method: .get, parameters: params).responseJSON
            {   response in
                
                if let jsonData = response.result.value
                {
                    DispatchQueue.main.async
                    {
                        
                        completionHandler(jsonData as AnyObject?)
                    }
                }
                else if response.result.error != nil
                {
                    DispatchQueue.main.async
                    {
                        //TODO: handle error here
                        
                        //completionhandler on main thread
                        completionHandler(nil)
                    }
                }
            }
        }
    }
    

}