//
//  Keyword.swift
//  Tiki-Home-Test
//
//  Created by HUYNH Hoc Luan on 3/21/19.
//  Copyright © 2019 Luan Huynh. All rights reserved.
//

import SwiftyJSON

struct Keyword {
    var value: String? = ""
    var icon: String? = ""
    
    init(json: JSON) {
        value = json["keyword"].string ?? ""
        icon = json["icon"].string ?? ""
    }
}
