//
//  UserViewModel.swift
//  Mazda
//
//  Created by GG on 2023/12/20.
//

import Combine
import Foundation

class UserViewModel: ObservableObject {
    @Published var result: Result<ResultData>?
    
    private var cancellableSet: Set<AnyCancellable> = []
    var service: Service
    
    
    init(result: Result<ResultData>? = nil, service: Service = Service.shared) {
        self.result = result
        self.service = service
    }
    
    func getUserInfo() {
        service.fetchData(ServiceAPI.userInfo, model: Result<ResultData>.self)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    print("error")
                } else {
                    self.result = dataResponse.value
                }
            }.store(in: &cancellableSet)
    }
}
