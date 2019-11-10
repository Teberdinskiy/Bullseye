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
    
    @State var score = 0
    @State var round = 1
    
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
                print("Кнопка нажата")
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Ударь меня!"/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text("Привет!🦄"),
                      message: Text(self.scoringMessage()),
                      dismissButton: .default(Text("Потрясающе!")) {
                        self.score += self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...100)
                        self.round += 1
                    }
                )
            }
            
            Spacer()
            
            // Score row
            HStack {
                Button(action: {}) {
                    Text("Начать заново")
                }
                Spacer()
                Text("Счет:")
                Text("\(self.score)")
                Spacer()
                Text("Раунд:")
                Text("\(self.round)")
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
        let maximumScore = 100
        let difference = abs(self.sliderValueRounded - self.target)
        return maximumScore - difference
    }
    
    func scoringMessage() -> String {
        return "Выбранное значение: \(self.sliderValueRounded)\n" +
            "Искомое значение: \(self.target)\n" +
        "Ваш счёт: \(self.pointsForCurrentRound()) в этом раунде"
    }
    
}

// Preview
// =======

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
