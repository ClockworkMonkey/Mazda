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
    var percent: Double = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerSize: CGSize(width: lineWidth, height: lineWidth))
                    .stroke(color, lineWidth: lineWidth)
                
                HStack {
                    let width = (geometry.size.width - lineWidth * 2) * percent
                    let height = geometry.size.height - lineWidth * 2
                    
                    Spacer()
                        .frame(width: lineWidth)
                    
                    RoundedRectangle(cornerSize: CGSize(width: lineWidth, height: lineWidth))
                        .foregroundColor(color)
                        .frame(width: width, height: height)
                }
            }
        }
    }
}

#Preview {
    PercentageRectangleView(percent: 0.7)
        .frame(width: 350, height: 80)
}
