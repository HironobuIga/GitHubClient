//
//  Repository.swift
//  RxSwiftGitHubClient
//
//  Created by iganin on 2018/08/09.
//  Copyright © 2018年 iganin. All rights reserved.
//

import ObjectMapper
import Foundation

final class Repository: Mappable {
    
    var fullName = ""
    var owner: Owner?
    var updatedDateString = ""
    var url = ""
    
    
    static func buildWithArray(repositoryDictionaries: [[String: AnyObject]]) -> [Repository] {
        let repositories = repositoryDictionaries.compactMap { repositoryDictionary -> Repository? in
            guard let repository = Mapper<Repository>().map(JSON: repositoryDictionary) else { return nil }
            return repository
        }
        return repositories
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        fullName <- map["full_name"]
        owner <- map["owner"]
        updatedDateString <- map["updated_at"]
        url <- map["url"]
    }
}
