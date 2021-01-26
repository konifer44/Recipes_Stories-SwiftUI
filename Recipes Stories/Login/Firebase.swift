//
//  AuthenticationSession.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 16/12/2020.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import Combine

class Firebase : ObservableObject {
    @Published var user: User? { didSet { self.didChange.send(self) }}
    var didChange = PassthroughSubject<Firebase, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference = Database.database().reference(withPath: "\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
    
    
    func listen () {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user: \(user)")
                self.user = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
            } else {
                self.user = nil
            }
        }
    }
        func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
           // Auth.auth().createUser(withEmail: email, password: password, completion: handler)
        }
        func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
            Auth.auth().signIn(withEmail: email, password: password, completion: handler)
        }
    func signOut () -> String? {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch {
            return "Error with logout"
        }
        return nil
    }
    func removeListener () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func saveData(recipe: RecipeViewModel){
        let postRef = ref.child(recipe.name)
        postRef.setValue(recipe.toAnyObject())
    }
    
    func reciveData(){
        var recipes: [RecipeViewModel] = []
        ref.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let recipe = RecipeViewModel(snapshot: snapshot) {
                    recipes.append(recipe)
                }
                
            }
            
        })
    }
}

class User {
    var uid: String
    var email: String?
    var displayName: String?
    
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
    
}
