//
//  BluetoothManager.swift
//  BluetoothBox
//
//  Created by GG on 2023/11/25.
//

import CoreBluetooth
import Foundation

enum BluetoothState {
    case initializing
    case scanning
    case connecting
    case connected
    case connectionFailed
}

class BluetoothManager: NSObject, ObservableObject {
    
    static let shared = BluetoothManager()
    
    lazy var centralManager: CBCentralManager = {
        let centralManager = CBCentralManager()
        centralManager.delegate = self
        
        return centralManager
    }()
    
    @Published var bluetoothState: BluetoothState = .initializing
    
    var connectedPeripheral: CBPeripheral?
    var discoveredService: CBService?
    var discoveredCharacteristic: CBCharacteristic?
    
    private override init() {}
    
}

extension BluetoothManager {
    
    func startScan() {
        guard centralManager.state == .poweredOn else { return }
        
        centralManager.scanForPeripherals(withServices: nil)
        bluetoothState = .scanning
    }
    
    func stopScan() {
        centralManager.stopScan()
    }
    
    func connectPeripheral(_ peripheral: CBPeripheral) {
        peripheral.delegate = self
        centralManager.connect(peripheral)
        bluetoothState = .connecting
    }
    
    func disconnectPeripheral(_ peripheral: CBPeripheral) {
        centralManager.cancelPeripheralConnection(peripheral)
    }
    
    func discoverServices(_ peripheral: CBPeripheral, _ serviceUUIDs: [CBUUID]?) {
        peripheral.discoverServices(serviceUUIDs)
    }
    
    func discoverCharacteristics(characteristicUUIDs: [CBUUID]?, for service: CBService, for peripheral: CBPeripheral) {
        peripheral.discoverCharacteristics(characteristicUUIDs, for: service)
    }
    
    func writeValue(lightAPI: BluetoothLightAPI) {
        guard let peripheral = connectedPeripheral, let characteristic = discoveredCharacteristic else { return }
        
        peripheral.writeValue(lightAPI.data, for: characteristic, type: .withoutResponse)
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
        guard peripheral.name == BluetoothEnvironment.peripheralName else { return }
        
        connectedPeripheral = peripheral
        
        connectPeripheral(peripheral)
        stopScan()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("连接设备成功")
        bluetoothState = .connected
        
        discoverServices(peripheral, [BluetoothEnvironment.serviceUUID])
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("连接设备失败")
        bluetoothState = .connectionFailed
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("断开连接成功")
    }
    
}

extension BluetoothManager: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("发现服务")
        bluetoothState = .connected
        
        guard let services = peripheral.services else { return }
        
        services.forEach { service in
            if service.uuid == BluetoothEnvironment.serviceUUID {
                discoverCharacteristics(characteristicUUIDs: [BluetoothEnvironment.characteristicUUID], for: service, for: peripheral)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("发现特征")
        bluetoothState = .connected
        
        guard let characteristics = service.characteristics else { return }
        
        characteristics.forEach { characteristic in
            if characteristic.uuid == BluetoothEnvironment.characteristicUUID {
                discoveredCharacteristic = characteristic
                // writeValue(lightAPI: .powerSwitch(isOn: true))
            }
        }
    }
    
}
