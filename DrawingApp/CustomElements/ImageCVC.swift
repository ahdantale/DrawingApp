//
//  ImageCVC.swift
//  DrawingApp
//
//  Created by Abhishek Dantale on 25/06/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class ImageCVC: UICollectionViewCell {
    
    //Outlets for the images
    var image : UIImageView!
    
    //Initializers for the cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpImageView()
    }
    
    //Function to set up the imageview
    func setUpImageView() {
        self.image = UIImageView(frame: .zero)
        self.addSubview(self.image)
        self.image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.image.topAnchor.constraint(equalTo: self.topAnchor, constant: +10),
            self.image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: +10),
            self.image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
}
