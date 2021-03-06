//
//  API.swift
//  RxSwiftGitHubClient
//
//  Created by iganin on 2018/08/17.
//  Copyright © 2018年 iganin. All rights reserved.
//

import APIKit
import RxSwift

extension Session {
    
    static func rx_response<T: Request>(request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            let task = send(request) { result in
                switch result {
                case .success(let response):
                    observer.on(.next(response))
                    observer.on(.completed)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            task?.resume()
            
            return Disposables.create { [weak task] in
                task?.cancel()
            }
        }
    }
}
