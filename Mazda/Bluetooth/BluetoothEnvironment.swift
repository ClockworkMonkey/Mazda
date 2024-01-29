//
//  BluetoothEnvironment.swift
//  Mazda
//
//  Created by GG on 2024/1/20.
//

import CoreBluetooth
import Foundation

enum BluetoothEnvironment {
    case dev
    case test
    case prod
}

extension BluetoothEnvironment {
    static var currentEnvironment: ServiceEnvironment {
        return .dev
    }
}

extension BluetoothEnvironment {
    static var peripheralName: String {
        switch currentEnvironment {
        case .dev, .test:
            return "LEDCAR-01-CC00"
        case .prod:
            return "LEDCAR-01-CC00"
        }
    }
    
    static var peripheralUUID: CBUUID {
        switch currentEnvironment {
        case .dev, .test:
            return CBUUID(string: "A5BB4A55-6763-6E08-B4D4-63ACD807EE03")
        case .prod:
            return CBUUID(string: "A5BB4A55-6763-6E08-B4D4-63ACD807EE03")
        }
    }
    
    static var serviceUUID: CBUUID {
        switch currentEnvironment {
        case .dev, .test:
            return CBUUID(string: "FFE0")
        case .prod:
            return CBUUID(string: "FFE0")
        }
    }
    
    static var characteristicUUID: CBUUID {
        switch currentEnvironment {
        case .dev, .test:
            return CBUUID(string: "FFE1")
        case .prod:
            return CBUUID(string: "FFE1")
        }
    }
}
