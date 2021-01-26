//
//  AddIngredientView.swift
//  newIngredients
//
//  Created by Jan Konieczny on 12/01/2021.
//

import SwiftUI

struct AddIngredientView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    
    var body: some View {
        VStack{
            Form{
                Section(footer: Text("Empty ingredients will be deleted. Minimum one ingredient is required to save recipe").font(.system(size: 10)).padding(.leading, 5)){
                    Stepper(value: $recipeViewModel.numberOfIngredients, in: 0...10){
                        Text("\(recipeViewModel.numberOfIngredients) \(recipeViewModel.numberOfIngredients == 0 || recipeViewModel.numberOfIngredients > 1 ? "Ingredients" : "Ingredient")")
                    }
                }
                
                ForEach(recipeViewModel.ingredientsViewsList) { ingredient in
                    IngredientView(ingredientViewModel: ingredient)
                }
                
                
            }
        }
        .navigationBarTitle("Add ingredients")
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.translation.height > 0 {
                        self.hideKeyboard()
                    }
                }
        )
        .onDisappear(){
            recipeViewModel.removeEmptyIngredients()
        }
    }
}

struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView()
        //.environmentObject(RecipeViewModel(with: RecipeModel(ref: nil, key: "", id: UUID(), name: "", shortRecipeDescribe: "", selectedTimeOfPrepare: 0, levelOfDifficulty: "", rating: 0, isFavourite: false, intputImage: nil, image: nil, numberOfIngredients: 1, numberOfSteps: 1, ingredientsList: [IngredientModel(id: UUID(), name: "", quantity: "", unit: 0)], methodStepsList: [MethodStepModel(id: UUID(), name: "", destribe: "", inputImage: nil, inputImageData: nil)])))
    }
}
