//
//  BluetoothLightAPI.swift
//  Mazda
//
//  Created by GG on 2024/1/20.
//

import Foundation

enum BluetoothLightAPI {
    case powerSwitch(isOn: Bool)
    case setRGBColor(r: UInt8, g: UInt8, b: UInt8)
    case setRGBModel(model: UInt8)
    case setDirection(isForward: Bool)
    case setSpeed(speed: UInt8)
    case setTest(test: UInt8)
}

extension BluetoothLightAPI {
    
    var data: Data {
        var bytes: [UInt8] = []
        switch self {
        case .powerSwitch(let isOn):
            bytes = [123, 255, 4, isOn ? 6 : 7, 255, 255, 255, 255, 191]
        case .setRGBColor(let r, let g, let b):
            bytes = [123, 1, 7, r, g, b, 0, 255, 191]
        case .setRGBModel(let model):
            bytes = [123, 255, 3, model, 255, 255, 255, 255, 191]
        case .setDirection(let isForward):
            bytes = [123, 255, 13, isForward ? 0 : 1, 255, 255, 255, 255, 191]
        case .setSpeed(let speed):
            bytes = [123, 255, 2, speed, 0, 255, 255, 255, 191]
        case .setTest(let test):
            bytes = [123, 255, 13, test, 255, 255, 255, 255, 191]
        }
        return Data(bytes)
    }
    
}
