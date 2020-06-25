//
//  ActivityView.swift
//  DrawingApp
//
//  Created by Abhishek Dantale on 24/06/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class ActivityView: UIView {

    //Variable for the loading label
    var loadingLabel : UILabel!
    
    //Variable for the activityViewIndicator
    var activityIndicator : UIActivityIndicatorView!
    
    //Initializers for the stack view
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customizeTheView()
        self.addTheElementsToTheView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.customizeTheView()
        self.addTheElementsToTheView()
    }
    
    //Function to customize the view
    func customizeTheView() {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.clipsToBounds = true
        self.layer.cornerRadius = 25
    }
    
    //Function to add the elements to the view
    func addTheElementsToTheView() {
        self.loadingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 50))
        self.loadingLabel.textColor = .white
        self.loadingLabel.textAlignment = .center
        self.loadingLabel.text = "Loading ..."
        self.loadingLabel.font = UIFont(name: "HelveticNeue", size: 25)
        
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 180, height: 80))
        self.activityIndicator.startAnimating()
        self.activityIndicator.style = .large
        self.activityIndicator.color = .white
        
        self.addSubview(self.loadingLabel)
        self.addSubview(self.activityIndicator)
        
        self.loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.loadingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: +0),
            self.loadingLabel.widthAnchor.constraint(equalToConstant: 180),
            self.loadingLabel.heightAnchor.constraint(equalToConstant: 80),
            self.loadingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: +0),
            
            self.activityIndicator.topAnchor.constraint(equalTo: self.loadingLabel.bottomAnchor, constant: 0),
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 80),
            self.activityIndicator.widthAnchor.constraint(equalToConstant: 180),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: +0)
            
        ])
    }

}
