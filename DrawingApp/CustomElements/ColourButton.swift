//
//  ColourButton.swift
//  DrawingApp
//
//  Created by Abhishek Dantale on 25/06/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class ColourButton: UIButton {

    //Variable to keep track of button press
    var isButtonPressed = false
    
    //Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //Function to customize the button
    func customizeButton() {
        
    }
    
    
    
}
