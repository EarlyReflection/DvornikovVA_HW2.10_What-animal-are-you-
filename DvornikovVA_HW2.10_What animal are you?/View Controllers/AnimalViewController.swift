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
        
        guard let url = URL(string: Link.oneAnimal.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let animal = try JSONDecoder().decode(Animal.self, from: data)
                DispatchQueue.main.async {
                    self.youAreLabel.text = animal.name
                    self.latinNameLabel.text = "latin name: \(animal.latin_name)"
                    self.weightLabel.text = "weight: \(animal.weight_min) - \(animal.weight_max)"
                    self.lenghtLabel.text = "lenght: \(animal.length_min) - \(animal.weight_max)"
                    self.habitatLabel.text = "habitat: \(animal.habitat)"
                    self.dietLabel.text = "diet: \(animal.diet)"
                }
                
                DispatchQueue.global().async {
                    guard let url = URL(string: animal.image_link) else { return }
                    guard let imageData = try? Data(contentsOf: url) else { return }
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: imageData)
                    }
                }

            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
