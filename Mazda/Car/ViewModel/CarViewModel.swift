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
    @Published var carLocation: Result<CarLocation>? = nil {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var carCtrl: Result<CarCtrl>? = nil
    @Published var status: String = "等待获取数据"
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var service: Service = Service.shared
    
    init() {
        print("xxxxxx")
        self.getCarStatus()
        self.getCarLocation()
    }
}

extension CarViewModel {
    func getCarStatus() {
        status = "获取车辆状态数据中..."
        
        service.fetchData(ServiceAPI.carStatus, model: Result<CarStatus>.self)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.status = "获取车辆状态数据出错"
                    print(dataResponse.error ?? "获取车辆状态数据出错")
                } else {
                    print("获取车辆状态数据成功")
                    self.status = "获取车辆状态数据成功"
                    if dataResponse.value?.status != 200 {
                        self.status = dataResponse.value?.message ?? "获取车辆状态数据失败"
                    }
                    self.carStatus = dataResponse.value
                }
            }.store(in: &cancellableSet)
    }
    
    func carCtrl(ctrl: String) {
        status = "控制车辆中..."
        
        service.fetchData(ServiceAPI.carCtrl(ctrl: ctrl), model: Result<CarCtrl>.self)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.status = "控制车辆出错"
                    print(dataResponse.error ?? "控制车辆出错")
                } else {
                    print("控制车辆成功")
                    self.status = "控制车辆成功"
                    self.carCtrl = dataResponse.value
                    
                    // 更新车辆状态
                    self.getCarStatus()
                }
            }.store(in: &cancellableSet)
    }
    
    func getCarLocation() {
        status = "获取车辆定位中..."
        
        service.fetchData(ServiceAPI.carLocation, model: Result<CarLocation>.self)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.status = "获取定位出错"
                    print(dataResponse.error ?? "解析定位出错")
                } else {
                    print("获取定位成功")
                    self.status = "获取定位成功"
                    self.carLocation = dataResponse.value
                }
            }.store(in: &cancellableSet)
    }
}
