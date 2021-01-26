//
//  NewWelcomeScreen.swift
//  Recipes Stories
//
//  Created by Jan Konieczny on 17/01/2021.
//

import SwiftUI

struct WelcomeScreen1: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color.orange
                VStack{
                    Image("welcome2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 150)
                    
                    Text("Get inspired")
                        .foregroundColor(.white)
                        .font(.custom("Fraunces9pt-Black", size: 35))
                        .padding(.top, 50)
                    
                    Text("Don't know to eat? Easy! With Recipes Stories You will allways find perfect recipe")
                        .foregroundColor(.white)
                        .font(.custom("Fraunces9pt-Black", size: 15))
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .padding()
                    
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: WelcomeScreen2(),
                            label: {
                                HStack {
                                    Text("NEXT")
                                    Image(systemName: "arrow.right")
                                }
                                .foregroundColor(.white)
                            })
                            
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 20))
                    }
                    //  Spacer()
                    
                    
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct WelcomeScreen1_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen1()
    }
}
