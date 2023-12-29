//
//  PercentageRectangleView.swift
//  Mazda
//
//  Created by GG on 2023/12/21.
//

import SwiftUI

struct PercentageRectangleView: View {
    var color: Color = .green
    var lineWidth: Double = 5.0
    
    let fuelTankCapacity: Double = 53.0
    var currentLevel: Double = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerSize: CGSize(width: lineWidth, height: lineWidth))
                        .stroke(color, lineWidth: lineWidth)
                    
                    HStack {
                        let width = (geometry.size.width - lineWidth * 2) * currentLevel / fuelTankCapacity
                        let height = geometry.size.height - lineWidth * 2
                        
                        Spacer()
                            .frame(width: lineWidth)
                        
                        RoundedRectangle(cornerSize: CGSize(width: lineWidth, height: lineWidth))
                            .foregroundColor(color)
                            .frame(width: width, height: height)
                    }
                }
                
                Text("\(String(format: "%.1f", currentLevel)) L")
                    .foregroundStyle(Color.primary)
            }
        }
    }
}

#Preview {
    PercentageRectangleView(currentLevel: 40.0)
        .frame(width: 350, height: 80)
}
