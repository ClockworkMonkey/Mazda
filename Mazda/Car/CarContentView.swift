//
//  CarContentView.swift
//  Mazda
//
//  Created by GG on 2024/1/20.
//

import ActivityKit
import CoreLocation
import SwiftUI

struct CarContentView: View {
    @ObservedObject var carViewModel = CarViewModel()
    
    @State private var activity: Activity<CarWidgetAttributes>? = nil
    @State private var state: Int = 0
    
    var body: some View {
        VStack(spacing: 15) {
            Button {
                carViewModel.getCarStatus()
            } label: {
                Text("更新状态")
            }
            
            HStack {
                Button {
                    if ActivityAuthorizationInfo().areActivitiesEnabled {
                        state = state + 1
                        let attributes = CarWidgetAttributes(name: "哈哈")
                        let state = CarWidgetAttributes.ContentState(emoji: "😄")
                        let content = ActivityContent<CarWidgetAttributes.ContentState>(state: state, staleDate: nil)
                        do {
                            self.activity = try Activity<CarWidgetAttributes>.request(attributes: attributes, content: content)
                        } catch let error {
                            print("出错了：\(error.localizedDescription)")
                        }
                    } else {
                        print("不支持灵动岛")
                    }
                } label: {
                    Text("灵动岛 开")
                }
                .sensoryFeedback(.success, trigger: state)
                
                Button {
                    let state = CarWidgetAttributes.ContentState(emoji: "🌍")
                    let content = ActivityContent(state: state, staleDate: .now)
                    Task {
                        await activity?.update(content)
                    }
                } label: {
                    Text("灵动岛 更新")
                }
                
                Button {
                    let state = CarWidgetAttributes.ContentState(emoji: "😂")
                    let content = ActivityContent(state: state, staleDate: .now)
                    Task {
                        await activity?.end(content, dismissalPolicy: .immediate)
                    }
                } label: {
                    Text("灵动岛 关")
                }
                
                Button {//120.718229 30.742681
                    let location = CLLocation(latitude: 30.742681, longitude: 120.718229)
                    CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) -> Void in
                        guard let placemark = placemarks?.first else { return }
                        print(placemark.country ?? "国家")
                        print(placemark.administrativeArea ?? "国家")
                        print(placemark.locality ?? "国家")
                        print(placemark.subLocality ?? "国家")
                        print(placemark.thoroughfare ?? "国家")
                        print(placemark.name ?? "国家")
                    }
                } label: {
                    Text("定位")
                }
            }
            
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
