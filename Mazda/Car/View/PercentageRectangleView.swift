//
//  PercentageRectangleView.swift
//  Mazda
//
//  Created by GG on 2023/12/21.
//

import SwiftUI

struct PercentageRectangleView: View {
    var color: Color = .white
    var lineWidth: Double = 4.0
    
    let fuelTankCapacity: Double = 53.0
    var currentLevel: Double = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: lineWidth)
                    .inset(by: lineWidth / 2)
                    .stroke(color, lineWidth: lineWidth)
                
                HStack {
                    let width = (geometry.size.width - lineWidth * 3) * currentLevel / fuelTankCapacity
                    let height = geometry.size.height - lineWidth * 3
                    
                    Spacer()
                        .frame(width: lineWidth * 1.5)
                    
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundColor(color)
                        .frame(width: width, height: height)
                }
            }
        }
    }
}

#Preview {
    PercentageRectangleView(currentLevel: 29.2)
        .background(Color.blue)
}
