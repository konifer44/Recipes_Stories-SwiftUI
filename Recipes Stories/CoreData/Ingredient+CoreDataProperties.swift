//
//  Ingredient+CoreDataProperties.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 16/11/2020.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var name: String
    @NSManaged public var quantity: Int16
    @NSManaged public var unit: String
    @NSManaged public var ofRecipe: Recipe?

}

extension Ingredient : Identifiable {

}
