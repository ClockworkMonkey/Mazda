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
                Image("MazdaCX-5")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                HStack {
                    Image(systemName: "person.badge.clock")
                    
                    Text(String.convertTimestamp(timestamp: TimeInterval(carStatus.time)))
                        .font(.footnote)
                    
                    Spacer()
                }
                .foregroundColor(Color("ColorSet_Text"))
                
                HStack {
                    Image(systemName: "location")
                    
                    if let locationData = carViewModel.carLocation?.data {
                        Text(locationData.address)
                            .font(.footnote)
                    } else {
                        Text("未知")
                            .font(.footnote)
                    }
                    
                    Spacer()
                }
                .foregroundColor(Color("ColorSet_Text"))
                
                HStack {
                    Image(systemName: "location")
                    
                    if let locationData = carViewModel.carLocation?.data {
                        Text("经度：" + locationData.longitude)
                            .font(.footnote)
                        Text("纬度：" + locationData.latitude)
                            .font(.footnote)
                    } else {
                        Text("未知")
                            .font(.footnote)
                    }
                    
                    Spacer()
                }
                .foregroundColor(Color("ColorSet_Text"))
                
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
                    .environmentObject(carViewModel)
            } else {
                // 网络请求状态
                Text(carViewModel.status)
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color("ColorSet_Text"))
            }
        }
        .padding(.horizontal)
        .background(Color("ColorSet_View_Background"))
    }
}

#Preview {
    CarContentView()
}
