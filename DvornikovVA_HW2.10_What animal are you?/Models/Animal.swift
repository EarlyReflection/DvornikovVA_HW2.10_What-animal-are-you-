//
//  Animal.swift
//  DvornikovVA_HW2.10_What animal are you?Tests
//
//  Created by Vladimir Dvornikov on 25.10.2022.
//

struct Animal: Decodable {
    let name: String
    let latin_name: String
    let animal_type: String
    let active_time: String
    let length_min: String
    let length_max: String
    let weight_min: String
    let weight_max: String
    let habitat: String
    let diet: String
    let geo_range: String
    let image_link: String
}

enum Actions: String, CaseIterable {
    case getRandomAnimal = "What animal are you?"
    case getAnimals = "Your team"
}

enum Link: String {
    case oneAnimal = "https://zoo-animal-api.herokuapp.com/animals/rand"
    case thenAnimals = "https://zoo-animal-api.herokuapp.com/animals/rand/10"
    
}