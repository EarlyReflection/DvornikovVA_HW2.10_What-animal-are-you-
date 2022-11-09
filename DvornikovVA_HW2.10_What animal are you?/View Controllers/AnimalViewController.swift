//
//  DetailViewController.swift
//  DvornikovVA_HW2.10_What animal are you?
//
//  Created by Vladimir Dvornikov on 25.10.2022.
//

import UIKit
import Alamofire

class AnimalViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var youAreLabel: UILabel!
    @IBOutlet weak var latinNameLabel: UILabel!
    @IBOutlet weak var lenghtLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var habitatLabel: UILabel!
    @IBOutlet weak var dietLabel: UILabel!
    
    private var animal: Animal!
    private var url = "https://zoo-animal-api.herokuapp.com/animals/rand"
    
    
    private func outletInit() {
        youAreLabel.text = self.animal.name
        latinNameLabel.text = "latin name: \(self.animal.latinName ?? "")"
        weightLabel.text = "weight: \(animal.weightMin ?? "") - \(animal.weightMax ?? "")"
        lenghtLabel.text = "lenght: \(animal.lengthMin ?? "") - \(animal.weightMax ?? "")"
        habitatLabel.text = "habitat: \(animal.habitat ?? "")"
        dietLabel.text = "diet: \(animal.diet ?? "")"
    }
    
    // MARK: - Networking
    
    func fetchAnimal() {
        NetworkManager.shared.fetchOne(url: url) { animal in
            self.animal = animal
            self.outletInit()
            
            DispatchQueue.global().async {
                guard let url = URL(string: self.animal.imageLink ?? "") else { return }
                guard let imageData = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    func fetchAlamofireAnimal() {
        AF.request(url)
            .validate()
            .responseJSON { dataResponce in
                switch dataResponce.result {
                    
                case .success(let value):
                    guard let animalData = value as? [String: Any] else { return}
                    let animal = Animal(animalData: animalData)
                    
                    self.animal = animal
                    self.outletInit()
                    
                    
                    DispatchQueue.global().async {
                        guard let url = URL(string: self.animal.imageLink ?? "") else { return }
                        guard let imageData = try? Data(contentsOf: url) else { return }
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: imageData)
                        }
                    }
                    
                case .failure( let error):
                    print(error)
                }
            }
    }
}


