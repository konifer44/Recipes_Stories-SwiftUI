//
//  MethodStepDetailView.swift
//  Recipies Stories
//
//  Created by Jan Konieczny on 18/11/2020.
//

import SwiftUI

struct MethodStepView: View {
    @State var methodStep: MethodStepViewModel
    @State private var showingImagePicker = false
    @State var itemNumber: Int
    
    var body: some View {
        
        Section{
            HStack{
                Text("Step \(itemNumber): ")
                TextField("Optional step name", text: $methodStep.name)
                
            } .frame(height: 40)
            
            
            HStack {
                Text("Method: ")
                    .padding(0)
                TextEditor(text: $methodStep.describe)
                    .frame(minHeight: 40)
                    .padding(0)
            }
            
            methodStep.outputImage?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
            
            
            HStack{
                Spacer()
                if methodStep.inputImage == nil {
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
                            methodStep.deleteImage()
                        }, label: {
                            Text("Delete image")
                                .foregroundColor(.red)
                        })
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                Spacer()
            }
            .sheet(isPresented: $showingImagePicker){
                ImagePicker(image: $methodStep.inputImage)
            }
            
        }
        .padding(10)
    }
}
struct MethodStepView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        MethodStepView(methodStep: MethodStepViewModel(with: MethodStepModel(id: UUID(), name: "Mąka", describe: "Mąkę grzejemy", inputImage: nil, inputImageData: nil  )), itemNumber: 2)
        
    }
}

