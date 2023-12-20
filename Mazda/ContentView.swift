//
//  ContentView.swift
//  Mazda
//
//  Created by GG on 2023/12/12.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var carStatusViewModel = CarViewModel()
    
    var body: some View {
        VStack {
            Text(userViewModel.userInfo?.data?.mobile ?? "xxx")
            
            Button(action: {
                userViewModel.getUserInfo()
            }, label: {
                Text("获取用户信息")
            })
            
            Text(carStatusViewModel.carStatus?.data?.bat ?? "xxx")
            
            Button(action: {
                carStatusViewModel.getCarStatus()
            }, label: {
                Text("获取车辆状态")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
