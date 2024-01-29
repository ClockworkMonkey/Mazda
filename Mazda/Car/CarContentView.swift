//
//  CarContentView.swift
//  Mazda
//
//  Created by GG on 2024/1/20.
//

import SwiftUI

struct CarContentView: View {
    @ObservedObject var carViewModel = CarViewModel()
    
    var body: some View {
        VStack(spacing: 15) {
            if let carStatus = carViewModel.carStatus?.data {
                HStack {
                    Image(systemName: "wifi")
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text("更新时间：" + String.convertTimestamp(timestamp: TimeInterval(carStatus.time)))
                        .font(.body)
                        .foregroundColor(.white)
                }
                
                Image(systemName: "car")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                HStack {
                    // 车速
                    SpeedView(speed: carStatus.speed)
                    
                    Spacer()
                    
                    // 档位
                    GearView(gear: carStatus.gear)
                }
                .frame(maxHeight: 120)
                
                // 油量、里程
                FuelView(milegage: carStatus.mileage, oil: carStatus.oil)
                
                // 功能按键
                FunctionView(carStatus: carStatus)
            } else {
                // 网络请求状态
                Text(carViewModel.status)
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
        .background(Color(hex: 0x1e2022))
    }
}

#Preview {
    CarContentView()
}
