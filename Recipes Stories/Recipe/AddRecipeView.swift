//
//  AddRecipeView.swift
//  newIngredients
//
//  Created by Jan Konieczny on 16/01/2021.
//

import SwiftUI

struct AddRecipeView: View {
    @EnvironmentObject var firebase: Firebase
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var recipeViewModel = RecipeViewModel(with: RecipeModel(ref: nil, key: "", id: UUID(), name: "", shortRecipeDescribe: "", selectedTimeOfPrepare: 0, levelOfDifficulty: "", rating: 0, isFavourite: false, numberOfIngredients: 0, numberOfSteps: 0, ingredientsList: [], methodStepsList: []))
    
    @State private var isEmptyFormAlertIsPresented = false
    @State private var showingImagePicker = false
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name of Recipe", text: $recipeViewModel.name)
                }
                
                Section(
                    header:
                        Text("Short recipe describe"),
                    footer:
                        Text("e.g. Quick & Healthy, Best for party etc.")
                        .font(.system(size: 10))
                        .padding(.leading, 5)) {
                    TextField("Describe", text: $recipeViewModel.shortRecipeDescribe)
                }
                
                Section(header: Text("Time of prepare")) {
                    Picker("Time of prepare", selection: $recipeViewModel.selectedTimeOfPrepare){
                        ForEach(0 ..< recipeViewModel.timesOfPrepare.count) {
                            Text("\(recipeViewModel.timesOfPrepare[$0]) minutes")
                        }
                    }
                    .frame(height: 60)
                    .pickerStyle(WheelPickerStyle())
                }
                
                Section(header:  Text("Level of difficulty")){
                    Picker("Level of difficulty", selection: $recipeViewModel.levelOfDifficulty) {
                        ForEach(recipeViewModel.levelsOfDifficulty, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section{
                    Toggle(isOn: $recipeViewModel.isFavourite) {
                        Text("Is favourite")
                    }
                }
                
                Section{
                    NavigationLink(
                        destination:
                            AddIngredientView()
                            .environmentObject(recipeViewModel)
                        ,
                        label: {
                            if recipeViewModel.ingredientsViewsList.isEmpty {
                                Text("Add ingredients")
                            } else {
                                Text("\(recipeViewModel.numberOfIngredients) \(recipeViewModel.numberOfIngredients != 1 ? "Ingredients" : "Ingredient")")
                            }
                        })
                }
                
                Section{
                    NavigationLink(
                        destination:
                            AddMethodStepView()
                            .environmentObject(recipeViewModel)
                        ,
                        label: {
                            if recipeViewModel.methodStepViewsList.isEmpty{
                                Text("Add method steps")
                            } else {
                                Text("\(recipeViewModel.numberOfSteps) \(recipeViewModel.numberOfSteps != 1 ? "Steps" : "Step")")
                            }
                        })
                }
                
                Section{
                    recipeViewModel.outputImage?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    
                    HStack{
                        Spacer()
                        if recipeViewModel.isImageEmpty() {
                            Button(action: {
                                showingImagePicker = true
                            }, label: {
                                HStack{
                                    Image(systemName: "photo")
                                    Text("Please add photo")
                                }
                            })
                            .buttonStyle(BorderlessButtonStyle())
                        } else {
                            HStack{
                                Button(action: {
                                    showingImagePicker = true
                                }, label: {
                                    Text("Change image")
                                })
                                .buttonStyle(BorderlessButtonStyle())
                                Spacer()
                                Button(action: {
                                    recipeViewModel.deleteImage()
                                }, label: {
                                    Text("Delete image")
                                        .foregroundColor(.red)
                                })
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .sheet(isPresented: $showingImagePicker){
                        ImagePicker(image: $recipeViewModel.inputImage)
                    }
                }
                .listRowInsets(EdgeInsets())
                
            }
            .navigationBarTitle("Add recipe")
            .navigationBarItems(
                leading: Button("Cancel"){
                    recipeViewModel.clearFormAndCancel()
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save"){
                    firebase.saveData(recipe: recipeViewModel)
                    recipeViewModel.saveToCoreData()
                    recipeViewModel.clearFormAndCancel()
                    presentationMode.wrappedValue.dismiss()
                    
                })
        }
        .onDisappear(){
            self.hideKeyboard()
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.translation.height > 0 {
                        self.hideKeyboard()
                    }
                }
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
            .environmentObject(RecipeViewModel(with: RecipeModel(ref: nil, key: "", id: UUID(), name: "Name", shortRecipeDescribe: "hi", selectedTimeOfPrepare: 2, levelOfDifficulty: "", rating: 4, isFavourite: true, inputImage: nil, inputImageData: nil, outputImage: Image(uiImage: UIImage(named: "breakfast")!), numberOfIngredients: 0, numberOfSteps: 0, ingredientsList: [], methodStepsList: [])))
    }
}
