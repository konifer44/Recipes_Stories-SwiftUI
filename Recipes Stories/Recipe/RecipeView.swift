//
//  NewRecipieSummaryView.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 26/11/2020.
//
import SwiftUI

struct RecipieView: View {
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: []) var recipies: FetchedResults<Recipe>
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var recipe: FetchedResults<Recipe>.Element
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var tabBarNavigationManager: TabBarNavigationManager
    @Namespace var matchedAnimation
    
    @State private var opacity: Double = 1
    @State private var showNavigationBar = false
    @State private var backButtonTransition = false
    @State private var unwrappedImage: Image?
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ZStack {
                    if geometry.frame(in: .global).minY <= 0 {
                        ZStack{
                            unwrappedImage?
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                            RecipeSummaryView(recipe: recipe).offset(y: geometry.size.height / 2 - 10)
                        }
                        .offset(y: geometry.frame(in: .global).minY/5.6)
                    } else {
                        ZStack{
                            unwrappedImage?
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                                .clipped()
                            RecipeSummaryView(recipe: recipe).offset(y: (geometry.size.height + geometry.frame(in: .global).minY) / 2 - 10)
                        }
                        .offset(y: -geometry.frame(in: .global).minY)
                    }
                }
                .onChange(of: geometry.frame(in: .global).minY) { newValue in
                    //   DispatchQueue.main.async {
                    if -newValue > geometry.size.height -  35{
                        showNavigationBar = true
                        backButtonTransition = true
                    }
                    if -newValue <= geometry.size.height - 35{
                        showNavigationBar = false
                        backButtonTransition = false
                    }
                    //   }
                    
                }
            }
            .frame(height: 500)
            
            VStack(alignment: .leading, spacing: 10){
                Text("Ingredients")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 55, leading: 15, bottom: 10, trailing: 10))
                
                ForEach(recipe.ingredientsSet, id: \.self){ ingredient in
                    HStack(alignment: .center){
                        HStack{
                            Image(systemName: "circle")
                            Text("\(ingredient.quantity)\(ingredient.unit)")
                        }
                        .frame(width: 150, alignment: .leading)
                        Text("\(ingredient.name)")
                        
                    }
                    .padding(.leading, 25)
                    .font(.headline)
                    
                    Divider()
                }
                
                Text("Method")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 40, leading: 15, bottom: 10, trailing: 10))
                
                ForEach(Array(zip(1..., recipe.methodStepsSet)), id: \.1.id){ stepNumber, step in
                    HStack{
                        Spacer()
                        Text("Step \(stepNumber): \(step.title)")
                            .font(.headline)
                        Spacer()
                    }
                    
                    Divider()
                    
                    Text(step.describe)
                        .font(.subheadline)
                        .padding()
                    
                    unwrappImage(imageData: step.image)?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .clipped()
                        .padding(.bottom, 20)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(.bottom, 30)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(!showNavigationBar)
        .navigationBarItems(leading:
                                BackButton().matchedGeometryEffect(id: "id1", in: matchedAnimation)
        )
        .overlay(
            BackButton().matchedGeometryEffect(id: backButtonTransition ? "id1" : "", in: matchedAnimation, isSource: false)
                .position(x: 30, y: 70)
            
        )
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.location.x < 150 {
                        if gesture.translation.width > 50 {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    
                }
        )
        .edgesIgnoringSafeArea(.all)
        .onAppear(){
            unwrappedImage = unwrappImage(imageData: recipe.image)
        }
    }
    
    func unwrappImage(imageData: Data?) -> Image? {
        guard let imageData = imageData else { return nil }
        guard let uiImage = UIImage(data: imageData) else { return nil }
        let image = Image(uiImage: uiImage)
        return image
    }
}








struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left.circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.yellow)
            
        })
        .shadow(radius: 10)
    }
    
}




