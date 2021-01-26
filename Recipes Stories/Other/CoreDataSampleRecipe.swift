//
//  CoreDataSampleRecipe.swift
//  Recipes Stories
//
//  Created by Jan Konieczny on 16/01/2021.
//

import Foundation
import UIKit
import SwiftUI
import CoreData

class CoreDataSampleRecipe {
    static let images = ["pasta","pumpkin","thai","breakfast","seafood"]
    private let managedObjectContext:  NSManagedObjectContext
    init(){
        self.managedObjectContext = PersistenceController.shared.persistentContainer.viewContext
    }
    let recipe = RecipeViewModel(with: RecipeModel(ref: nil, key: "", id: UUID(), name: images.randomElement() ?? "Pizza", shortRecipeDescribe: "Pyszna", selectedTimeOfPrepare: 4, levelOfDifficulty: "Hard", rating: 4, isFavourite: true, inputImage: UIImage(named: images.randomElement() ?? "pasta"), inputImageData: nil, outputImage: nil, numberOfIngredients: 0, numberOfSteps: 0, ingredientsList: [], methodStepsList: []))
    
    func saveToCoreData(){
        
        let recipeToSave = Recipe(context: self.managedObjectContext)
        recipeToSave.name = recipe.name
        recipeToSave.shortRecipeDescribe =  recipe.shortRecipeDescribe
        
        // let timeOfPrepare =   recipe.timesOfPrepare[recipe.selectedTimeOfPrepare]
        // recipeToSave.timeOfPrepare = recipe.s
        
        recipeToSave.levelOfDifficulty =  recipe.levelOfDifficulty
        recipeToSave.rating = Int16(Int.random(in: 0...5))
        recipeToSave.likes = Int16(Int.random(in: 0...1000))
        recipeToSave.isFavourite =  recipe.isFavourite
        
        for ingredient in recipe.ingredientsViewsList {
            let newIngredient = Ingredient(context: self.managedObjectContext)
            newIngredient.name = ingredient.name
            newIngredient.quantity = Int16(Int(ingredient.quantity) ?? 0)
            newIngredient.unit = ingredient.unitsArray[ingredient.unit]
            recipeToSave.addToIngredient(newIngredient)
        }
        
        for methodStep in  recipe.methodStepViewsList{
            let newStep = MethodStep(context: self.managedObjectContext)
            newStep.title = methodStep.name
            newStep.describe = methodStep.describe
            newStep.image = methodStep.inputImageData
            recipeToSave.addToMethodStep(newStep)
        }
        
        guard let imageData =  recipe.inputImage?.pngData() else { return }
        recipeToSave.image = imageData
        
        self.managedObjectContext.insert(recipeToSave)
        
        do {
            try self.managedObjectContext.save()
            print("Saved :)")
            //self.saveToFirebase()
        } catch  {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}
