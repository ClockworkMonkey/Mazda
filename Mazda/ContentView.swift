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
    
    private let fuelTankCapacity: Double = 53.0
    
    var body: some View {
        VStack {
            Spacer()
            
            if let carStatus = carStatusViewModel.carStatus?.data {
                PercentageRectangleView(currentLevel: Double(carStatus.oil)!)
                    .frame(width: 350, height: 80)
                
                GearView(gear: carStatus.gear)
                
                VStack {
                    Text("车速：\(carStatus.speed)")
                    Text("总计里程：\(carStatus.mileage) Km")
                    Text("电池电压：\(carStatus.bat) V")
                }
                
                HStack {
                    Text("车外温度：\(carStatus.tempOut) °C")
                    
                    Text("车内温度：\(carStatus.tempIn) °C")
                }
                
                VStack {
                    HStack {
                        Text("左前门锁：\(carStatus.lock.lf == 0 ? "关" : "开")")
                        
                        Text("右前门锁：\(carStatus.lock.rf == 0 ? "关" : "开")")
                    }
                    
                    HStack {
                        Text("左后门锁：\(carStatus.lock.lr == 0 ? "关" : "开")")
                        
                        Text("右后门锁：\(carStatus.lock.rr == 0 ? "关" : "开")")
                    }
                }
                
                HStack {
                    Button(action: {
                        
                    }, label: {
                        FunctionButtonView(type: .internet(isOn: carStatus.online == "1"))
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        FunctionButtonView(type: .engine(isOn: carStatus.engine == 1))
                    })
                }
                
                HStack {
                    Button(action: {
                        
                    }, label: {
                        FunctionButtonView(type: .door(isOn: getDoorType(door: carStatus.door).count > 0, doorType: getDoorType(door: carStatus.door)))
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        FunctionButtonView(type: .frontTrunk(isOn: carStatus.door.hood == 1))
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        FunctionButtonView(type: .rearTrunk(isOn: carStatus.door.trunk == 1))
                    })
                }
                
                Spacer()
                
                Text("更新时间：" + convertTimestampToDate(timestamp: TimeInterval(carStatus.time)))
            }
            
            Spacer()

            Text(carStatusViewModel.status)
        }
    }
    
    func convertTimestampToDate(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 按照需要的格式设置日期格式
        return dateFormatter.string(from: date)
    }
}

extension ContentView {
    func getDoorType(door: Door) -> String {
        var doorType: String = ""
        if door.lf == 1 {
            doorType += "A"
        }
        if door.rf == 1 {
            doorType += "B"
        }
        if door.lr == 1 {
            doorType += "C"
        }
        if door.rr == 1 {
            doorType += "D"
        }
        return ""
    }
}

#Preview {
    ContentView()
}
