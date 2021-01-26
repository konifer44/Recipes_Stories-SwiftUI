//
//  FavouritesView.swift
//  Recipes Stories
//
//  Created by Jan Konieczny on 31/10/2020.
//

import SwiftUI

struct FavouritesTab: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack {
                    ForEach(recipes, id: \.self) { recipe in
                        if recipe.isFavourite {
                            NavigationLink(destination: RecipieView(recipe: recipe)) {
                                Image(uiImage: UIImage(data: recipe.image)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 380, height: 200)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                                    .padding(.top, 15)
                                    .overlay(
                                        VStack{
                                            Spacer()
                                            HStack{
                                                Spacer()
                                                Text(recipe.name)
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                            }
                                            .padding()
                                        }
                                    )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                Spacer(minLength: 80)
            }
            .navigationBarTitle("Favourites")
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesTab()
    }
}
