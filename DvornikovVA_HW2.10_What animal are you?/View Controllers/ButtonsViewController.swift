//
//  StartViewController.swift
//  DvornikovVA_HW2.10_What animal are you?
//
//  Created by Vladimir Dvornikov on 25.10.2022.
//

import UIKit


enum Actions: String, CaseIterable {
    case getAnimal = "What animal are you?"
    case getAnimals = "Your team"
    case alamofireAnimal = "What animal are you? (alamofire)"
    case alamofireAnimals = "Your team (alamofire)"
}

class ButtonsViewController: UICollectionViewController {
    
    let actions = Actions.allCases
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UserActionCell
        cell.actionLabel.text = actions[indexPath.item].rawValue
        if indexPath.item > 1 {
            cell.backgroundColor = .darkGray
        } else {
            cell.backgroundColor = .lightGray
        }
  
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    //определяет какая ячейка нажата
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = actions[indexPath.item]
        
        
        switch userAction {
            
        case .getAnimal:
            performSegue(withIdentifier: "animal", sender: nil)
        case .getAnimals:
            performSegue(withIdentifier: "team", sender: nil)
        case .alamofireAnimal:
            performSegue(withIdentifier: "alamofireAnimal", sender: nil)
        case .alamofireAnimals:
            performSegue(withIdentifier: "alamofireTeam", sender: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animal" || segue.identifier == "alamofireAnimal" {
            guard let animalVC = segue.destination as? AnimalViewController else { return }
            switch segue.identifier {
            case "animal": animalVC.fetchAnimal()
            case "alamofireAnimal": animalVC.fetchAlamofireAnimal()
            default: break
            }
            
        } else {
            guard let teamVC = segue.destination as? TeamViewController else { return }
            switch segue.identifier {
            case "team": teamVC.fetchTeam()
            case "alamofireTeam": teamVC.fetchAlamofireTeam()
            default: break
            }
            
        }
    }
}

extension ButtonsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 50, height: 100)
    }
}

