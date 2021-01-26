//
//  TabBar.swift
//  Recipes Stories
//
//  Created by Jan Konieczny on 31/10/2020.
//

import SwiftUI


struct TabBar: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject  var tabBarNavigationManager: TabBarNavigationManager
    @Environment(\.colorScheme) var colorScheme
    
    
    let tabBarShadowRadius: CGFloat = 5
    let numberOfTabs: CGFloat = CGFloat(TabBarNavigationManager.Tab.allCases.count)
    let iconSize: CGFloat = 20
    let tabBarHeight: CGFloat = 70
    let plusButtonSize: CGFloat = 70
    var body: some View {
        
        
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        tabBarNavigationManager.currentTab = .home
                    }) {
                        Image(systemName: "house")
                            .font(.system(size: iconSize))
                            .frame(width: iconSize * 2)
                            .foregroundColor(Color.yellow)
                    }
                    
                    Spacer()
                    Button(action: {
                        tabBarNavigationManager.currentTab = .favourites
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: iconSize))
                            .frame(width: iconSize * 2)
                            // .frame(width: geometry.size.width/numberOfTabs)
                            .foregroundColor(Color.yellow)
                    }
                    
                    Button(action: {
                        tabBarNavigationManager.addRecipeSheetIsPresented = true
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor((colorScheme == .dark ?  Color(UIColor.systemGray6) : Color.white))
                                .frame(width: plusButtonSize, height: plusButtonSize)
                                .shadow(radius: 3 )
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: plusButtonSize, height: plusButtonSize)
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding(10)
                    .offset(y: -tabBarHeight/3 )
                    
                    
                    Button(action: {
                        tabBarNavigationManager.currentTab = .shoppingList
                    }) {
                        Image(systemName: "cart")
                            .font(.system(size: iconSize))
                            .frame(width: iconSize * 2)
                            //   .frame(width: geometry.size.width/numberOfTabs)
                            .foregroundColor(Color.yellow)
                    }
                    Spacer()
                    Button(action: {
                        tabBarNavigationManager.currentTab = .user
                    }) {
                        Image(systemName: "person")
                            .font(.system(size: iconSize))
                            .frame(width: iconSize * 2)
                            //  .frame(width: geometry.size.width/numberOfTabs)
                            // .padding(.trailing, 10)
                            .foregroundColor(Color.yellow)
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width, height: tabBarHeight)
                .background((colorScheme == .dark ?  Color(UIColor.systemGray6) : Color.white).shadow(radius: tabBarShadowRadius))
            }
        }.edgesIgnoringSafeArea(.all)
    }
}


