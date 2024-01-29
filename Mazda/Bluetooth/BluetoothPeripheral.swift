//
//  BluetoothPeripheral.swift
//  BluetoothBox
//
//  Created by GG on 2023/11/25.
//

import CoreBluetooth
import Foundation

struct BluetoothPeripheral: Identifiable, Hashable {
    let id: UUID
    
    let uuid: String
    var name: String = "Unknown"
    var rssi: Double = 0.00
    var isConnectable: Bool = false
    var peripheral: CBPeripheral?
}

extension BluetoothPeripheral {
    static let exampleList = [
        BluetoothPeripheral(id: UUID(), uuid: UUID().uuidString, name: "Test_1", rssi: -90.1, isConnectable: false, peripheral: nil),
        BluetoothPeripheral(id: UUID(), uuid: UUID().uuidString, name: "Test_1", rssi: -90.1, isConnectable: false, peripheral: nil),
        BluetoothPeripheral(id: UUID(), uuid: UUID().uuidString, name: "Test_1", rssi: -90.1, isConnectable: false, peripheral: nil),
        BluetoothPeripheral(id: UUID(), uuid: UUID().uuidString, name: "Test_1", rssi: -90.1, isConnectable: false, peripheral: nil),
        BluetoothPeripheral(id: UUID(), uuid: UUID().uuidString, name: "Test_1", rssi: -90.1, isConnectable: false, peripheral: nil),
        BluetoothPeripheral(id: UUID(), uuid: UUID().uuidString, name: "Test_1", rssi: -90.1, isConnectable: false, peripheral: nil),
        BluetoothPeripheral(id: UUID(), uuid: UUID().uuidString, name: "Test_1", rssi: -90.1, isConnectable: false, peripheral: nil)
    ]
}
