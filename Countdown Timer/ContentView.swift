//
//  ContentView.swift
//  Countdown Timer
//
//  Created by Howard Benditsky on 5/18/23.
//

import SwiftUI

// a struct is used to store variables of different data types.


struct ContentView: View {
    @StateObject private var vm = ViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in:
            .common) .autoconnect()
    private let width: Double = 250
    
    var body: some View {
        VStack {       // VStack specifies a view which arranges subviews vertically
            Text("\(vm.time)")
                .font(.system(size:70, weight: .medium, design: .rounded))
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 4))
                .alert("Timer done!", isPresented: $vm.showingAlert) {
                    Button("Continue", role: .cancel) {
                        // Code
                    }
                }
            
            Slider(value: $vm.minutes, in: 1...60, step: 1)
                .padding()
                .frame(width: width)
                .disabled(vm.isActive)
                .animation(.easeInOut, value: vm.minutes)  // animates the slider
            
            HStack(spacing:50) {   // HStack specifies a view wich arranges subviews horizontally
                
                Button("Start:") {      // This code creates the Start button
                    vm.start(minutes: vm.minutes)  // This code starts the timer
                }
                .disabled(vm.isActive)
                
                Button("Reset", action: vm.reset)   // this code creates the Rest button and makes it red
                    .tint(.red)
            }
            .frame(width: width)
            
            .onReceive(timer) { _ in
                vm.updateCountDown()
            }
        }
        
    }
    
    
}
