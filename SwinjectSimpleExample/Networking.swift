//
//  Networking.swift
//  SwinjectSimpleExample
//
//  Created by koogawa on 2016/07/17.
//  Copyright © 2016年 koogawa. All rights reserved.
//

import Foundation

protocol Networking {
    func request(response: NSData? -> ())
}
