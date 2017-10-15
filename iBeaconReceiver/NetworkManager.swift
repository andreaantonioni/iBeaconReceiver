//
//  NetworkManager.swift
//  iBeaconReceiver
//
//  Created by Andrea Antonioni on 15/10/17.
//  Copyright © 2017 Andrea Antonioni. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func accessRequest() {
        let header: HTTPHeaders = ["Authorization": "KISI-LINK 75388d1d1ff0dff6b7b04a7d5162cc6c"]
        let request = Alamofire.request("https://api.getkisi.com/locks/5124/access", method: .post, headers: header)
        print(request.debugDescription)
        
        request.response { response in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
    }
    
}
