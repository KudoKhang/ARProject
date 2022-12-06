//
//  Model.swift
//  ARProject
//
//  Created by Nghĩa Khang on 06/12/2022.
//

import UIKit
import RealityKit
import Combine

class Model {
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                // Handle out err
                print("DEBUG: Unable to load modelEntity for modelName: \(self.modelName)")
            }, receiveValue: {modelEntity in
                // Get out modelEntity
                self.modelEntity = modelEntity
                print("DEBUG: Successfully loaded modelEntity for modelName: \(self.modelName)")
            })
    }
}
