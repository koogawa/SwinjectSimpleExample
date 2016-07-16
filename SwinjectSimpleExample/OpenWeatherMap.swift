//
//  OpenWeatherMap.swift
//  SwinjectSimpleExample
//
//  Created by koogawa on 2016/07/16.
//  Copyright © 2016年 koogawa. All rights reserved.
//

import Foundation

struct OpenWeatherMap {
    private static let cityIds = [
        6077243, 524901, 5368361, 1835848, 3128760, 4180439,
        2147714, 264371, 1816670, 2643743, 3451190, 1850147
    ]

    static let url = "http://api.openweathermap.org/data/2.5/group"

    static var parameters: [String: String] {
        return [
            "APPID": Constants.AppID,
            "id": cityIds.map { String($0) }.joinWithSeparator(",")
        ]
    }
}
