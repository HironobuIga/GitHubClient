//
//  User.swift
//  RxSwiftGitHubClient
//
//  Created by iganin on 2018/08/09.
//  Copyright © 2018年 iganin. All rights reserved.
//

import ObjectMapper
import Foundation

final class User: Mappable {
    
    var fullName = ""
    var owner: Owner?
    var updatedDateString = ""
    var url = ""
    
    
    static func buildWithArray(userDictionaries: [[String: AnyObject]]) -> [User] {
        let users = userDictionaries.compactMap { userDictionary -> User? in
            guard let user = Mapper<User>().map(JSON: userDictionary) else { return nil }
            return user
        }
        return users
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        fullName <- map["full_name"]
        owner <- map["owner"]
        updatedDateString <- map["updated_at"]
        url <- map["url"]
    }
}
