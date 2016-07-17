//
//  Network.swift
//  SwinjectSimpleExample
//
//  Created by koogawa on 2016/07/17.
//  Copyright © 2016年 koogawa. All rights reserved.
//

import Foundation
import Alamofire

struct Network : Networking {
    func request(response: NSData? -> ()) {
        Alamofire.request(.GET, OpenWeatherMap.url, parameters: OpenWeatherMap.parameters)
            .response { _, _, data, _ in
                response(data)
        }
    }
}
