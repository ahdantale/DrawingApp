//
//  DatabaseService.swift
//  DrawingApp
//
//  Created by Abhishek Dantale on 24/06/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService {
    //Variable for the initial view controller
    var initialVC : InitialVC?
    
    //Instance for the database
    let db = Firestore.firestore()
    
    //Singleton instance
    static let instance = DatabaseService()
    
    //Function to add the data to the collection
    func addDataToFirestore() {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    //Function to add the image to collection
    func addImageToFirestore(forImageWith data : Data) {
        var ref : DocumentReference? = nil
        ref = self.db.collection("images").addDocument(data: ["image":data], completion: { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Document added with ID : \(ref!.documentID)")
            }
        })
    }
    
    //Function to read the images from the collection
    func readImagesFromFirestore() {
        self.db.collection("images").getDocuments(completion: { (querySnapshot, error) in
            if let error = error {
                print("Some error in reading documents : \(error.localizedDescription)")
            } else {
                print(querySnapshot!.documents[0].data())
            }
        })
    }
    
    //Function to write image name and download url to the firebase
    func writeImageDataToDataBase(withImageName imageName : String,havingURL imageURL : URL) {
        var imageData : [String:Any] = ["imageName":imageName,"imageURL":imageURL.absoluteString]
        var ref : DocumentReference? = nil
        ref = self.db.collection("images").addDocument(data: imageData, completion: { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Image data uploaded successfully")
                DispatchQueue.main.async {
                    self.initialVC?.loadingView?.activityIndicator.hidesWhenStopped = true
                    self.initialVC?.loadingView?.loadingLabel.text = "Uploaded Successfully"
                    self.initialVC?.loadingView?.activityIndicator.stopAnimating()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                        self.initialVC?.loadingView?.removeFromSuperview()
                        self.initialVC?.fetchImages()
                    })
                }
            }
        })
    }
    
    //Function to read all the image data from firestore and to pass onto
    func readAllTheImageData(_ handler : @escaping (_ imageData : [[String : Any]],_ done : Bool)->()) {
        self.db.collection("images").getDocuments(completion: { (querySnapshot, error) in
            if let error = error {
                print("Some error in reading documents : \(error.localizedDescription)")
                handler([[:]],false)
            } else {
                var imageData = [[String:Any]]()
                print(querySnapshot!.documents)
                for aDocument in querySnapshot!.documents {
                    print("A document : \(aDocument.data())")
                    imageData.append(aDocument.data())
                }
                handler(imageData,true)
            }
        })
    }
}
