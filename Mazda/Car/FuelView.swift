//
//  FuelView.swift
//  Mazda
//
//  Created by GG on 2024/1/19.
//

import SwiftUI

struct FuelView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "fuelpump")
                    .font(.title)
                
                Spacer()
                
                Text("累计里程: 12980 km")
                    .font(.headline)
            }
            
            Spacer()
            
            PercentageRectangleView(currentLevel: 29.2)
                .frame(maxHeight: 50)
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("235 km")
                        .font(.headline)
                    
                    Text("剩余续航")
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("7.8 L")
                        .font(.headline)
                    
                    Text("剩余油量")
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("7.8 L/100km")
                        .font(.headline)
                    
                    Text("平均油耗")
                        .font(.subheadline)
                }
            }
        }
        .padding(10.0)
        .foregroundColor(.white)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    FuelView()
        .frame(width: 350, height: 250)
}
