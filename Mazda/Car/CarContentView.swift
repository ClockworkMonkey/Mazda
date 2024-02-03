//
//  CarContentView.swift
//  Mazda
//
//  Created by GG on 2024/1/20.
//

import SwiftUI

struct CarContentView: View {
    @ObservedObject var carViewModel = CarViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    
    var body: some View {
        VStack(spacing: 15) {
            if let carStatus = carViewModel.carStatus?.data {
                Image("MazdaCX-5")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(hex: 0x45d9fd))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                HStack {
                    Image(systemName: "person.badge.clock")
                    
                    Text(String.convertTimestamp(timestamp: TimeInterval(carStatus.time)))
                        .font(.footnote)
                    
                    Spacer()
                }
                .foregroundColor(Color(hex: 0x52616a))
                
                HStack {
                    Image(systemName: "location")
                    
                    if let userRole = userViewModel.userRole {
                        Text(userRole.data?.carinfo.lastPosition ?? "未知")
                            .font(.footnote)
                    } else {
                        Text("未知")
                            .font(.footnote)
                    }
                    
                    Spacer()
                }
                .foregroundColor(Color(hex: 0x52616a))
                
                Spacer()
                
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
                    .frame(maxHeight: 160)
                
                // 功能按键
                FunctionView(carStatus: carStatus)
                    .frame(maxHeight: 160)
            } else {
                // 网络请求状态
                Text(carViewModel.status)
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color(hex: 0x52616a))
            }
        }
        .padding(.horizontal)
        .background(Color(hex: 0x1e2022))
    }
}

#Preview {
    CarContentView()
}
