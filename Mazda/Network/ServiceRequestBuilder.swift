//
//  ServiceRequestBuilder.swift
//  Mazda
//
//  Created by GG on 2023/12/20.
//

import Alamofire
import Foundation

protocol ServiceRequestBuilder: URLRequestConvertible {
    var baseURL: URL { get }
    var requestURL: URL { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var urlRequest: URLRequest { get }
}

extension ServiceRequestBuilder {
    var baseURL: URL {
        return ServiceEnvironment.baseURL
    }
    
    var requestURL: URL {
        return baseURL.appending(path: path, directoryHint: .notDirectory)
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(name: "Token", value: "ad30920d7b0c8267bad3c35d7dbb2882a0a5fd5642")
        return headers
    }
    
    var urlRequest: URLRequest {
        let request = try! URLRequest(url: requestURL, method: method, headers: headers)
        return request
    }
    
    public func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
}
