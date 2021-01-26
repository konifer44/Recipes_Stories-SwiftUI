
//
//  MethodStepModel.swift
//  newIngredients
//
//  Created by Jan Konieczny on 12/01/2021.
//

import Foundation
import SwiftUI
import Combine

class MethodStepViewModel: Identifiable, ObservableObject{
    @Published var id: UUID
    @Published var name: String
    @Published var describe: String
    @Published var outputImage: Image?
    @Published var inputImageData: Data?
    @Published var inputImage: UIImage? {
        didSet {
            guard let inputImage = inputImage else { return }
            outputImage = Image(uiImage: inputImage)
            inputImageData = inputImage.pngData()
        }
        
    }
    
    
    init(with step: MethodStepModel){
        id = step.id
        name = step.name
        describe =  step.describe
        inputImage = nil
        inputImageData = nil
    }
    
    func deleteImage(){
        inputImage = nil
        inputImageData = nil
        outputImage = nil
    }
}


struct MethodStepModel: Identifiable, Hashable{
    var id : UUID
    var name: String
    var describe: String
    var inputImage: UIImage?
    var inputImageData: Data?
}



