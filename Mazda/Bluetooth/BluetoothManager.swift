//
//  BluetoothManager.swift
//  BluetoothBox
//
//  Created by GG on 2023/11/25.
//

import CoreBluetooth
import Foundation

class BluetoothManager: NSObject, ObservableObject {
    
    static let shared = BluetoothManager()
    
    @Published var isScanning = false
    @Published var discoveredPeripherals = [BluetoothPeripheral]()
    @Published var discoveredServices = [CBService]()
    @Published var discoveredCharacteristics = [CBCharacteristic]()
    @Published var characteristicValue = ""
    
    var selectedPeripheral: BluetoothPeripheral?
    var selectedService: CBService?
    var selectedCharacteristic: CBCharacteristic?
    
    private override init() {}
    
    lazy var centralManager: CBCentralManager = {
        let centralManager = CBCentralManager()
        centralManager.delegate = self
        
        return centralManager
    }()
    
}

extension BluetoothManager {
    
    func startScan() {
        guard centralManager.state == .poweredOn else { return }
                
        isScanning = true
        centralManager.scanForPeripherals(withServices: nil)
        
        cleanSelectedData()
    }
    
    func stopScan() {
        isScanning = false
        centralManager.stopScan()
    }
    
    func connectPeripheral(_ peripheral: CBPeripheral) {
        peripheral.delegate = self
        centralManager.connect(peripheral)
    }
    
    func disconnectPeripheral(_ peripheral: CBPeripheral) {
        discoveredServices.removeAll()
        discoveredCharacteristics.removeAll()
        centralManager.cancelPeripheralConnection(peripheral)
    }
    
    func discoverServices(_ peripheral: CBPeripheral, _ serviceUUIDs: [CBUUID]?) {
        peripheral.discoverServices(serviceUUIDs)
    }
    
    func discoverCharacteristics(_ peripheral: CBPeripheral, for service: CBService) {
        peripheral.discoverCharacteristics(nil, for: service)
    }
    
    func readCharacteristic(_ peripheral: CBPeripheral, for characteristic: CBCharacteristic) {
        if characteristic.properties.contains(.read) {
            peripheral.readValue(for: characteristic)
        } else {
            print("不允许读取")
        }
    }
    
    func cleanSelectedData() {
        discoveredPeripherals.removeAll()
        discoveredServices.removeAll()
        discoveredCharacteristics.removeAll()
    }
    
}

extension BluetoothManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown, .unsupported, .resetting, .unauthorized, .poweredOff:
            stopScan()
        case .poweredOn:
            startScan()
        default:
            print("Central state is unknown.")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let id = peripheral.identifier
        let uuid = peripheral.identifier.uuidString
        let name = peripheral.name ?? "Unknown"
        let rssi = RSSI.doubleValue
        let isConnectable = advertisementData["kCBAdvDataIsConnectable"].debugDescription == "1" ? true : false
        
        let bluetoothPeripheral = BluetoothPeripheral(id: id, uuid: uuid, name: name, rssi: rssi, isConnectable: isConnectable, peripheral: peripheral)
        
        if !discoveredPeripherals.contains(where: { $0.id == id }) {
            // 设备未被扫描过，添加到设备列表
            discoveredPeripherals.append(bluetoothPeripheral)
        } else {
            // 设备已存在，更新设备信息
            if let index = discoveredPeripherals.firstIndex(where: { $0.id == id} ) {
                discoveredPeripherals[index] = bluetoothPeripheral
                objectWillChange.send()
            }
        }
        
        guard name == "LEDCAR-01-CC00" else { return }
        selectedPeripheral = bluetoothPeripheral
        connectPeripheral(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("连接设备成功")
        
        // let ledServiceUUID: CBUUID = CBUUID(string: "FFE0")
        discoverServices(peripheral, nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("断开连接成功")
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("连接设备失败")
    }
    
}

extension BluetoothManager: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("发现服务")
        
        guard let services = peripheral.services else { return }
        discoveredServices = services
        
        services.forEach { service in
            if service.uuid.uuidString == "FFE0" {
                discoverCharacteristics(peripheral, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("发现特征")
        
        guard let characteristics = service.characteristics else { return }
        discoveredCharacteristics = characteristics
        characteristics.forEach { characteristic in
            if characteristic.uuid.uuidString == "FFE1" {
                var bytes = [UInt8]()
                let text = "7bff0407ffffffffbf"
                var i = text.startIndex
                while i < text.endIndex {
                    let nextIndex = text.index(i, offsetBy: 2)
                    let hexByte = text[i ..< nextIndex]
                    if let byte:UInt8 = UInt8(hexByte, radix:16) {
                        bytes.append(byte)
                    } else {
                        return
                    }
                    i = nextIndex
                }
                let data = Data(bytes)
                peripheral.writeValue(data, for: characteristic, type: .withoutResponse)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("读取特征值")
        
        guard let data = characteristic.value else { return }
        guard let asciiString = String(data: data, encoding: .ascii) else { return }
        characteristicValue = asciiString
    }
    
}
