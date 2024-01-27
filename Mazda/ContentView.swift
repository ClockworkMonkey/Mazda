//
//  ContentView.swift
//  Mazda
//
//  Created by GG on 2023/12/12.
//

import SwiftUI

struct ContentView: View {
    let bluetoothManager = BluetoothManager.shared
    
    var body: some View {
        CarHomeView()
        
//        LightContentView()
//            .environmentObject(bluetoothManager)
    }
}

#Preview {
    ContentView()
}
