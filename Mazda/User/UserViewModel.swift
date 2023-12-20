//
//  UserViewModel.swift
//  Mazda
//
//  Created by GG on 2023/12/20.
//

import Combine
import Foundation

class UserViewModel: ObservableObject {
    @Published var userInfo: Result<UserInfo>?
    
    private var cancellableSet: Set<AnyCancellable> = []
    var service: Service
    
    
    init(result: Result<UserInfo>? = nil, service: Service = Service.shared) {
        self.userInfo = result
        self.service = service
    }
    
    func getUserInfo() {
        service.fetchData(ServiceAPI.userInfo, model: Result<UserInfo>.self)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    print(dataResponse.error ?? "出错")
                } else {
                    self.userInfo = dataResponse.value
                }
            }.store(in: &cancellableSet)
    }
}
