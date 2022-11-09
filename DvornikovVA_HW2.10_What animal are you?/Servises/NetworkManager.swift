//
//  NetworkManager.swift
//  DvornikovVA_HW2.10_What animal are you?
//
//  Created by Vladimir Dvornikov on 29.10.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchThen(url: String, closure: @escaping ([Animal]) -> Void ) {
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let animals = try decoder.decode([Animal].self, from: data)
                closure(animals)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    func fetchOne(url: String, closure: @escaping (Animal) -> Void) {
        guard let url = URL(string: url) else { return }
        
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


 
