//
//  FeaturedRecipeView.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 03/12/2020.
//

import SwiftUI

struct FeaturedRecipeView: View {
    @StateObject var featuredRecipe: FetchedResults<Recipe>.Element
    var body: some View {
        Rectangle()
            .frame(width: 380, height: 200)
            .cornerRadius(10)
            .shadow(radius: 10)
            .foregroundColor(Color(UIColor.systemGray6))
            .overlay(
                VStack(alignment: .leading){
                    Spacer()
                    Text("CHOICE OF WEEKEND")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                        .foregroundColor(.yellow)
                    Text("\(featuredRecipe.name)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 2, leading: 20, bottom: 10, trailing: 0))
                    HStack{
                        Image(systemName: "heart.circle")
                            .font(.system(size: 20))
                        Text("\(featuredRecipe.likes)")
                        Spacer()
                        StarRatedView(rating: Int(featuredRecipe.rating))
                    }
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 30, trailing: 30))
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            )
    }
}
