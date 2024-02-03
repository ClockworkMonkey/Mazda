//
//  FuelView.swift
//  Mazda
//
//  Created by GG on 2024/1/19.
//

import SwiftUI

struct FuelView: View {
    @State var milegage: Int = 0
    @State var oil: String = "0"
    @State var oilConsumption: String = "0"
    @State var remaining: String = "0"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "fuelpump")
                    .font(.title)
                
                Spacer()
                
                HStack(alignment: .lastTextBaseline) {
                    Text("\(milegage)")
                        .font(.title)
                    
                    Text("km")
                        .font(.subheadline)
                }
            }
            
            Spacer()
            
            PercentageRectangleView(currentLevel: Double(oil) ?? 0)
                .frame(maxHeight: 50)
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .lastTextBaseline) {
                        Text(remaining)
                            .font(.title)
                        
                        Text("km")
                            .font(.subheadline)
                    }
                    
                    Text("剩余续航")
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack(alignment: .lastTextBaseline) {
                        Text(oil)
                            .font(.title)
                        
                        Text("L")
                            .font(.subheadline)
                    }
                    
                    Text("剩余油量")
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack(alignment: .lastTextBaseline) {
                        Text(oilConsumption)
                            .font(.title)
                        
                        Text("L/100km")
                            .font(.subheadline)
                    }
                    
                    Text("平均油耗")
                        .font(.subheadline)
                }
            }
        }
        .padding(10.0)
        .foregroundColor(Color("ColorSet_Function_Foreground"))
        .background(Color("ColorSet_Function_Background_On"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    FuelView(milegage: 1897, oil: "17", oilConsumption: "8.9", remaining: "326")
        .frame(width: 350, height: 250)
}
