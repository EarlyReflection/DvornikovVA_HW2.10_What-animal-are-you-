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

//class NetworkManager {
//
//    static let shared = NetworkManager()
//
//    private init() {}
//
//    func fetchThenAnimals() {
//        guard let url = URL(string: Link.thenAnimals.rawValue) else { return }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                self.animals = try JSONDecoder().decode([Animal].self, from: data)
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }.resume()
//
//    }
//
//}
