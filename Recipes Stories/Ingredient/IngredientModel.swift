 //
 //  IngredientModel.swift
 //  newIngredients
 //
 //  Created by Jan Konieczny on 12/01/2021.
 //
 
 import Foundation
 import SwiftUI
 
 class IngredientViewModel: Identifiable, ObservableObject{
    @Published var id: UUID
    @Published var name: String
    @Published var quantity: String
    @Published var unit: Int
    
    init(with ingredient: IngredientModel){
        id = ingredient.id
        name = ingredient.name
        quantity = ingredient.quantity
        unit = ingredient.unit
    }
    
    let unitsArray = ["g", "kg", "ml", "tbps", "piece", "pieces", "glass", "glasses"]
 }
 
 
 struct IngredientModel: Identifiable, Hashable{
    var id: UUID
    var name: String
    var quantity: String
    var unit: Int
    
 }
 
 
