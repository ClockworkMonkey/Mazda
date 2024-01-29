//
//  CarViewModel.swift
//  Mazda
//
//  Created by GG on 2023/12/20.
//

import Combine
import Foundation

class CarViewModel: ObservableObject {
    @Published var carStatus: Result<CarStatus>? = nil {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var carCtrl: Result<CarCtrl>? = nil
    @Published var status: String = "等待获取数据"
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var service: Service = Service.shared
    private var timer: Timer?
    
    init() {
        self.getCarStatus()
        
//        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { timer in
//            self.getCarStatus()
//        })
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension CarViewModel {
    func getCarStatus() {
        status = "获取数据中..."
        
        service.fetchData(ServiceAPI.carStatus, model: Result<CarStatus>.self)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.status = "获取数据出错"
                    print(dataResponse.error ?? "出错")
                } else {
                    print("获取数据成功")
                    self.status = "获取数据成功"
                    if dataResponse.value?.status != 200 {
                        self.status = dataResponse.value?.message ?? "失败"
                    }
                    self.carStatus = dataResponse.value
                }
            }.store(in: &cancellableSet)
    }
    
    func carCtrl(ctrl: String) {
        status = "获取数据中..."
        
        service.fetchData(ServiceAPI.carCtrl(ctrl: ctrl), model: Result<CarCtrl>.self)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.status = "获取数据出错"
                    print(dataResponse.error ?? "出错")
                } else {
                    print("获取数据成功")
                    self.status = "获取数据成功"
                    self.carCtrl = dataResponse.value
                    
                    // 更新车辆状态
                    self.getCarStatus()
                }
            }.store(in: &cancellableSet)
    }
}
