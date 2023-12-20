//
//  CarViewModel.swift
//  Mazda
//
//  Created by GG on 2023/12/20.
//

import Combine
import Foundation

class CarViewModel: ObservableObject {
    @Published var carStatus: Result<CarStatus>? = nil
    
    private var cancellableSet: Set<AnyCancellable> = []
    var service: Service = Service.shared
}

extension CarViewModel {
    func getCarStatus() {
        service.fetchData(ServiceAPI.carStatus, model: Result<CarStatus>.self)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    print(dataResponse.error ?? "出错")
                } else {
                    self.carStatus = dataResponse.value
                }
            }.store(in: &cancellableSet)
    }
}
