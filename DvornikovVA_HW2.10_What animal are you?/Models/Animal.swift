//
//  Animal.swift
//  DvornikovVA_HW2.10_What animal are you?Tests
//
//  Created by Vladimir Dvornikov on 25.10.2022.
//

struct Animal: Decodable {
    let name: String?
    let latinName: String?
    let lengthMin: String?
    let lengthMax: String?
    let weightMin: String?
    let weightMax: String?
    let habitat: String?
    let diet: String?
    let imageLink: String?
    
    init( animalData: [String: Any]) {
        name = animalData["name"] as? String
        latinName = animalData["latin_name"] as? String
        lengthMin = animalData["length_min"] as? String
        lengthMax = animalData["length_max"] as? String
        weightMin = animalData["weight_min"] as? String
        weightMax = animalData["weight_max"] as? String
        habitat = animalData["habitat"] as? String
        diet = animalData["diet"] as? String
        imageLink = animalData["image_link"] as? String
    }
}




