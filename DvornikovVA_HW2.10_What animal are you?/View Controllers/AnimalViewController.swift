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
    
    private var animal: Animal!
    private var url = "https://zoo-animal-api.herokuapp.com/animals/rand"

}


// MARK: - Networking

extension AnimalViewController {
    func fetchAnimal() {
        NetworkManager.shared.fetchOne(url: url) { animal in
            self.animal = animal
    
            self.youAreLabel.text = self.animal.name
            self.latinNameLabel.text = "latin name: \(self.animal.latinName)"
            self.weightLabel.text = "weight: \(self.animal.weightMin) - \(self.animal.weightMax)"
            self.lenghtLabel.text = "lenght: \(self.animal.lengthMin) - \(self.animal.weightMax)"
            self.habitatLabel.text = "habitat: \(self.animal.habitat)"
            self.dietLabel.text = "diet: \(self.animal.diet)"
            
            DispatchQueue.global().async {
                guard let url = URL(string: self.animal.imageLink) else { return }
                guard let imageData = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
    }
}
// Надо вынести работу с получением картинки в сетевой слой!
