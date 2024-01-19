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
    private let bluetoothManager = BluetoothManager.shared
    
    var body: some View {
        VStack {
            Spacer()
            
            if let carStatus = carStatusViewModel.carStatus?.data {
                PercentageRectangleView(currentLevel: Double(carStatus.oil)!)
                    .frame(width: 350, height: 80)
                
                GearView(gear: carStatus.gear)
                
                HStack {
                    Text("车外温度：\(carStatus.tempOut) °C")
                    
                    Text("车内温度：\(carStatus.tempIn) °C")
                }
                
                VStack {
                    Text("车速：\(carStatus.speed)")
                    Text("总计里程：\(carStatus.mileage) Km")
                    
                    ZStack {
                        Image(systemName: "batteryblock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 40)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(.red)
                            .cornerRadius(10)
                        
                        Text("\(carStatus.bat) V")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                
                HStack {
                    // TBOX 状态
                    FunctionButtonView(type: .internet(isOn: carStatus.online == "1"))
                    
                    // 门锁状态
                    Button(action: {
                        let isLocked = getCarIsLocked(lock: carStatus.lock)
                        carStatusViewModel.carCtrl(ctrl: isLocked ? "unlock" : "lock")
                    }, label: {
                        FunctionButtonView(type: .lock(isOn: !getCarIsLocked(lock: carStatus.lock)))
                    })
                    
                    // 发动机状态
                    Button(action: {
                        
                    }, label: {
                        FunctionButtonView(type: .engine(isOn: carStatus.engine == 1))
                    })
                }
                
                HStack {
                    // 车门状态
                    Button(action: {
                        
                    }, label: {
                        FunctionButtonView(type: .door(isOn: getDoorType(door: carStatus.door).count > 0, doorType: getDoorType(door: carStatus.door)))
                    })
                    
                    // 前备箱
                    Button(action: {
                        
                    }, label: {
                        FunctionButtonView(type: .frontTrunk(isOn: carStatus.door.hood == 1))
                    })
                    
                    // 后备箱
                    Button(action: {
                        
                    }, label: {
                        FunctionButtonView(type: .rearTrunk(isOn: carStatus.door.trunk == 1))
                    })
                }
                
                Spacer()
                
                Text("更新时间：" + convertTimestampToDate(timestamp: TimeInterval(carStatus.time)))
            }
            
            Spacer()
            
            Button {
                bluetoothManager.startScan()
            } label: {
                Text("蓝牙")
            }

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
        return doorType
    }
    
    func getCarIsLocked(lock: Lock) -> Bool {
        return lock.lf == 0 && lock.lr == 0 && lock.rf == 0 && lock.rr == 0
    }
}

#Preview {
    ContentView()
}
