//
//  SpeedView.swift
//  Mazda
//
//  Created by GG on 2024/1/20.
//

import SwiftUI

struct SpeedView: View {
    var speed: Int = 166
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("车速")
                .font(.headline)
            
            Spacer()
            
            HStack(alignment: .lastTextBaseline) {
                Text("\(speed)")
                    .font(.largeTitle)
                    .frame(alignment: .leading)
                
                Spacer()
                
                Text("km/h")
                    .font(.title)
            }
        }
        .padding(10.0)
        .foregroundColor(Color("ColorSet_Function_Foreground"))
        .background(Color("ColorSet_Function_Background_On"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SpeedView()
        .frame(width: 200, height: 100, alignment: .leading)
}
