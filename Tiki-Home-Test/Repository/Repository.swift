//
//  Repository.swift
//  Tiki-Home-Test
//
//  Created by HUYNH Hoc Luan on 3/21/19.
//  Copyright © 2019 Luan Huynh. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct Repository {
    
    static func requestAPIToGetData(completion: @escaping (_ isSuccess: Bool, _ keywords: [Keyword]) -> Void ) -> Void {
        guard let url = URL(string: "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios/keywords.json") else { return }
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                if let results = json["keywords"].array {
                    let keywords = results.map({ (json) -> Keyword in
                        return Keyword(json: json as JSON)
                    })
                    
                    completion(true, keywords)
                } else {
                    completion(false, [])
                }
                
                break
            case .failure(_):
                completion(false, [])
                break
            }
        }

    }
}
