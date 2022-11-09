//
//  PhotoCell.swift
//  DvornikovVA_HW2.10_What animal are you?
//
//  Created by Vladimir Dvornikov on 28.10.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var animalImageView: UIImageView!
    
    func configure(with animal: Animal) {
        DispatchQueue.global().async {
            guard let url = URL(string: animal.imageLink ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.animalImageView.image = UIImage(data: imageData)
            }
        }
    }
}
// Надо вынести работу с получением картинки в сетевой слой!
