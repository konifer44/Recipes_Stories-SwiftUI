//
//  SwiftUIView.swift
//  Recipes Stories
//
//  Created by Jan Konieczny on 16/01/2021.
//

import SwiftUI
import UIKit

struct WelcomeScreen3: View {
    @EnvironmentObject var tabBarNavigationManager: TabBarNavigationManager
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("addrecipe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 170, leading: 10, bottom: 0, trailing: 10))
                
                VStack {
                    Text("Start your journey")
                    Text("with")
                    Text("Recipes Stories!")
                }
                
                
                .foregroundColor(.white)
                .font(.custom("Fraunces9pt-Black", size: 35))
                .padding(EdgeInsets(top: 40, leading: 10, bottom: 50, trailing: 10))
                Spacer()
                
                Image(systemName: "bubble.middle.bottom.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 150))
                    .padding(.bottom, 100)
                    .overlay(
                        Text("Tap plus button to add first recipe")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.custom("Fraunces9pt-Black", size: 20))
                            .frame(width: 150, alignment: .center)
                            .offset(y: -70)
                        //  .padding(.bottom, 10)
                    )
                
            }
            
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        }
        .background(
            Color(UIColor(red: 78/255, green: 182/255, blue: 162/255, alpha: 0.9))
            
        )
        // .padding(.bottom, 70)
        .edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen3()
            .preferredColorScheme(.light)
    }
}

