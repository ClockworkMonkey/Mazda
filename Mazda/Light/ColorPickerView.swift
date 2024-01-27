//
//  ColorPickerView.swift
//  Mazda
//
//  Created by GG on 2024/1/20.
//

import SwiftUI

struct ColorPickerView: View {
    @Environment(\.self) var environment
    @State private var color = Color.red
    @Binding var components: Color.Resolved?

    var body: some View {
        VStack {
            ColorPicker("选择颜色", selection: $color)

            if let components {
                Text("R: \(components.red)")
                Text("G: \(components.green)")
                Text("B: \(components.blue)")
                Text("A: \(components.opacity)")
                Text("HEX: \(components.description)")
            }
        }
        .padding()
        .onChange(of: color, initial: true) {
            components = color.resolve(in: environment)
        }
    }
}

#Preview {
     ColorPickerView(components: .constant(nil))
}
