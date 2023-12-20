//
//  ContentView.swift
//  Mazda
//
//  Created by GG on 2023/12/12.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var carStatusViewModel = CarViewModel()
    
    var body: some View {
        VStack {
            if let carStatus = carStatusViewModel.carStatus?.data {
                VStack {
                    Text("在线状态：\(carStatus.online)")
                    Text("车速：\(carStatus.speed)")
                    
                    Text("时间戳：\(carStatus.time)")
                    
                    Text("引擎状态：\(carStatus.engine)")
                    
                    Text("剩余油量：\(carStatus.oil) L")
                    Text("总计里程：\(carStatus.mileage) Km")
                    Text("电池电压：\(carStatus.bat) V")
                    Text("档位：\(carStatus.gear)")
                }
                VStack {
                    Text("车外温度：\(carStatus.tempOut) c")
                    Text("车内温度：\(carStatus.tempIn) c")
                }
                VStack {
                    Text("左前门锁：\(carStatus.lock.lf)")
                    Text("左后门锁：\(carStatus.lock.lr)")
                    Text("右前门锁：\(carStatus.lock.rf)")
                    Text("右后门锁：\(carStatus.lock.rr)")
                }
                VStack {
                    Text("左前门：\(carStatus.door.lf)")
                    Text("左后门：\(carStatus.door.lr)")
                    Text("右前门：\(carStatus.door.rf)")
                    Text("右后门：\(carStatus.door.rr)")
                    Text("前备箱：\(carStatus.door.hood)")
                    Text("后备箱：\(carStatus.door.trunk)")
                }
            }
            Button(action: {
                carStatusViewModel.getCarStatus()
            }, label: {
                Text("获取车辆状态")
            })
        }
    }
}

#Preview {
    ContentView()
}
