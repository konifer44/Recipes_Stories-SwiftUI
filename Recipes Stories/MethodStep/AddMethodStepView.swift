//
//  AddMethodStepView.swift
//  newIngredients
//
//  Created by Jan Konieczny on 12/01/2021.
//

import SwiftUI

struct AddMethodStepView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        VStack{
            Form{
                Section(footer: Text("Empty steps will be deleted. Minimum one step is required to save recipe").font(.system(size: 10)).padding(.leading, 5)){
                    Stepper(value: $recipeViewModel.numberOfSteps, in: 0...10){
                        Text("\(recipeViewModel.numberOfSteps) \(recipeViewModel.numberOfSteps == 0 || recipeViewModel.numberOfSteps > 1 ? "Steps" : "Step")")
                    }
                }
                
                ForEach(Array(zip(1..., recipeViewModel.methodStepViewsList)), id: \.1.id){ itemNumber, methodStep in
                    MethodStepView(methodStep: methodStep, itemNumber: itemNumber)
                }
                
                
            }
        }
        .navigationBarTitle("Add Method Steps")
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.translation.height > 0 {
                        self.hideKeyboard()
                    }
                }
        )
        .onDisappear(){
            recipeViewModel.removeEmptyMethodStep()
        }
    }
}

struct AddMethodStepView_Previews: PreviewProvider {
    static var previews: some View {
        AddMethodStepView()
        // .environmentObject(RecipeViewModel(with: RecipeModel(id: UUID(), name: "", shortRecipeDescribe: "", selectedTimeOfPrepare: 0, levelOfDifficulty: "", rating: 0, isFavourite: false, numberOfIngredients: 0, numberOfSteps: 0, ingredientsList: [], methodStepsList: [])))
    }
}
