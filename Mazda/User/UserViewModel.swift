//
//  UserViewModel.swift
//  Mazda
//
//  Created by GG on 2023/12/20.
//

import Combine
import Foundation

class UserViewModel: ObservableObject {
    @Published var userInfo: Result<UserInfo>? = nil {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var userRole: Result<UserRole>? = nil {
        willSet {
            objectWillChange.send()
        }
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    var service: Service = Service.shared
    
    
    init() {
        getUserInfo()
        getUserRole()
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
    
    func getUserRole() {
        service.fetchData(ServiceAPI.userRole, model: Result<UserRole>.self)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    print(dataResponse.error ?? "出错")
                } else {
                    self.userRole = dataResponse.value
                }
            }.store(in: &cancellableSet)
    }
}
