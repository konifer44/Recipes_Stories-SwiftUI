//
//  HomeTab.swift
//  Recipes Stories
//
//  Created by Jan Konieczny on 16/01/2021.
//

import SwiftUI

struct HomeTab: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var coreDataRecipes: FetchedResults<Recipe>
    @State var featuredRecipe: FetchedResults<Recipe>.Element?
    @State var unwrappedFeaturedRecipeImage: Image?
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                GeometryReader { geometry in
                    if (featuredRecipe != nil){
                        NavigationLink(destination: RecipieView(recipe: featuredRecipe!)) {
                            ZStack {
                                if geometry.frame(in: .global).minY <= 0 {
                                    ZStack{
                                        unwrappedFeaturedRecipeImage?
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geometry.size.width, height: geometry.size.height)
                                            .clipped()
                                        FeaturedRecipeView(featuredRecipe: featuredRecipe!)
                                            .offset(y: geometry.size.height / 2.5)
                                    }
                                    .offset(y: geometry.frame(in: .global).minY/9)
                                } else {
                                    ZStack{
                                        unwrappedFeaturedRecipeImage?
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                                            .clipped()
                                        FeaturedRecipeView(featuredRecipe: featuredRecipe!)
                                            .offset(y: (geometry.size.height + geometry.frame(in: .global).minY) / 2.5 )
                                    }
                                    
                                    .offset(y: -geometry.frame(in: .global).minY)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.bottom, 70)
                .frame(height: 600)
                
                
                VStack(spacing: 10){
                    HStack{
                        Text("Latest recipes")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 25, trailing: 0))
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        Spacer(minLength: 5)
                        HStack(alignment: .top, spacing: 0) {
                            ForEach(coreDataRecipes, id: \.self) { recipe in
                                if !recipe.image.isEmpty {
                                    VStack {
                                        NavigationLink(destination:
                                                        RecipieView(recipe: recipe)) {
                                            unwrappImage(imageData: recipe.image)?
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 175, height: 175)
                                                .cornerRadius(10)
                                                .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                                .contextMenu {
                                                    Button(action: {
                                                        if recipe.isFavourite {
                                                            
                                                            let newIsFavourite = false
                                                            managedObjectContext.performAndWait {
                                                                recipe.isFavourite = newIsFavourite
                                                                try? managedObjectContext.save()
                                                            }
                                                            
                                                        } else {
                                                            
                                                            let newIsFavourite = true
                                                            managedObjectContext.performAndWait {
                                                                recipe.isFavourite = newIsFavourite
                                                                try? managedObjectContext.save()
                                                            }
                                                            
                                                        }
                                                        
                                                    }) {
                                                        if recipe.isFavourite {
                                                            Text("Remove from favourites")
                                                            Image(systemName: "heart.slash")
                                                        } else {
                                                            Text("Add to favourites")
                                                            Image(systemName: "heart")
                                                        }
                                                    }
                                                    Button(action: {
                                                        //do nothing yet
                                                    }) {
                                                        Text("Share")
                                                        Image(systemName: "square.and.arrow.up")
                                                            .foregroundColor(.red)
                                                    }
                                                    
                                                    Button(action: {
                                                        managedObjectContext.delete(recipe)
                                                        try? managedObjectContext.save()
                                                        unwrapRandomRecipe(recipes: coreDataRecipes)
                                                    }) {
                                                        Text("Delete recipe")
                                                        Image(systemName: "trash.circle")
                                                            .foregroundColor(.red)
                                                    }
                                                }
                                            
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        
                                        HStack {
                                            Text("\(recipe.name)")
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                .padding(.leading, 3)
                                            
                                            Spacer()
                                        }
                                    }
                                    .padding(.leading, 15)
                                }
                            }
                        }
                        
                    }
                    .frame(height: 160)
                    .padding(.bottom, 45)
                    
                    
                    HStack{
                        Text("Did You know?")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 0))
                    
                    UserRecipeStory()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                    
                    
                    HStack{
                        Text("See also:")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 0))
                    
                    unwrappImage(imageData: coreDataRecipes.randomElement()?.image)?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 380, height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                Spacer(minLength: 80)
            }
            .navigationBarHidden(true)
        }
        .onAppear{
            unwrapRandomRecipe(recipes: coreDataRecipes)
            
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
    
    func unwrapRandomRecipe(recipes: FetchedResults<Recipe>){
        guard let unwrappedElement =  coreDataRecipes.randomElement() else { return }
        unwrappedFeaturedRecipeImage = unwrappImage(imageData: unwrappedElement.image)
        featuredRecipe = unwrappedElement
    }
    
    func unwrappImage(imageData: Data?) -> Image? {
        guard let imageData = imageData else { return nil }
        guard let uiImage = UIImage(data: imageData) else { return nil }
        let image = Image(uiImage: uiImage)
        return image
    }
    
    
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.persistentContainer.viewContext
        HomeTab()
            .environment(\.managedObjectContext, context)
    }
}






