//
//  ContentView.swift
//  Mazda
//
//  Created by GG on 2023/12/12.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userViewModel = UserViewModel()
    
    var body: some View {
        VStack {
            Text("\(userViewModel.result?.data?.token ?? "1")")
            
            Button(action: {
                userViewModel.getUserInfo()
            }, label: {
                Text("Button")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
