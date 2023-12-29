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
    case rearTrunk(isOn: Bool)
    
    var image: String {
        switch self {
        case .airConditioning(let isOn):
            return isOn ? "car.side.air.fresh" : "car.side"
        case .door(let isOn, let doorType):
            return !isOn ? "car.side.lock.open" : getDoorName(doorType: doorType)
        case .engine(let isOn):
            return isOn ? "engine.combustion" : "engine.combustion"
        case .frontTrunk(let isOn):
            return isOn ? "car.side.front.open" : "car.side.front.open"
        case .internet(let isOn):
            return isOn ? "car.rear.waves.up" : "car.rear.waves.up"
        case .rearTrunk(let isOn):
            return isOn ? "car.side.rear.open" : "car.side.rear.open"
        }
    }
    
    var color: Color {
        return isOn ? .green : .red
    }
    
    private var isOn: Bool {
        switch self {
        case .airConditioning(let isOn), .door(let isOn, _), .engine(let isOn), .frontTrunk(let isOn), .internet(let isOn), .rearTrunk(let isOn):
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
        Image(systemName: type.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 40)
            .foregroundColor(.white)
            .padding(20)
            .background(type.color)
            .cornerRadius(10)
    }
}

#Preview {
    FunctionButtonView(type: .door(isOn: true, doorType: "ACD"))
}
