//
//  GearView.swift
//  Mazda
//
//  Created by GG on 2023/12/21.
//

import SwiftUI

struct GearView: View {
    @State var gear: String = "P"
    
    private let gears: [[String]] = [["P", "R"], ["N", "D"]]
    
    var body: some View {
        VStack {
            ForEach(gears, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { gear in
                        GeometryReader { geometry in
                            Text(gear)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .font(.largeTitle)
                                .foregroundColor(Color.white)
                                .background(gear == self.gear ? Color.blue : Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GearView(gear: "P")
        .background(Color.green)
}
