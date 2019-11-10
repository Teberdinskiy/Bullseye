//
//  AboutView.swift
//  Bullseye
//
//  Created by 🧔🏻Alikhan Batchaev on 10.11.2019.
//  Copyright © 2019 Alikhan Batchaev. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    // Constants
    let beige = Color(red: 1.0,
                      green: 0.84,
                      blue: 0.70)
    
    // User interface content and layout
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯")
                .modifier(AboutHeadingStyle())
                    .navigationBarTitle("О Bullseye")
                Text("Это игра «Буллсай(Яблочко)», где вы можете выиграть очки и заработать славу, перетаскивая ползунок.")
                    .modifier(AboutBodyStyle())
                    .lineLimit(nil)
                Text("Ваша цель - разместить слайдер как можно ближе к заданному значению. Чем ближе вы, тем больше очков вы набрали.")
                    .modifier(AboutBodyStyle())
                    .lineLimit(nil)
                Text("Вперед!🦄")
                    .modifier(AboutBodyStyle())
                    .lineLimit(nil)
            }
            .background(beige)
        }
        .background(Image("Background"))
    }
}


struct AboutHeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Futura Bold" ,size: 30))
            .foregroundColor(Color.black)
            .padding(.top, 20)
            .padding(.bottom, 20)
    }
}

struct AboutBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Futura Bold", size: 16))
            .foregroundColor(Color.black)
            .padding(.leading, 60)
            .padding(.trailing, 60)
            .padding(.bottom, 20)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

