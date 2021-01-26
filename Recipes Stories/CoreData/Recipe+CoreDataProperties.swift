//
//  Recipe+CoreDataProperties.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 16/11/2020.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var id: UUID
    @NSManaged public var image: Data
    @NSManaged public var isFavourite: Bool //
    @NSManaged public var levelOfDifficulty: String //
    @NSManaged public var method: String
    @NSManaged public var name: String //
    @NSManaged public var rating: Int16 //
    @NSManaged public var likes: Int16 //
    @NSManaged public var shortRecipeDescribe: String //
    @NSManaged public var timeOfPrepare: Int16 //
    @NSManaged public var ingredient: NSSet
    @NSManaged public var methodStep: NSSet

    
    var ingredientsSet: [Ingredient] {
        let array = ingredient.allObjects as? [Ingredient]
        return array ?? []
    }
    
    var methodStepsSet: [MethodStep] {
        let array = methodStep.allObjects as? [MethodStep]
        return array ?? []
    }
 
}

// MARK: Generated accessors for ingredient
extension Recipe {

    @objc(addIngredientObject:)
    @NSManaged public func addToIngredient(_ value: Ingredient)

    @objc(removeIngredientObject:)
    @NSManaged public func removeFromIngredient(_ value: Ingredient)

    @objc(addIngredient:)
    @NSManaged public func addToIngredient(_ values: NSSet)

    @objc(removeIngredient:)
    @NSManaged public func removeFromIngredient(_ values: NSSet)

}

// MARK: Generated accessors for methodStep
extension Recipe {

    @objc(addMethodStepObject:)
    @NSManaged public func addToMethodStep(_ value: MethodStep)

    @objc(removeMethodStepObject:)
    @NSManaged public func removeFromMethodStep(_ value: MethodStep)

    @objc(addMethodStep:)
    @NSManaged public func addToMethodStep(_ values: NSSet)

    @objc(removeMethodStep:)
    @NSManaged public func removeFromMethodStep(_ values: NSSet)

}

extension Recipe : Identifiable {

}
