//
//  FunctionButtonView.swift
//  Mazda
//
//  Created by GG on 2023/12/29.
//

import SwiftUI

enum FunctionButtonType {
    case airConditioning(isOn: Bool)
    case door(isOn: Bool, doorType: String)
    case engine(isOn: Bool)
    case frontTrunk(isOn: Bool)
    case internet(isOn: Bool)
    case lock(isOn: Bool)
    case rearTrunk(isOn: Bool)
    case window(isOn: Bool)
    
    var image: String {
        switch self {
        case .airConditioning(let isOn):
            return isOn ? "car.side.air.fresh" : "car.side"
        case .door(let isOn, let doorType):
            return !isOn ? "car.side" : getDoorName(doorType: doorType)
        case .engine(let isOn):
            return isOn ? "engine.combustion" : "engine.combustion"
        case .frontTrunk(let isOn):
            return isOn ? "car.side.front.open" : "car.side.front.open"
        case .internet(let isOn):
            return isOn ? "car.rear.waves.up" : "car.rear.waves.up"
        case .lock(let isOn):
            return isOn ? "car.side.lock.open" : "car.side.lock"
        case .rearTrunk(let isOn):
            return isOn ? "car.side.rear.open" : "car.side.rear.open"
        case .window(let isOn):
            return isOn ? "arrowtriangle.up.arrowtriangle.down.window.right" : "arrowtriangle.up.arrowtriangle.down.window.right"
        }
    }
    
    var title: String {
        switch self {
        case .airConditioning:
            return "空调"
        case .door:
            return "车门"
        case .engine:
            return "引擎"
        case .frontTrunk:
            return "前备箱"
        case .internet:
            return "联网"
        case .lock:
            return "门锁"
        case .rearTrunk:
            return "后备箱"
        case .window:
            return "窗户"
        }
    }
    
    var color: Color {
        return isOn ? Color("ColorSet_Function_Background_On") : Color("ColorSet_Function_Background_Off")
    }
    
    private var isOn: Bool {
        switch self {
        case .airConditioning(let isOn), .door(let isOn, _),
                .engine(let isOn), .frontTrunk(let isOn),
                .internet(let isOn), .lock(let isOn),
                .rearTrunk(let isOn), .window(let isOn):
            return isOn
        }
    }
    
    private func getDoorName(doorType: String) -> String {
        var doorName: String = "car.top.door"
        var doors: [String] = []
        if doorType.contains("A") {
            doors.append("front.left")
        }
        if doorType.contains("B") {
            doors.append("front.right")
        }
        if doorType.contains("C") {
            doors.append("rear.left")
        }
        if doorType.contains("D") {
            doors.append("rear.right")
        }
        for (index, value) in doors.enumerated() {
            if index == 0 {
                doorName = doorName + "." + value
            } else {
                doorName = doorName + ".and." + value
            }
        }
        return doorName + ".open"
    }
}

struct FunctionButtonView: View {
    var type: FunctionButtonType
    
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: type.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .frame(width: geometry.size.width, height: 70)
                .foregroundColor(Color("ColorSet_Function_Foreground"))
                .background(type.color)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    FunctionButtonView(type: .window(isOn: false))
}
