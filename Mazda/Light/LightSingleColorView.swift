//
//  LightSingleColorView.swift
//  Mazda
//
//  Created by GG on 2024/1/20.
//

import SwiftUI

struct LightSingleColorView: View {
    @EnvironmentObject var bluetoothManager: BluetoothManager
    
    @Environment(\.self) var environment
    @State private var selectedColor: Color = .orange
    @State private var resolvedColor: Color.Resolved?

    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(selectedColor))
            
            ColorPicker("选择颜色", selection: $selectedColor, supportsOpacity: false)
        }
        .onChange(of: selectedColor, initial: false) { oldValue, newValue in
            resolvedColor = newValue.resolve(in: environment)
            guard let resolvedColor = resolvedColor else { return }
            let r = UInt8(Double(resolvedColor.red * 255).rounded())
            let g = UInt8(Double(resolvedColor.green * 255).rounded())
            let b = UInt8(Double(resolvedColor.blue * 255).rounded())
            bluetoothManager.writeValue(lightAPI: .setRGBColor(r: r, g: g, b: b))
        }
    }
}

#Preview {
    LightSingleColorView()
}
