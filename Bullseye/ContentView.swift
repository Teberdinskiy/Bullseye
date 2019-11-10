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
    
    // Colors
    let midnightBlue = Color(red: 0,
                             green: 0.2,
                             blue: 0.4)
    
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
        NavigationView {
            VStack {
                Spacer().navigationBarTitle("🎯 Bullseye 🎯")
                
                // Target row
                HStack {
                    Text("Установите ползунок как можно ближе к:").modifier(LabelStyle())
                    Text("\(target)").modifier(ValueStyle())
                }
                
                Spacer()
                
                // Slider row
                HStack {
                    Text("1").modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                        .accentColor(Color.green)
                        .animation(.easeOut)
                    Text("100").modifier(LabelStyle())
                }
                
                Spacer()
                
                // Button row
                Button(action: {
                    print("Кнопка нажата")
                    self.alertIsVisible = true
                }) {
                    Text("Ударь меня!").modifier(ButtonLargeTextStyle())
                }
                .background(Image("Button")
                .modifier(Shadow())
                )
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
                        HStack {
                            Image("StartOverIcon")
                            Text("Начать заново").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button")
                    .modifier(Shadow())
                    )
                    Spacer()
                    Text("Счет:").modifier(LabelStyle())
                    Text("\(score)").modifier(ValueStyle())
                    Spacer()
                    Text("Раунд:").modifier(LabelStyle())
                    Text("\(round)").modifier(ValueStyle())
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image("InfoIcon")
                            Text("Информация").modifier(ButtonSmallTextStyle())
                        }
                    }
                    .background(Image("Button")
                    .modifier(Shadow())
                    )
                }
                .padding(.bottom, 20)
                .accentColor(midnightBlue)
            }
            .onAppear() {
                self.startNewGame()
            }
            .background(Image("Background"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
            title = "Почти"
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
    
    // View modifiers
    // ==============
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(Color.white)
                .modifier(Shadow())
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 15))
                .foregroundColor(Color.black)
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 9))
                .foregroundColor(Color.black)
        }
    }
}

// Preview
// =======

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

