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
    
    var avatarUrl: String?
    var eventsUrl: String?
    var followersUrl: String?
    var followingUrl: String?
    var gistsUrl: String?
    var gravatarId: String?
    var htmlUrl: String?
    var id: Int?
    var login: String?
    var nodeId: String?
    var organizationsUrl: String?
    var receivedEventsUrl: String?
    var reposUrl: String?
    var siteAdmin: Bool?
    var starredUrl: String?
    var subscriptionsUrl: String?
    var type: String?
    var url: String?
    
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        avatarUrl <- map["avatar_url"]
        eventsUrl <- map["events_url"]
        followersUrl <- map["followers_url"]
        followingUrl <- map["following_url"]
        gistsUrl <- map["gists_url"]
        gravatarId <- map["gravatar_id"]
        htmlUrl <- map["html_url"]
        id <- map["id"]
        login <- map["login"]
        nodeId <- map["node_id"]
        organizationsUrl <- map["organizations_url"]
        receivedEventsUrl <- map["received_events_url"]
        reposUrl <- map["repos_url"]
        siteAdmin <- map["site_admin"]
        starredUrl <- map["starred_url"]
        subscriptionsUrl <- map["subscriptions_url"]
        type <- map["type"]
        url <- map["url"]
    }
}
