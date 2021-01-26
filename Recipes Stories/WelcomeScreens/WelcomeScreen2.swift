//
//  NewWelcomeScreen.swift
//  Recipes Stories
//
//  Created by Jan Konieczny on 17/01/2021.
//

import SwiftUI
import UIKit

struct WelcomeScreen2: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var tabBarNavigationManager: TabBarNavigationManager
    var body: some View {
        ZStack{
            Color(UIColor(red: 207/255, green: 48/255, blue: 150/255, alpha: 0.9))
            VStack{
                Image("welcome3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                    .padding(EdgeInsets(top: 110, leading: 60, bottom: 0, trailing: 60))
                
                Text("Save your recipes")
                    .foregroundColor(.white)
                    .font(.custom("Fraunces9pt-Black", size: 35))
                    .padding(.top, 50)
                
                Text("Recipes Stories is prefect place to save all your recipes and ideas. You will never forget again your recipes")
                    .foregroundColor(.white)
                    .font(.custom("Fraunces9pt-Black", size: 15))
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                    .padding()
                
                Spacer()
                
                
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("BACK")
                        }
                        .foregroundColor(.white)
                    })
                    Spacer()
                    NavigationLink(
                        destination: LoginView(),
                        label: {
                            HStack {
                                Text("NEXT")
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.white)
                        })
                    
                    
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 80, trailing: 20))
                
                
                
                //  Spacer()
                
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        
        
    }
}

struct WelcomeScreen2_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen2()
    }
}
