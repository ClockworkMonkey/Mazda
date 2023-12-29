//
//  GearView.swift
//  Mazda
//
//  Created by GG on 2023/12/21.
//

import SwiftUI

struct GearView: View {
    @State var gear: String = "P"
    
    private let gears: [String] = ["P", "R", "N", "D"]
    
    var body: some View {
        HStack {
            ForEach(gears, id: \.self) { gear in
                Text(gear)
                    .font(.largeTitle)
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(gear == self.gear ? Color.blue : Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    GearView(gear: "R")
}
