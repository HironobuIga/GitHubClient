//
//  GitHubRequest.swift
//  RxSwiftGitHubClient
//
//  Created by iganin on 2018/08/18.
//  Copyright © 2018年 iganin. All rights reserved.
//

import APIKit
import ObjectMapper

protocol GitHubRequest: Request { }

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
    }
}

extension GitHubRequest where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        return try decodeValue(object)
    }
}

struct FetchRepositoryRequest: GitHubRequest {
    var userName: String
    var path: String {
        return "/users/\(self.userName)/repos"
    }
    
    typealias Response = [Repository]
    
    var method: HTTPMethod {
        return .get
    }
    
    init(userName: String) {
        self.userName = userName
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> FetchRepositoryRequest.Response {
        return try decodeArray(object)
    }
}
