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

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchThen(closure: @escaping([Animal]) -> Void ) {
        guard let url = URL(string: Link.thenAnimals.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let animals = try decoder.decode([Animal].self, from: data)
                DispatchQueue.main.async {
                    closure(animals)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    //Тут надо сделать по аналоги с примером выше
    func fetchOne(closure: @escaping(Animal) -> Void) {
        guard let url = URL(string: Link.oneAnimal.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let animal = try decoder.decode(Animal.self, from: data)
                DispatchQueue.main.async {
                    closure(animal)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}


