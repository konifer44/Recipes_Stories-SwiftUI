//
//  NewRecipeSummaryView.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 28/11/2020.
//

import SwiftUI

struct RecipeSummaryView: View {
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipies: FetchedResults<Recipe>
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.colorScheme) var colorScheme
    
    @State var recipe: FetchedResults<Recipe>.Element
    
    let width: CGFloat = 370
    let height: CGFloat = 110
    let offset: CGFloat = 45
    
    var body: some View {
        Rectangle()
            .offset(y: -offset)
            .frame(width: width, height: height)
            .background( (colorScheme == .dark ?  Color(UIColor.systemGray6) : Color.white))
            .foregroundColor(Color.yellow)
            .clipped()
            .overlay(
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text(recipe.name)
                                .font(.custom("AvenirNext-Bold", size: 30))
                                .minimumScaleFactor(0.01)
                            Text(recipe.shortRecipeDescribe)
                                .font(.custom("AvenirNext-Regular", size: 15))
                                .minimumScaleFactor(0.01)
                        }
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top:8, leading: 20, bottom: 3, trailing: 0))
                        
                        
                        Spacer()
                        Image(systemName: recipe.isFavourite ? "heart.fill" : "heart")
                            .font(.system(size: 30))
                            .foregroundColor(.red)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 20))
                            .highPriorityGesture(
                                TapGesture()
                                    .onEnded { _ in
                                        print("TAPPED")
                                        recipe.isFavourite.toggle()
                                        try? managedObjectContext.save()
                                    }
                                
                            )
                    }
                    .frame(height: height - offset)
                    
                    HStack{
                        Spacer()
                        Image(systemName: "star")
                            .foregroundColor(Color.yellow)
                        Text("\(recipe.rating)")
                        Spacer()
                        Image(systemName: "hand.point.right")
                            .foregroundColor(Color.green)
                        Text(recipe.levelOfDifficulty)
                        Spacer()
                        Image(systemName: "clock")
                            .foregroundColor(Color.blue)
                        Text("\(recipe.timeOfPrepare) min")
                        Spacer()
                    }
                    .frame(height: offset)
                }
                
            )
            .cornerRadius(15)
            .shadow(radius: 10)
    }
}


