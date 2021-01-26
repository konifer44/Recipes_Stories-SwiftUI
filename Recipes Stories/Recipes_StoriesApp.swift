//
//  Recipes_StoriesApp.swift
//  Recipes Stories
//
//  Created by Jan Konieczny on 16/01/2021.
//
import SwiftUI
import UIKit
import Firebase

@main
struct Recipes_StoriesApp: App {
    let context = PersistenceController.shared.persistentContainer.viewContext
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var firebase = Firebase()
    @StateObject var tabBarNavigationManager = TabBarNavigationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firebase)
                .environmentObject(tabBarNavigationManager)
                .environment(\.managedObjectContext, self.context)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
