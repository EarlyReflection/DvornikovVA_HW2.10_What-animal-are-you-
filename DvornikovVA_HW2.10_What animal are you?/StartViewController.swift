//
//  StartViewController.swift
//  DvornikovVA_HW2.10_What animal are you?
//
//  Created by Vladimir Dvornikov on 25.10.2022.
//

import UIKit

enum Actions: String, CaseIterable {
    case randomAnimal = "What animal are you?"
    case animals = "Your team"
}

enum Link: String {
    case oneAnimal = "https://zoo-animal-api.herokuapp.com/animals/rand"
    case thenAnimals = "https://zoo-animal-api.herokuapp.com/animals/rand/10"
    
}

class StartViewController: UICollectionViewController {
    
    let actions = Actions.allCases
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UserActionCell
        cell.actionLabel.text = actions[indexPath.item].rawValue
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    //определяет какая ячейка нажата
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = actions[indexPath.item]
        
        //тут надо добавить переходы на другие экраны!
        switch userAction {
        case .randomAnimal: oneAnimalPressed()
        case .animals: thenAnimalsPressed()
        }
        
    }
    
}

// MARK: - Networking
extension StartViewController {
    func oneAnimalPressed() {
        guard let url = URL(string: Link.oneAnimal.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let animal = try JSONDecoder().decode(Animal.self, from: data)
                print(animal)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
    func thenAnimalsPressed() {
        guard let url = URL(string: Link.thenAnimals.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let animals = try JSONDecoder().decode([Animal].self, from: data)
                print(animals)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()

    }
    
}

// Задаем размеры ячейки
extension StartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
    }
    
}
