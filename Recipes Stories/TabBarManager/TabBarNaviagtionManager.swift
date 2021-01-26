//
//  TabBarNaviagtionManager.swift
//  Recipes Stories
//
//  Created by Jan Konieczny on 31/10/2020.
//

import Foundation
import SwiftUI
import Combine

class TabBarNavigationManager: ObservableObject {
    @Published var currentTab = Tab.home
    @Published var addRecipeSheetIsPresented = false
    @Published var hideWelcomeScreen = false
    
    enum Tab: CaseIterable {
        case home
        case favourites
        case shoppingList
        case user
    }
}
