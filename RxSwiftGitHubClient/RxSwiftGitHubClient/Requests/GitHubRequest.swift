//
//  GitHubRequest.swift
//  RxSwiftGitHubClient
//
//  Created by iganin on 2018/08/18.
//  Copyright © 2018年 iganin. All rights reserved.
//

import Foundation
import APIKit
import ObjectMapper

protocol GitHubRequest: Request { }

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
//    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
//        guard (200..<300).contains(urlResponse.statusCode) else {
//            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
//        }
//        return
//    }
}

struct FetchUsersRequest: GitHubRequest {
    var userName: String
    var path: String {
        return "/users/\(self.userName)/repos"
    }
    
    typealias Response = [User]?
    
    var method: HTTPMethod {
        return .get
    }
    
    init(userName: String) {
        self.userName = userName
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [User]? {
        guard let dictionary = object as? [[String: AnyObject]] else { return nil }
        let users = User.buildWithArray(userDictionaries: dictionary)
        return users
    }
}
