//
//  InformationToggleView.swift
//  Mazda
//
//  Created by GG on 2023/12/21.
//

import SwiftUI

struct InformationToggleView: View {
    var title: String = ""
    var description: String = ""
    
    var lineWidth: Double = 5.0
    var color: Color = .green
    
    @State var isOn: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.largeTitle)
                
                Text(description)
            }
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                .fixedSize()
                .padding(EdgeInsets(top: 0, leading: -lineWidth, bottom: 0, trailing: lineWidth))
                .rotationEffect(.degrees(-90.0))
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 10))
        .background(Color(color))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    InformationToggleView(title: "Doors", description: "Closed", isOn: true)
        .frame(width: 300, height: 150)
}
