
//
//  RecipeModel.swift
//  newIngredients
//
//  Created by Jan Konieczny on 11/01/2021.
//

import Foundation
import SwiftUI
import UIKit
import CoreData
import Firebase
import FirebaseDatabase

class RecipeViewModel: Identifiable, ObservableObject {
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipes: FetchedResults<Recipe>
    private let managedObjectContext = PersistenceController.shared.persistentContainer.viewContext
    private var ref: DatabaseReference?
    private var key: String
    
    @Published var id = UUID()
    @Published var name: String
    @Published var shortRecipeDescribe: String
    @Published var selectedTimeOfPrepare: Int
    @Published var levelOfDifficulty: String
    @Published var rating:  Int
    @Published var isFavourite: Bool
    @Published var inputImageData: Data?
    @Published var outputImage: Image?
    @Published var inputImage: UIImage? {
        didSet {
            guard let inputImage = inputImage else { return }
            outputImage = Image(uiImage: inputImage)
            inputImageData = inputImage.pngData()
        }
        
    }
    @Published var numberOfIngredients: Int {
        didSet{
            if numberOfIngredients > ingredientsViewsList.count{
                createNewIngredient()
            } else if numberOfIngredients < ingredientsViewsList.count {
                removeIngredient()
            } else if numberOfIngredients == 0 {
            }
        }
    }
    @Published var numberOfSteps: Int {
        didSet{
            if numberOfSteps > methodStepViewsList.count{
                createNewMethodStep()
            } else if numberOfSteps < methodStepViewsList.count {
                removeMethodStep()
            } else if numberOfSteps == 0 {
            }
        }
    }
    @Published var ingredientsViewsList = [IngredientViewModel]()
    @Published var methodStepViewsList = [MethodStepViewModel]()
    
