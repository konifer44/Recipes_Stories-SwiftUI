//
//  Recipes_StoriesApp.swift
//  Recipes Stories
//
//  Created by Jan Konieczny on 16/01/2021.
//
import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var coreDataRecipes: FetchedResults<Recipe>
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var tabBarNavigationManager: TabBarNavigationManager
    @EnvironmentObject var firebase: Firebase
    @AppStorage("isNewUser") var isNewUser: Bool = true
    
    var body: some View {
        Group{
            if firebase.user == nil {
                if isNewUser == true {
                    WelcomeScreen1()
                }
                else {
                    LoginView()
                }
            } else {
                ZStack{
                    switch tabBarNavigationManager.currentTab {
                    case .home:
                        if coreDataRecipes.isEmpty {
                            WelcomeScreen3()
                        } else {
                            HomeTab()
                        }
                    case .favourites:
                        if coreDataRecipes.isEmpty {
                            WelcomeScreen3()
                        } else {
                            FavouritesTab()
                        }
                    case .shoppingList:
                        ShoppingListTab()
                    case .user:
                        LoginView()
                    }
                    Spacer()
                    TabBar()
                }
            }
        }
        .onAppear{
            firebase.listen()
        }
        .sheet(isPresented: $tabBarNavigationManager.addRecipeSheetIsPresented){
            AddRecipeView()
                .environment(\.managedObjectContext, managedObjectContext)
                .environmentObject(firebase)
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
