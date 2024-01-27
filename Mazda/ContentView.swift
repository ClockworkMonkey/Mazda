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
        TabView {
            CarHomeView()
                .tabItem {
                    Image(systemName: "car")
                    Text("车辆")
                }
            
            LightContentView()
                .environmentObject(bluetoothManager)
                .tabItem {
                    Image(systemName: "lightbulb.led")
                    Text("灯光")
                }
        }
    }
}

#Preview {
    ContentView()
}
