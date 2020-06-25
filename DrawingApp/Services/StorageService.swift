//
//  StorageService.swift
//  DrawingApp
//
//  Created by Abhishek Dantale on 24/06/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import Foundation
import Firebase

class StorageService {
    //Singleton instance
    static let instance = StorageService()
    
    //Variable for storage
    let storageReference = Storage.storage().reference()
    
    //Function to upload image
    func uploadImageToStorage(withImageFor data : Data) {
        let metaDataForImage = StorageMetadata()
        metaDataForImage.contentType = "image/jpeg"
        
        let imageName = UUID().uuidString
        print("Image name : \(imageName)")
        
        let imageRef = self.storageReference.child(imageName)
        let uploadTask = imageRef.putData(data, metadata: metaDataForImage, completion: { (metaData,error) in
            guard let metaData = metaData else { return }
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(metaData.size)
            }
            
            imageRef.downloadURL(completion: { (url,error) in
                guard let downloadURL = url else { return }
                print(downloadURL)
                
                DatabaseService.instance.writeImageDataToDataBase(withImageName: imageName, havingURL: downloadURL)
            })
       })
    }
    
    //Function to download all the images from firebase storage
    func downloadAllImageFromStorage(forImageData data : [[String:Any]], withCompletionHandler handler : @escaping (_ images : [Data], _ done : Bool)->()) {
        
        var imagesAsData = [Data]()
        let group = DispatchGroup()
        for anImage in data {
            if anImage["imageName"] == nil {
                continue
            }
            let imageRef = self.storageReference.child(anImage["imageName"] as! String)
            group.enter()
            imageRef.getData(maxSize: INT64_MAX, completion: { (data,error) in
                if let error = error {
                    print(error.localizedDescription)
                    handler([],false)
                    group.leave()
                } else {
                    if let data = data {
                        imagesAsData.append(data)
                        group.leave()
                    }
                }
            })
        }
        
        group.notify(queue: .main, execute: {
            print(imagesAsData.count)
            handler(imagesAsData,true)
        })
        
    }
    
}