    let levelsOfDifficulty = ["Easy", "Medium", "Hard"]
    let timesOfPrepare: [Int16] = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200]
    
    init(with recipe: RecipeModel) {
        ref = nil
        key = ""
        id = UUID()
        name = recipe.name
        shortRecipeDescribe = recipe.shortRecipeDescribe
        selectedTimeOfPrepare = recipe.selectedTimeOfPrepare
        levelOfDifficulty = recipe.levelOfDifficulty
        rating = recipe.rating
        isFavourite = recipe.isFavourite
        inputImage = recipe.inputImage
        inputImageData = recipe.inputImageData
        outputImage = recipe.outputImage
        numberOfIngredients = recipe.numberOfIngredients
        numberOfSteps = recipe.numberOfSteps
        
        for ingredient in recipe.ingredientsList {
            ingredientsViewsList.append(IngredientViewModel(with: ingredient))
        }
        
        for methodStep in recipe.methodStepsList {
            methodStepViewsList.append(MethodStepViewModel(with: methodStep))
        }
    }
    
    init?(snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String : AnyObject],
            let name = value["name"] as? String,
            let shortRecipeDescribe = value["shortRecipeDescribe"] as? String,
            let selectedTimeOfPrepare = value["timeOfPrepare"] as? Int,
            let levelOfDifficulty = value["levelOfDifficulty"] as? String,
            let rating = value["rating"] as? Int,
            let numberOfIngredients = value["numberOfIngredients"] as? Int,
            let numberOfSteps = value["numberOfSteps"] as? Int,
            let isFavourite = value["isFavourite"] as? Bool//,
        // let jsonIngredientsList = value["ingredientsList"] as?  [[String: Any]]
        // let jsonMethodStepList = value["methodSteps"] as? [[String:Any]]
        else{
            print("error")
            return nil
        }
        
        
        
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.id = UUID()
        self.name = name
        self.shortRecipeDescribe = shortRecipeDescribe
        self.selectedTimeOfPrepare = selectedTimeOfPrepare
        self.levelOfDifficulty = levelOfDifficulty
        self.rating = rating
        self.isFavourite = isFavourite
        self.numberOfIngredients = numberOfIngredients
        self.numberOfSteps = numberOfSteps
        self.ingredientsViewsList =  []
        self.methodStepViewsList = []
        self.inputImage = UIImage(named: "breakfast")
        
        //for ingredientItem in jsonIngredientsList {
        //    self.ingredientsViewsList.append(IngredientViewModel(with: IngredientModel(id: UUID(), name: ingredientItem["name"] as! String, quantity: ingredientItem["quantity"] as! String, unit: ingredientItem["unit"] as! Int)))
        //}
    }
    func toAnyObject() -> Any {
        var methodStepsListJSON = [[String: Any]]()
        var ingredientsListJSON = [[String: Any]]()
        
        for ingredient in ingredientsViewsList {
            var ingredientItem = [String: Any]()
            ingredientItem["name"] = ingredient.name
            ingredientItem["quantity"] = ingredient.quantity
            ingredientItem["unit"] = ingredient.unit
            ingredientsListJSON.append(ingredientItem)
        }
        
        for methodStep in methodStepViewsList {
            var methodStepItem = [String: Any]()
            methodStepItem["name"] = methodStep.name
            methodStepItem["describe"] = methodStep.describe
            methodStepsListJSON.append(methodStepItem)
        }
        
        
        return [
            "name": name,
            "shortRecipeDescribe": shortRecipeDescribe,
            "timeOfPrepare": timesOfPrepare[selectedTimeOfPrepare],
            "levelOfDifficulty": levelOfDifficulty,
            "rating": rating,
            "isFavourite": isFavourite,
            "numberOfIngredients": numberOfIngredients,
            "numberOfSteps": numberOfSteps,
            "ingredientsList": ingredientsListJSON,
            "methodStepsList": methodStepsListJSON
        ]
    }
    
    func createNewIngredient() {
        ingredientsViewsList.append(IngredientViewModel(with: IngredientModel(id: UUID(), name: "", quantity: "", unit: 0)))
    }
    func removeIngredient() {
        ingredientsViewsList.removeLast()
    }
    func removeEmptyIngredients(){
        ingredientsViewsList = ingredientsViewsList.filter{!($0.name.isEmpty && $0.quantity.isEmpty)}
        numberOfIngredients = ingredientsViewsList.count
    }
    func createNewMethodStep() {
        methodStepViewsList.append(MethodStepViewModel(with: MethodStepModel(id: UUID(), name: "", describe: "")))
    }
    func removeMethodStep() {
        methodStepViewsList.removeLast()
    }
    func removeEmptyMethodStep(){
        methodStepViewsList = methodStepViewsList.filter{!($0.name.isEmpty && $0.describe.isEmpty)}
        numberOfSteps = methodStepViewsList.count
    }
    func deleteImage(){
        inputImage = nil
        inputImageData = nil
        outputImage = nil
    }
    func isImageEmpty() -> Bool {
        if inputImage == nil {
            return true
        } else {
            return false
        }
    }
    func isFormEmpty()->Bool{
        return
            name.isEmpty  ||
            shortRecipeDescribe.isEmpty ||
            levelOfDifficulty.isEmpty ||
            inputImage == nil ||
            numberOfIngredients == 0 ||
            numberOfSteps == 0
    }
    func clearFormAndCancel(){
        name = ""
        shortRecipeDescribe = ""
        selectedTimeOfPrepare = 0
        levelOfDifficulty = ""
        rating = 0
        deleteImage()
        numberOfIngredients = 0
        numberOfIngredients = 0
        ingredientsViewsList.removeAll()
        methodStepViewsList.removeAll()
    }
    func saveToCoreData(){
        let recipeToSave = Recipe(context: self.managedObjectContext)
        recipeToSave.name = name
        recipeToSave.shortRecipeDescribe =  shortRecipeDescribe
        
        let timeOfPrepare =   selectedTimeOfPrepare
        recipeToSave.timeOfPrepare = Int16(timeOfPrepare)
        
        recipeToSave.levelOfDifficulty =  levelOfDifficulty
        recipeToSave.rating = Int16(Int.random(in: 0...5))
        recipeToSave.likes = Int16(Int.random(in: 0...1000))
        recipeToSave.isFavourite =  isFavourite
        
        for ingredient in ingredientsViewsList {
            let newIngredient = Ingredient(context: self.managedObjectContext)
            newIngredient.name = ingredient.name
            newIngredient.quantity = Int16(Int(ingredient.quantity) ?? 0)
            newIngredient.unit = ingredient.unitsArray[ingredient.unit]
            recipeToSave.addToIngredient(newIngredient)
        }
        
        for methodStep in  methodStepViewsList{
            let newStep = MethodStep(context: self.managedObjectContext)
            newStep.title = methodStep.name
            newStep.describe = methodStep.describe
            newStep.image = methodStep.inputImageData
            recipeToSave.addToMethodStep(newStep)
        }
        
        if let inputImageData = inputImageData {
            recipeToSave.image = inputImageData
        }
        
        
        self.managedObjectContext.insert(recipeToSave)
        
        do {
            try self.managedObjectContext.save()
            print("Saved :)")
        } catch  {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
    
}



struct RecipeModel: Identifiable {
    let ref: DatabaseReference?
    let key: String?
    
    var id: UUID
    var name: String
    var shortRecipeDescribe: String
    var selectedTimeOfPrepare: Int
    var levelOfDifficulty: String
    var rating:  Int
    var isFavourite: Bool
    
    var inputImage: UIImage?
    var inputImageData: Data?
    var outputImage: Image?
    
    var numberOfIngredients: Int
    var numberOfSteps: Int
    
    var ingredientsList: [IngredientModel]
    var methodStepsList: [MethodStepModel]
    
    var levelsOfDifficulty = ["Easy", "Medium", "Hard"]
    var timesOfPrepare: [Int16] = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200]
}
