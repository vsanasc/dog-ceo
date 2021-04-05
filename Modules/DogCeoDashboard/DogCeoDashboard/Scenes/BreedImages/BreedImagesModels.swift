//
//  BreedImagesModels.swift
//  DogCeoDashboard
//
//  Created by Vitor on 04-04-21.
//

enum BreedImagesModels {

    enum LoadData {
        struct Request {
            let breed: String
        }
        struct Response {
            let items: [String]
        }
    }

    enum ShowError {
        struct Response {
        }
    }

}
