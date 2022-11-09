//
//  TeamViewController.swift
//  DvornikovVA_HW2.10_What animal are you?
//
//  Created by Vladimir Dvornikov on 25.10.2022.
//

import UIKit
import Alamofire

class TeamViewController: UICollectionViewController {
    
    private var animals: [Animal] = []
    private var url = "https://zoo-animal-api.herokuapp.com/animals/rand/10"
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return animals.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let animal = animals[indexPath.item]
        cell.configure(with: animal)
        cell.backgroundColor = .darkGray
        return cell
    }
    
    
    // MARK: - Networking
    
    func fetchTeam() {
        NetworkManager.shared.fetchThen(url: url) { animals in
            self.animals = animals
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func fetchAlamofireTeam() {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let animalsData = value as? [[String : Any]] else { return }
                    for animalData in animalsData {
                        let animal = Animal(animalData: animalData)
                        
                        self.animals.append(animal)
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}

extension TeamViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWith = sectionInserts.left * (itemsPerRow + 1)
        let avalibleWith = collectionView.frame.width - paddingWith
        let withPerItem = avalibleWith / itemsPerRow
        
        return CGSize(width: withPerItem, height: withPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInserts.left
    }
    
}
