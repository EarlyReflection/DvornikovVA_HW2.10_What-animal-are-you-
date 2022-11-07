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
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animal" {
            guard let animalVC = segue.destination as? AnimalViewController else { return }
            animalVC.fetchAnimal()
        } else {
            guard let teamVC = segue.destination as? TeamViewController else { return }
            teamVC.fetchTeam()
        }
    }
}

extension ButtonsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
    }
}
 
