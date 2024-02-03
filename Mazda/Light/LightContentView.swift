//
//  LightContentView.swift
//  Mazda
//
//  Created by GG on 2024/1/20.
//

import SwiftUI

struct LightContentView: View {
    @EnvironmentObject var bluetoothManager: BluetoothManager

    @State private var isLightOn = true
    @State private var speed = 50.0

    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(action: {
                    bluetoothManager.startScan()
                }, label: {
                    Text("连接蓝牙")
                        .padding()
                        .font(.title)
                        .background(Color.gray)
                })
                
                Button(action: {
                    bluetoothManager.writeValue(lightAPI: .powerSwitch(isOn: isLightOn))
                    isLightOn.toggle()
                }, label: {
                    Text(isLightOn ? "灯光关闭" : "灯光打开")
                        .padding()
                        .font(.title)
                        .background(Color.gray)
                })
            }
            
            HStack {
                Button(action: {
                    bluetoothManager.writeValue(lightAPI: .setRGBModel(model: UInt8(1)))
                }, label: {
                    Text("灯光RGB模式")
                        .padding()
                        .font(.title)
                        .background(Color.gray)
                })
            }
            
            HStack {
                Button(action: {
                    bluetoothManager.writeValue(lightAPI: .setDirection(isForward: true))
                }, label: {
                    Text("灯光 正向")
                        .padding()
                        .font(.title)
                        .background(Color.gray)
                })
                
                Button(action: {
                    bluetoothManager.writeValue(lightAPI: .setDirection(isForward: false))
                }, label: {
                    Text("灯光 反向")
                        .padding()
                        .font(.title)
                        .background(Color.gray)
                })
                
                Button(action: {
                    bluetoothManager.writeValue(lightAPI: .setTest(test: 3))
                }, label: {
                    Text("测试")
                        .padding()
                        .font(.title)
                        .background(Color.gray)
                })
            }
            
            HStack {
                VStack {
                    Slider(value: $speed, in: 0...255, step: 15)
                        .onChange(of: speed, initial: false) {
                            print(UInt8(speed))
                            bluetoothManager.writeValue(lightAPI: .setSpeed(speed: UInt8(speed)))
                        }
                    Text("\(speed)")
                        .foregroundColor(.blue)
                }
                
                Button(action: {
                    bluetoothManager.writeValue(lightAPI: .setSpeed(speed: 0))
                }, label: {
                    Text("灯光 速度")
                        .padding()
                        .font(.title)
                        .background(Color.gray)
                })
            }
            
            LightSingleColorView()
        }
        .background(Color("ColorSet_View_Background"))
    }
}


#Preview {
    LightContentView()
}
