//
//  NetworkManager.swift
//  DubizzleApp
//
//  Created by Vineet Sansare on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import Foundation

typealias ServiceResponse = (Any?, Error?) -> Void

class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    
    func makeHTTPRequest(path: String, method: String = "GET", body: [String: Any] = [String: Any](), onCompletion: @escaping ServiceResponse) {
        guard let url = URL(string: path) else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if case "POST" = method {
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json",forHTTPHeaderField: "Accept")
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            }
            catch let error {
                onCompletion([:], error)
            }
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                onCompletion([:], error)
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            onCompletion(responseJSON, error)
        })
        task.resume()
    }
}



class ProductNetworkAdapter {
    
    func getProducts(completionHandler: @escaping (_ products: Array<ProductModel>?, _ error: NSError?) -> Void) {
        NetworkManager.sharedInstance.makeHTTPRequest(path: NetworkConstants.baseURL, onCompletion: { (jsonObject, error) in
            if error == nil, let dict = jsonObject as? Dictionary<String,Any>, let results = dict["results"] as? Array<Dictionary<String,Any>> {
                let response = try? JSONSerialization.data(withJSONObject: results, options: [])
                do {
                    let products = try JSONDecoder().decode(Array<ProductModel>.self, from: response!)
                    completionHandler(products, nil)
                } catch {
                    completionHandler(nil, error as NSError)
                }
            } else {
                completionHandler(nil, error as NSError?)
            }
        })
    }
}
