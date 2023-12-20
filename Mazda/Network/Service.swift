//
//  Service.swift
//  Mazda
//
//  Created by GG on 2023/12/19.
//

import Alamofire
import Combine
import Foundation

protocol ServiceProtocol {
    func fetchData<T: Codable>(_ serviceRequest: ServiceRequestBuilder, model: T.Type) -> AnyPublisher<DataResponse<T, ServiceError>, Never>
}

class Service {
    static let shared = Service()
    
    private init() {}
}

extension Service: ServiceProtocol {
    func fetchData<T>(_ serviceRequest: ServiceRequestBuilder, model: T.Type) -> AnyPublisher<Alamofire.DataResponse<T, ServiceError>, Never> where T : Decodable, T : Encodable {
        return AF.request(serviceRequest)
            .validate()
            .publishDecodable(type: T.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0) }
                    return ServiceError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
