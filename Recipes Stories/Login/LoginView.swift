//
//  NewLoginView.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 17/12/2020.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @EnvironmentObject var firebase: Firebase
    @EnvironmentObject var tabBarNavigationManager: TabBarNavigationManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @AppStorage("isNewUser") var isNewUser: Bool = true
    
    @ObservedObject var keyboard = KeyboardObserver()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    @State private var loading = false
    @State private var error = "" {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    self.error = ""
                }
            }
        }
    }
    @State private var register = false
    
    var passwordsMatch: Bool {
        password == password2
    }
    
    var body: some View {
        VStack{
            if firebase.user != nil   {
                Spacer()
                Image("manage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 30))
                Text("Manage your account")
                    .multilineTextAlignment(.center)
                    .shadow(radius: 3)
                    .foregroundColor(.white)
                    .font(.custom("Fraunces9pt-Black", size: 30))
                    .frame(width: 300, alignment: .center)
                    .padding(.bottom, 10)
                
                HStack{
                    Spacer()
                    Button("Sing Out") {
                        if let error =  firebase.signOut() {
                            self.error = error
                        }
                    }
                    .padding(EdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30))
                    .foregroundColor(.white)
                    .background(Color.yellow.opacity(0.9))
                    .cornerRadius(90.0)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .shadow(radius: 5)
                    Spacer()
                }
                Spacer()
            } else {
                Spacer()
                Image("welcome4")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 30))
                Text("Join Community")
                    .multilineTextAlignment(.center)
                    .shadow(radius: 3)
                    .foregroundColor(.white)
                    .font(.custom("Fraunces9pt-Black", size: 30))
                    .frame(width: 300, alignment: .center)
                    .padding(.bottom, 10)
                
                
                TextField("", text: $email)
                    .padding(EdgeInsets(top: 20, leading: 60, bottom: 20, trailing: 30))
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(90.0)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .overlay(
                        HStack{
                            Image(systemName: "envelope")
                            Text(email.isEmpty ? "Enter email" : "")
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding(.leading, 60)
                    )
                
                SecureField("", text: $password)
                    .padding(EdgeInsets(top: 20, leading: 60, bottom: 20, trailing: 30))
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(90.0)
                    .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 30))
                    .overlay(
                        HStack{
                            Image(systemName: "key")
                            Text(password.isEmpty ? "Enter password" : "")
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding(.leading, 60)
                    )
                
                if register == true {
                    SecureField("", text: $password2)
                        .padding(EdgeInsets(top: 20, leading: 60, bottom: 20, trailing: 30))
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(90.0)
                        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 30))
                        .overlay(
                            HStack{
                                Image(systemName: "key")
                                Text(password2.isEmpty ? "Confirm password" : "")
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding(.leading, 60)
                        )
                    
                    HStack{
                        Text("Already have account?")
                        Button(action: {
                            register = false
                            error = ""
                        }, label: {
                            Text("Sign In!")
                                .fontWeight(.bold)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                    .foregroundColor(.white)
                    
                    Button(action: {
                        if passwordsMatch {
                            signUp()
                        } else {
                            withAnimation {
                                error = "Passwords are diffrerent"
                                
                            }
                        }
                    }, label: {
                        Text("Register")
                            .fontWeight(.bold)
                    })
                    .padding(EdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30))
                    .foregroundColor(.white)
                    .background(Color.yellow.opacity(0.9))
                    .cornerRadius(90.0)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .shadow(radius: 5)
                } else {
                    HStack{
                        Text("Don't have account yet?")
                        Button(action: {
                            register = true
                        }, label: {
                            Text("Sign Up!")
                                .fontWeight(.bold)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                    .foregroundColor(.white)
                    
                    Button(action: signIn) {
                        Text("Sign in")
                    }
                    .padding(EdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30))
                    .foregroundColor(.white)
                    .background(Color.yellow.opacity(0.9))
                    .cornerRadius(90.0)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .shadow(radius: 4)
                }
                Spacer()
                if isNewUser == true {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("BACK")
                            }
                            .foregroundColor(.white)
                        })
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 80, trailing: 20))
                }
            }
            
            if !error.isEmpty {
                Text(error)
                    .font(.subheadline)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .foregroundColor(.white)
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(90.0)
                    .animation(.easeIn(duration: 2))
                    .frame(width: 300, alignment: .center)
                    .padding(.bottom, 50)
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, keyboard.keyboardHeight * 0.9)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(UIColor(red: 31/255, green: 176/255, blue: 144/255, alpha: 0.9)))
        .edgesIgnoringSafeArea(.all)  
    }
    
    func signIn () {
        firebase.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                withAnimation {
                    self.error = error.localizedDescription
                }
            }
            withAnimation{
                isNewUser = false
                tabBarNavigationManager.currentTab = .home
            }
        }
    }
    
    func signUp () {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                withAnimation {
                    self.error = error.localizedDescription
                }
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
