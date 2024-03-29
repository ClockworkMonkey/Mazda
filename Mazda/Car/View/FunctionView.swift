//
//  FunctionView.swift
//  Mazda
//
//  Created by GG on 2024/1/20.
//

import SwiftUI

struct FunctionView: View {
    @EnvironmentObject var carViewModel: CarViewModel
    @State var carStatus: CarStatus
    
    // 车门锁、后备箱、引擎、车窗、寻车
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                let width = (geometry.size.width - 30) / 4
                
                HStack(spacing: 10) {
                    Group {
                        // TBOX 状态
                        FunctionButtonView(type: .internet(isOn: carStatus.online == "1"))
                        
                        // TBOX 状态
                        FunctionButtonView(type: .internet(isOn: carStatus.online == "1"))
                        
                        // 车门状态
                        FunctionButtonView(type: .door(isOn: getDoorType(door: carStatus.door).count > 0, doorType: getDoorType(door: carStatus.door)))
                        
                        // 车门状态
                        FunctionButtonView(type: .door(isOn: getDoorType(door: carStatus.door).count > 0, doorType: getDoorType(door: carStatus.door)))
                    }
                    .frame(width: width)
                }
                
                HStack(spacing: 10) {
                    Group {
                        // 车窗
                        Button(action: {
                            carViewModel.carCtrl(ctrl: "rise_window")
                            // carViewModel.carCtrl(ctrl: "drop_window")
                        }, label: {
                            FunctionButtonView(type: .window(isOn: !getWindowIsLocked(window: carStatus.window)))
                        })
                        
                        // 后备箱
                        Button(action: {
                            if !getCarIsLocked(lock: carStatus.lock) {
                                carViewModel.carCtrl(ctrl: "trunk_toggle")
                            }
                        }, label: {
                            FunctionButtonView(type: .rearTrunk(isOn: carStatus.door.trunk == 1))
                        })
                        
                        // 门锁状态
                        Button(action: {
                            let isLocked = getCarIsLocked(lock: carStatus.lock)
                            carViewModel.carCtrl(ctrl: isLocked ? "unlock" : "lock")
                        }, label: {
                            FunctionButtonView(type: .lock(isOn: !getCarIsLocked(lock: carStatus.lock)))
                        })
                        
                        // 发动机状态
                        Button(action: {
                            let isLocked = getCarIsLocked(lock: carStatus.lock)
                            carViewModel.carCtrl(ctrl: isLocked ? "stall" : "start")
                        }, label: {
                            FunctionButtonView(type: .engine(isOn: carStatus.engine == 1))
                        })
                    }
                    .frame(width: width)
                }
            }
        }
    }
}

extension FunctionView {
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
    
    func getWindowIsLocked(window: Window) -> Bool {
        return window.lf == 0 && window.lr == 0 && window.rf == 0 && window.rr == 0
    }
}

//#Preview {
//    FunctionView()
//}
