//
//  ServiceEnvironment.swift
//  Mazda
//
//  Created by GG on 2023/12/19.
//

import Foundation

enum ServiceEnvironment {
    case dev
    case test
    case prod
}

extension ServiceEnvironment {
    static var currentEnvironment: ServiceEnvironment {
        return .dev
    }
}

extension ServiceEnvironment {
    static var baseURL: URL {
        switch ServiceEnvironment.currentEnvironment {
        case .dev, .test:
            return URL(string: "https://iov.edaoduo.com/aoduo/prod/api/v2")!
        case .prod:
            return URL(string: "https://iov.edaoduo.com/aoduo/prod/api/v2")!
        }
    }
}
