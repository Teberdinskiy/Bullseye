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
        Int(sliderValue.rounded())
    }
    
    @State var score = 0
    @State var round = 1
    
    var sliderTargetDifference: Int {
        abs(sliderValueRounded - target)
    }
    
    // User interface content and layout
    var body: some View {
        VStack {
            Spacer()
            
            // Target row
            HStack {
                Text("Установите ползунок как можно ближе к:")
                Text("\(target)")
            }
            
            Spacer()
            
            // Slider row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
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
            .alert(isPresented: $alertIsVisible) {
                Alert(title: Text(alertTitle()),
                      message: Text(scoringMessage()),
                      dismissButton: .default(Text("Новый раунд!")) {
                        self.startNewRound()
                    }
                )
            }
            
            Spacer()
            
            // Score row
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    Text("Начать заново")
                }
                Spacer()
                Text("Счет:")
                Text("\(score)")
                Spacer()
                Text("Раунд:")
                Text("\(round)")
                Spacer()
                Button(action: {}) {
                    Text("Информация")
                }
            }
            .padding(.bottom, 20)
        }
        .onAppear() {
            self.startNewGame()
        }
    }
    
    // Methods
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let points: Int
        if sliderTargetDifference == 0 {
            points = 200
        } else if sliderTargetDifference == 1 {
            points = 150
        } else {
            points = maximumScore - sliderTargetDifference
        }
        return points
    }
    
    func scoringMessage() -> String {
        return "Выбранное значение: \(sliderValueRounded)\n" +
            "Искомое значение: \(target)\n" +
        "Ваш счёт: \(pointsForCurrentRound()) в этом раунде"
    }
    
    func alertTitle() -> String {
        let title: String
        if sliderTargetDifference == 0 {
            title = "Отлично!"
        } else if sliderTargetDifference < 5 {
            title = "Ты был совсем рядом!"
        } else if sliderTargetDifference <= 10 {
            title = "Неплохо."
        } else {
            title = "Ты вообще пытаешься?"
        }
        return title
    }
    
    func startNewGame() {
        score = 0
        round = 1
        resetSliderAndTarget()
    }
    
    func startNewRound() {
        score += pointsForCurrentRound()
        round += 1
        resetSliderAndTarget()
    }
    
    func resetSliderAndTarget() {
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
    }
}

// Preview
// =======

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
