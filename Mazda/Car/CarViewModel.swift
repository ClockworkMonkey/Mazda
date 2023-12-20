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
    @Published var status: String = "等待获取数据"
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var service: Service = Service.shared
    private var timer: Timer?
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true, block: { timer in
            self.getCarStatus()
        })
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension CarViewModel {
    func getCarStatus() {
        status = "正在获取数据"
        
        service.fetchData(ServiceAPI.carStatus, model: Result<CarStatus>.self)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.status = "获取数据出错"
                    print(dataResponse.error ?? "出错")
                } else {
                    self.status = "获取数据成功"
                    self.carStatus = dataResponse.value
                }
            }.store(in: &cancellableSet)
    }
}
