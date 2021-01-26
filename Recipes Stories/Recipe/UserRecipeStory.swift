//
//  UserRecipeStory.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 03/12/2020.
//

import SwiftUI

struct UserRecipeStory: View {
    // let images = ["openmind","girl","health","people"].shuffled()
    
    var body: some View {
        Rectangle()
            .frame(width: 380, height: 200)
            .foregroundColor(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 10)
            .overlay(
                VStack(alignment: .leading){
                    Spacer()
                    HStack{
                        Image("people")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .cornerRadius(10)
                            .clipped()
                        Spacer()
                        VStack {
                            Text("Whole food programme")
                                .font(.custom("AvenirNext-Bold", size: 15))
                                .minimumScaleFactor(0.001)
                                .padding(3)
                                .frame(width: 180)
                            Text("The World Food Programme's long experience in humanitarian and development contexts has positioned the organization well to support resilience building in order to improve food security and nutrition..")
                                .font(.custom("AvenirNext-Bold", size: 10))
                                .minimumScaleFactor(0.001)
                                .padding(8)
                                .frame(width: 180)
                            
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            )
    }
}

struct UserRecipeStory_Previews: PreviewProvider {
    static var previews: some View {
        UserRecipeStory()
    }
}
