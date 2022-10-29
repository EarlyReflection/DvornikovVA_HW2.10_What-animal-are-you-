//
//  NetworkManager.swift
//  DvornikovVA_HW2.10_What animal are you?
//
//  Created by Vladimir Dvornikov on 29.10.2022.
//

import Foundation

enum Link: String {
    case oneAnimal = "https://zoo-animal-api.herokuapp.com/animals/rand"
    case thenAnimals = "https://zoo-animal-api.herokuapp.com/animals/rand/10"
}

class NetworkManager
