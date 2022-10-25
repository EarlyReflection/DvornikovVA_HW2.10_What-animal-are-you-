//
//  DetailViewController.swift
//  DvornikovVA_HW2.10_What animal are you?
//
//  Created by Vladimir Dvornikov on 25.10.2022.
//

import UIKit

class AnimalViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lenghtLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var habitatLabel: UILabel!
    @IBOutlet weak var dietLabel: UILabel!
   
       var animal: Animal?
    
    
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
                self.animal = try JSONDecoder().decode(Animal.self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
