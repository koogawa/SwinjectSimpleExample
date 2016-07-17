//
//  WeatherFetcher.swift
//  SwinjectSimpleExample
//
//  Created by koogawa on 2016/07/16.
//  Copyright © 2016年 koogawa. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherFetcher {
    let networking: Networking

    func fetch(response: [City]? -> ()) {
        networking.request { data in
            let cities = data.map { self.decode($0) }
            response(cities)
        }
    }

    private func decode(data: NSData) -> [City] {
        let json = JSON(data: data)
        var cities = [City]()
        for (_, j) in json["list"] {
            if let id = j["id"].int {
                let city = City(
                    id: id,
                    name: j["name"].string ?? "",
                    weather: j["weather"][0]["main"].string ?? "")
                cities.append(city)
            }
        }
        return cities
    }
}
