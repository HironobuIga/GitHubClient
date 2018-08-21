//
//  Owner.swift
//  RxSwiftGitHubClient
//
//  Created by iganin on 2018/08/21.
//  Copyright © 2018年 iganin. All rights reserved.
//

import ObjectMapper
import Foundation

final class Owner: Mappable {
    
    var avatarUrl = ""
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        avatarUrl <- map["avatar_url"]
    }
}
