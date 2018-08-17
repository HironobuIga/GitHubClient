//
//  API.swift
//  RxSwiftGitHubClient
//
//  Created by iganin on 2018/08/17.
//  Copyright © 2018年 iganin. All rights reserved.
//

import Foundation
import APIKit
import RxSwift
import ObjectMapper

extension Session {
    func rx_sendRequest<T: Request>(request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            let task = self.send(request) { result in
                switch result {
                case .success(let response):
                    observer.on(.next(response))
                    observer.on(.completed)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create { [weak task] in
                task?.cancel()
            }
        }
    }
    
    class func rx_rendRequest<T: Request>(request: T) -> Observable<T.Response> {
        return Session.shared.rx_sendRequest(request: request)
    }
}
