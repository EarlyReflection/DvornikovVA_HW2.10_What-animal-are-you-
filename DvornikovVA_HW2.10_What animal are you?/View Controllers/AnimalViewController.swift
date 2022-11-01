//
//  DetailViewController.swift
//  DvornikovVA_HW2.10_What animal are you?
//
//  Created by Vladimir Dvornikov on 25.10.2022.
//

import UIKit

class AnimalViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var youAreLabel: UILabel!
    @IBOutlet weak var latinNameLabel: UILabel!
    @IBOutlet weak var lenghtLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var habitatLabel: UILabel!
    @IBOutlet weak var dietLabel: UILabel!
    
    var animal: Animal!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}


// MARK: - Networking

extension AnimalViewController {
    func fetchAnimal() {
        NetworkManager.shared.fetchOne { animal in
            self.animal = animal
            print(self.animal ?? "")
            
            self.youAreLabel.text = self.animal.name
            self.latinNameLabel.text = "latin name: \(self.animal.latin_name)"
            self.weightLabel.text = "weight: \(self.animal.weight_min) - \(self.animal.weight_max)"
            self.lenghtLabel.text = "lenght: \(self.animal.length_min) - \(self.animal.weight_max)"
            self.habitatLabel.text = "habitat: \(self.animal.habitat)"
            self.dietLabel.text = "diet: \(self.animal.diet)"
            
            DispatchQueue.global().async {
                guard let url = URL(string: self.animal.image_link) else { return }
                guard let imageData = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
    }
}
// Надо вынести работу с получением картинки в сетевой слой!
