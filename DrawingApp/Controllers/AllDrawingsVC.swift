//
//  AllDrawingsVC.swift
//  DrawingApp
//
//  Created by Abhishek Dantale on 25/06/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class AllDrawingsVC: UIViewController {
    
    //Variable for the UICollectionView
    var imageCollectionView : UICollectionView!
    
    //Variable for the images
    var drawingImages : [Data]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Explore"
        self.setUpCollectionView()
    }
    
    func setUpCollectionView() {
        let imageCollectionViewFlowLayout = UICollectionViewFlowLayout()
        imageCollectionViewFlowLayout.itemSize = CGSize(width: 160, height: 284.44)
        //imageCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        self.imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: imageCollectionViewFlowLayout)
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        
        self.imageCollectionView.register(ImageCVC.self, forCellWithReuseIdentifier: "cell")
        
        self.view.addSubview(self.imageCollectionView)
        self.imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.imageCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: +0),
            self.imageCollectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: +5),
            self.imageCollectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -5),
            self.imageCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: +0)
        ])
        
        self.imageCollectionView.backgroundColor = .white
    }
    

}


//Extension for delegates and data source
extension AllDrawingsVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = self.drawingImages else { return 0 }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCVC
        if let _ = self.drawingImages {
            cell.image.image = UIImage(data: self.drawingImages![indexPath.row])
            cell.image.clipsToBounds = true
            cell.image.layer.cornerRadius = 25
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 3.0
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 25
        } else {
            cell.image.image = UIImage(named: "test")
        }
        return cell
    }
    
    
}
