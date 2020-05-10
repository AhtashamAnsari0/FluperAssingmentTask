//
//  WebServices.swift
//  FluperTask
//
//  Created by Ahtasham Ansari on 10/05/20.
//  Copyright © 2020 AhtashamAnsari. All rights reserved.
//

import Foundation

class WebServices: NSObject {
    
    static let sharedInstance = WebServices()

    func getNewsHeadlineList(complition: @escaping(Bool) -> () )  {

        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=7158a7cd1dae4de88839b5f5de4550dc") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data,response,error in
            if let error = error {
                print(error.localizedDescription)
                complition(false)
            } else if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let articleList = json["articles"] as? [Any] {
                            guard let dataArticle = try? JSONSerialization.data(withJSONObject: articleList, options: []) else {
                                return
                            }
                            let isDataParse = DatabaseHelper.shareInstance.parse(dataArticle)
                            complition(isDataParse)
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
