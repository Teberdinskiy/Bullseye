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
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    
    var sliderValueRounded: Int {
        Int(self.sliderValue.rounded())
    }
    
    // User interface content and layout
    var body: some View {
        VStack {
            Spacer()
            
            // Target row
            HStack {
                Text("Установите ползунок как можно ближе к:")
                Text("\(self.target)")
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
                print("Points awarded: \(self.pointsForCurrentRound())")
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Ударь меня!"/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text("Привет!🦄"),
                      message: Text(self.scoringMessage()),
                      dismissButton: .default(Text("Потрясающе!")))
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
    func pointsForCurrentRound() -> Int {
        let difference: Int
        if self.sliderValueRounded > self.target {
            difference = self.sliderValueRounded - self.target
        } else if self.target > self.sliderValueRounded {
            difference = self.target - self.sliderValueRounded
        } else {
            difference = 0
        }
        return 100 - difference
    }
    
    func scoringMessage() -> String {
        return "Значение ползунка: \(self.sliderValueRounded).\n" +
            "Выбранное значение: \(self.target).\n" +
        "Ваш счёт: \(self.pointsForCurrentRound()) в этом раунде."
    }
    
}

// Preview
// =======

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
