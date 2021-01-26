//
//  MethodStep+CoreDataProperties.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 16/11/2020.
//
//

import Foundation
import CoreData


extension MethodStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MethodStep> {
        return NSFetchRequest<MethodStep>(entityName: "MethodStep")
    }

    @NSManaged public var describe: String
    @NSManaged public var image: Data?
    @NSManaged public var title: String
    @NSManaged public var ofRecipe: Recipe?

}

extension MethodStep : Identifiable {

}
