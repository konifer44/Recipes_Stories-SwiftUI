//
//  ShoppingList.swift
//  Recipes Stories
//
//  Created by Jan Konieczny on 31/10/2020.
//

import SwiftUI
import Firebase
import FirebaseDatabase



struct ShoppingListTab: View {
    let coreDataSample = CoreDataSampleRecipe()
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var Firebase: Firebase
    
    @AppStorage("isNewUser") var isNewUser: Bool = true
    
    @State var recipe = RecipeModel(ref: nil, key: "", id: UUID(), name: "Pizza", shortRecipeDescribe: "sdas", selectedTimeOfPrepare: 5, levelOfDifficulty: "hard", rating: 3, isFavourite: true, numberOfIngredients: 4, numberOfSteps: 4, ingredientsList: [IngredientModel(id: UUID(), name: "sdd", quantity: "sd", unit: 1)], methodStepsList: [MethodStepModel(id: UUID(), name: "name", describe: "describe")])
    
    @State var recipes: [RecipeViewModel] = []
    
    func reciveData(){
        var newData: [RecipeViewModel] = []
        Firebase.ref.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let recipe = RecipeViewModel(snapshot: snapshot) {
                    newData.append(recipe)
                    recipe.saveToCoreData()
                }
                
            }
            recipes = newData
        })
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add sample recipe"){
                    coreDataSample.saveToCoreData()
                }
                .padding(.bottom, 40)
                
                Button("restart isNewUser"){
                    isNewUser = true
                }
                .padding(.bottom, 40)
                
                Button("download"){
                    
                    reciveData()
                    print(recipes.count)
                }
                .padding(.bottom, 40)
                
                Button("save to database"){
                    Firebase.saveData(recipe: RecipeViewModel(with: recipe))
                }
                .padding(.bottom, 40)
                
                Text("\(recipes.count)")
                
                ForEach(recipes){ rec in
                    Text(rec.shortRecipeDescribe)
                }
                //  .navigationTitle("User Info")
                
                
                
            }
        }
    }
}

struct ShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListTab()
    }
}
