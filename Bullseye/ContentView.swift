//
//  ContentView.swift
//  Bullseye
//
//  Created by 🧔🏻Alikhan Batchaev on 09.11.2019.
//  Copyright © 2019 Alikhan Batchaev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // Properties
    
    
    // User interface views
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    
    // User interface content and layout
    var body: some View {
        VStack {
            Spacer()
            
            // Target row
            HStack {
                Text("Установите ползунок как можно ближе к:")
                Text("100")
            }
            
            Spacer()
            
            // Slider row
            HStack {
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            
            Spacer()
            
            // Button row
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Ударь меня!"/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text("Hello there"),
                      message: Text("Значение ползунка равно \(Int(sliderValue.rounded()))"),
                      dismissButton: .default(Text("Awesome!")))
            }
            
            Spacer()
            
            // Score row
            HStack {
                Button(action: {}) {
                    Text("Начать заново")
                }
                Spacer()
                Text("Счет:")
                Text("999999")
                Spacer()
                Text("Раунд:")
                Text("999")
                Spacer()
                Button(action: {}) {
                    Text("Информация")
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    // Methods
    // =======
}

// Preview
// =======

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
