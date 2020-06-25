//
//  InitialVC.swift
//  DrawingApp
//
//  Created by Abhishek Dantale on 24/06/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {
    
    //Variable for the canvas
    var canvas : CanvasView!
    
    //Variable for the loading view
    var loadingView : ActivityView?
    
    //Variable for the undo button
    var undoButton : UIButton!
    
    //Variable for the save image button
    var saveButton : UIButton!
    
    //Variable for the width slider
    var widthSlider : UISlider!
    
    //Variable for the stack view
    var colourStackView : UIStackView!
    
    //Variable for all the buttons for colours
    var redColourButton  : UIButton!
    var greenColourButton : UIButton!
    var blueColourButton : UIButton!
    var blackColourButton : UIButton!
    var whiteColourButton : UIButton!
    
    //View life cycle related functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Drawing Pad"
        self.setUpRightBarButtonItem()
        self.addCanvasView()
        self.addUndoButton()
        self.addStrokeWidthSlider()
        self.addStackView()
        self.addSaveButton()
        self.setUpLeftBarButtonItem()
        //DatabaseService.instance.addDataToFirestore()
        DatabaseService.instance.readImagesFromFirestore()
        self.fetchImages()
    }
    
    //Varibale for the image data
    var drawingImages : [Data]?
    
    //Function to add the canvas to the view
    func addCanvasView() {
        self.canvas = CanvasView(frame: self.view.frame)
        self.view.addSubview(self.canvas)
        self.canvas.translatesAutoresizingMaskIntoConstraints = false
        self.canvas.backgroundColor = UIColor.white
        NSLayoutConstraint.activate([
            self.canvas.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: +0),
            self.canvas.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: +0),
            self.canvas.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: +0),
            self.canvas.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: +0)
        ])
    }
    
    //Function to add the button to the view
    func addUndoButton() {
        self.undoButton = UIButton(frame: .zero)
        self.canvas.addSubview(self.undoButton)
        self.undoButton.translatesAutoresizingMaskIntoConstraints = false
        self.undoButton.setTitleColor(.black, for: .normal)
        self.undoButton.setTitle("Undo", for: .normal)
        
        self.undoButton.addTarget(self, action: #selector(self.undoButtonPressed(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.undoButton.topAnchor.constraint(equalTo: self.canvas.topAnchor, constant: +10),
            self.undoButton.leftAnchor.constraint(equalTo: self.canvas.leftAnchor, constant: +8),
            self.undoButton.heightAnchor.constraint(equalToConstant: 25),
            self.undoButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //Function to add the slider for the stroke width
    func addStrokeWidthSlider() {
        self.widthSlider = UISlider(frame: .zero)
        self.canvas.addSubview(self.widthSlider)
        self.widthSlider.translatesAutoresizingMaskIntoConstraints = false
        
        self.widthSlider.minimumValue = 1.0
        self.widthSlider.maximumValue = 10.0
        
        self.widthSlider.tintColor = UIColor.black
        self.widthSlider.thumbTintColor = UIColor.lightGray
        
        self.widthSlider.addTarget(self, action: #selector(self.changeStrokeWidth(_:)), for: .valueChanged)
        NSLayoutConstraint.activate([
            self.widthSlider.heightAnchor.constraint(equalToConstant: 60),
            self.widthSlider.bottomAnchor.constraint(equalTo: self.canvas.bottomAnchor, constant: -10),
            self.widthSlider.widthAnchor.constraint(equalToConstant: 300),
            self.widthSlider.centerXAnchor.constraint(equalTo: self.canvas.centerXAnchor, constant: +0)
        ])
    }
    
    //Function to add the stack view
    func addStackView() {
        //All the buttons for the colours
        self.redColourButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        self.greenColourButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        self.blueColourButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        self.blackColourButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        self.whiteColourButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        
        self.redColourButton.clipsToBounds = true
        self.greenColourButton.clipsToBounds = true
        self.blueColourButton.clipsToBounds = true
        self.blackColourButton.clipsToBounds = true
        self.whiteColourButton.clipsToBounds = true
        
        self.redColourButton.layer.cornerRadius = 0.5 * redColourButton.frame.size.height
        self.greenColourButton.layer.cornerRadius = 0.5 * greenColourButton.frame.size.height
        self.blueColourButton.layer.cornerRadius = 0.5 * blueColourButton.frame.size.height
        self.blackColourButton.layer.cornerRadius = 0.5 * blackColourButton.frame.size.height
        self.whiteColourButton.layer.cornerRadius = 0.5 * whiteColourButton.frame.size.height
        
        self.redColourButton.backgroundColor = .red
        self.greenColourButton.backgroundColor = .green
        self.blueColourButton.backgroundColor = .blue
        self.blackColourButton.backgroundColor = .black
        self.whiteColourButton.backgroundColor = .white
        
        self.redColourButton.layer.borderColor = UIColor.white.cgColor
        self.greenColourButton.layer.borderColor = UIColor.white.cgColor
        self.blueColourButton.layer.borderColor = UIColor.white.cgColor
        self.blackColourButton.layer.borderColor = UIColor.darkGray.cgColor
        self.whiteColourButton.layer.borderColor = UIColor.darkGray.cgColor
        
        self.redColourButton.layer.borderWidth = 2.0
        self.greenColourButton.layer.borderWidth = 2.0
        self.blueColourButton.layer.borderWidth = 2.0
        self.blackColourButton.layer.borderWidth = 2.0
        self.whiteColourButton.layer.borderWidth = 2.0
        
        self.redColourButton.alpha = 0.75
        self.greenColourButton.alpha = 0.75
        self.blueColourButton.alpha = 0.75
        self.blackColourButton.alpha = 0.75
        self.whiteColourButton.alpha = 0.75
        
        self.redColourButton.addTarget(self, action: #selector(self.redColourButtonPressed(_:)), for: .touchUpInside)
        self.greenColourButton.addTarget(self, action: #selector(self.greenColourButtonPressed(_:)), for: .touchUpInside)
        self.blueColourButton.addTarget(self, action: #selector(self.blueColourButtonPressed(_:)), for: .touchUpInside)
        self.blackColourButton.addTarget(self, action: #selector(self.blackColourButtonPressed(_:)), for: .touchUpInside)
        self.whiteColourButton.addTarget(self, action: #selector(self.whiteColourButtonPressed(_:)), for: .touchUpInside)
        
        self.colourStackView = UIStackView(arrangedSubviews: [self.redColourButton,self.greenColourButton,self.blueColourButton,self.blackColourButton])
        self.colourStackView.distribution = .fillEqually
        self.colourStackView.spacing = 10
        
        self.canvas.addSubview(self.colourStackView)
        self.colourStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.colourStackView.heightAnchor.constraint(equalToConstant: 25),
            self.colourStackView.widthAnchor.constraint(equalToConstant: 130),
            self.colourStackView.topAnchor.constraint(equalTo: self.canvas.topAnchor, constant: +10),
            self.colourStackView.centerXAnchor.constraint(equalTo: self.canvas.centerXAnchor, constant: +0)
        ])
    }
    
    //Function to add the save button
    func addSaveButton() {
        self.saveButton = UIButton(frame: .zero)
        self.saveButton.setImage(UIImage(systemName: "photo.fill"), for: .normal)
        self.canvas.addSubview(self.saveButton)
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.saveButton.tintColor = UIColor.black
        self.saveButton.addTarget(self, action: #selector(self.saveButtonPressed(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.saveButton.topAnchor.constraint(equalTo: self.canvas.topAnchor, constant: +10),
            self.saveButton.rightAnchor.constraint(equalTo: self.canvas.rightAnchor, constant: -8),
            self.saveButton.heightAnchor.constraint(equalToConstant: 35),
            self.saveButton.widthAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    
    //Function for the action of the undo button
    @objc func undoButtonPressed(_ sender : Any) {
        print("UNDO BUTTON PRESSED")
        if let _ = self.canvas.multiLines.popLast() {
            self.canvas.setNeedsDisplay()
        }
        
    }
    
    //Funtion for the action of the save button
    @objc func saveButtonPressed(_ sender : Any) {
        print("Save button pressed")
        self.drawingImages = nil
        self.saveImage()
    }
    
    //Function to change the width of the slide
    @objc func changeStrokeWidth(_ sender : Any) {
        self.canvas.strokeWidth = CGFloat(self.widthSlider.value)
    }
    
    //Functions for all the buttons
    @objc func redColourButtonPressed(_ sender : Any) {
        print("Red colour button pressed")
        self.canvas.strokeColour = .red
        
        self.redColourButton.layer.borderColor = UIColor.darkGray.cgColor
        self.greenColourButton.layer.borderColor = UIColor.white.cgColor
        self.blueColourButton.layer.borderColor =  UIColor.white.cgColor
        self.blackColourButton.layer.borderColor = UIColor.white.cgColor
        self.whiteColourButton.layer.borderColor = UIColor.white.cgColor
        
    }
    
    @objc func greenColourButtonPressed(_ sender : Any) {
        print("Green colour button pressed")
        self.canvas.strokeColour = .green
        
        self.redColourButton.layer.borderColor = UIColor.white.cgColor
        self.greenColourButton.layer.borderColor = UIColor.darkGray.cgColor
        self.blueColourButton.layer.borderColor =  UIColor.white.cgColor
        self.blackColourButton.layer.borderColor = UIColor.white.cgColor
        self.whiteColourButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @objc func blueColourButtonPressed(_ sender : Any) {
        print("Blue colour button pressed")
        self.canvas.strokeColour = .blue
        
        self.redColourButton.layer.borderColor = UIColor.white.cgColor
        self.greenColourButton.layer.borderColor = UIColor.white.cgColor
        self.blueColourButton.layer.borderColor =  UIColor.darkGray.cgColor
        self.blackColourButton.layer.borderColor = UIColor.white.cgColor
        self.whiteColourButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @objc func blackColourButtonPressed(_ sender : Any) {
        print("Black colour button pressed")
        self.canvas.strokeColour = .black
        
        self.redColourButton.layer.borderColor = UIColor.white.cgColor
        self.greenColourButton.layer.borderColor = UIColor.white.cgColor
        self.blueColourButton.layer.borderColor =  UIColor.white.cgColor
        self.blackColourButton.layer.borderColor = UIColor.darkGray.cgColor
        self.whiteColourButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @objc func whiteColourButtonPressed(_ sender : Any) {
        print("White colour button pressed")
        self.canvas.strokeColour = .white
        
        self.redColourButton.layer.borderColor = UIColor.white.cgColor
        self.greenColourButton.layer.borderColor = UIColor.white.cgColor
        self.blueColourButton.layer.borderColor =  UIColor.white.cgColor
        self.blackColourButton.layer.borderColor = UIColor.white.cgColor
        self.whiteColourButton.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    //Function to save the image to the camera roll
    func saveImage() {
        
        self.colourStackView.isHidden = true
        self.widthSlider.isHidden = true
        self.undoButton.isHidden = true
        self.saveButton.isHidden = true
        
        UIGraphicsBeginImageContext(self.canvas.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        self.canvas.layer.render(in: context)
        let drawingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(drawingImage!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        //DatabaseService.instance.addImageToFirestore(forImageWith: (drawingImage!.jpegData(compressionQuality: 0.5))!)
        StorageService.instance.uploadImageToStorage(withImageFor: (drawingImage!.jpegData(compressionQuality: 0.5))!)
        
        self.colourStackView.isHidden = false
        self.widthSlider.isHidden = false
        self.undoButton.isHidden = false
        self.saveButton.isHidden = false
        
        self.presentLoadingView()
        
    }
    
    //Action to save the image to the camera roll
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        print("Image saved or not")
        if let error = error {
            print(error.localizedDescription)
        }
    }
    
    //Function to present the loading view
    func presentLoadingView() {
        let loadingView = ActivityView(frame: CGRect(x: 0, y: 0, width: 220, height: 180))
        self.canvas.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        DatabaseService.instance.initialVC = self
        
        NSLayoutConstraint.activate([
            loadingView.heightAnchor.constraint(equalToConstant: 180),
            loadingView.widthAnchor.constraint(equalToConstant: 220),
            loadingView.centerXAnchor.constraint(equalTo: self.canvas.centerXAnchor, constant: +0),
            loadingView.centerYAnchor.constraint(equalTo: self.canvas.centerYAnchor, constant: +0)
        ])
        
        loadingView.activityIndicator.startAnimating()
        
        self.loadingView = loadingView
    }
    
    //Function to set up the right bar button item
    func setUpRightBarButtonItem() {
        var rightBarButtonItem = UIBarButtonItem(title: "All photos", style: .plain, target: self, action: #selector(self.rightBarButtonItemAction(_:)))
        rightBarButtonItem.tintColor = .red
        rightBarButtonItem.image = UIImage(systemName: "circle.grid.2x2.fill")
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    //Function to set up the left bar button item
    func setUpLeftBarButtonItem() {
        var leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(self.leftBarButtonItemAction(_:)))
        leftBarButtonItem.image = UIImage(systemName: "xmark.circle.fill")
        leftBarButtonItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    //Function for the action of of the right bar button item
    @objc func rightBarButtonItemAction(_ sender : Any) {
        print("Right button pressed")
        if let images = self.drawingImages {
            let allDrawingsVC = AllDrawingsVC()
            allDrawingsVC.drawingImages = images
            self.navigationController?.pushViewController(allDrawingsVC, animated: true)
        } else {
            let alertController = UIAlertController(title: "Images are being downloaded", message: "Please wait", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
        
    }
    
    //Function to the left bar button item action
    @objc func leftBarButtonItemAction(_ sender : Any) {
        self.logOutUser()
    }
    
    //Function to fetch the data from firebase
    func fetchImages() {
        self.presentLoadingView()
        DatabaseService.instance.readAllTheImageData({ (dict,done) in
            print(done)
            StorageService.instance.downloadAllImageFromStorage(forImageData: dict, withCompletionHandler: { (data,done) in
                print(data.count)
                if done {
                    self.drawingImages = data
                    DispatchQueue.main.async {
                        self.loadingView?.removeFromSuperview()
                    }
                } else {
                    
                }
                
            })
        })
    }
    
    //Function to log out the user
    func logOutUser() {
        AuthService.instance.logOutUser(handler: { done in
            if done {
                let logInVC = LoginVC()
                self.navigationController?.popViewController(animated: true)
            } else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Log Out Failed", message: "Internal Error", preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                        alertController.dismiss(animated: true, completion: nil)
                    })
                }
            }
        })
    }

}
