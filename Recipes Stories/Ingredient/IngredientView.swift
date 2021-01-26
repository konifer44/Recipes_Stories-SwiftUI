//
//  IngredientDetailView.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 14/11/2020.
//

import SwiftUI

struct IngredientView: View {
    @StateObject var ingredientViewModel: IngredientViewModel
    
    var body: some View {
        Section {
            HStack {
                Spacer()
                TextField(ingredientViewModel.name.isEmpty ? "Name" : ingredientViewModel.name, text: $ingredientViewModel.name)
                    .frame(width: 80, height: 60)
                
                Spacer()
                Divider()
                
                TextField(ingredientViewModel.quantity.isEmpty ? "Qty" : ingredientViewModel.name, text: $ingredientViewModel.quantity)
                    .keyboardType(.numberPad)
                    .frame(width: 40, height: 60)
                
                Divider()
                Spacer()
                Picker(selection: $ingredientViewModel.unit, label: Text("Unit")) {
                    ForEach(0..<ingredientViewModel.unitsArray.count){
                        Text(ingredientViewModel.unitsArray[$0])
                    }
                }.pickerStyle(WheelPickerStyle())
                .frame(width: 120, height: 80)
                .cornerRadius(10)
                .clipped()
            }
            
            .frame(height: 60)
        }
    }
}


