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
        VStack() {
            // 车辆状态
            Text(carViewModel.status)
            
            if let carStatus = carViewModel.carStatus?.data {
                HStack {
                    Image(systemName: "wifi")
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text("更新时间：" + convertTimestampToDate(timestamp: TimeInterval(carStatus.time)))
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
                .frame(maxHeight: 150)
                
                // 油量
                FuelView()
                
                // 功能按键
                FunctionView(carStatus: carStatus)
            }
        }
        .padding(.horizontal)
    }
    
    func convertTimestampToDate(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 按照需要的格式设置日期格式
        return dateFormatter.string(from: date)
    }
}

#Preview {
    CarContentView()
}
