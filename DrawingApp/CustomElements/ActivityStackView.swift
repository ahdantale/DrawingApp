//
//  ActivityStackView.swift
//  DrawingApp
//
//  Created by Abhishek Dantale on 24/06/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class ActivityStackView: UIStackView {

    //Variable for the loading label
    var loadingLabel : UILabel!
    
    //Variable for the activityViewIndicator
    var activityIndicator : UIActivityIndicatorView!
    
    //Initializers for the stack view
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customizeTheView()
        self.addTheElementsToTheStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.customizeTheView()
        self.addTheElementsToTheStackView()
    }
    
    //Function to add the elements to the view
    func addTheElementsToTheStackView() {
        self.loadingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
        self.loadingLabel.textColor = .white
        self.loadingLabel.textAlignment = .center
        self.loadingLabel.text = "Loading ..."
        
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 220, height: 80))
        self.activityIndicator.startAnimating()
        self.activityIndicator.color = .white
        
        
        self.insertSubview(self.loadingLabel, at: 0)
        self.insertSubview(self.activityIndicator, at: 1)
        
        self.spacing = 30
        self.distribution = .equalCentering
    }
    
    //Function to customize the view
    func customizeTheView() {
        self.backgroundColor = UIColor.black
    }
}
