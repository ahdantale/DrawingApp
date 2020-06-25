//
//  AuthService.swift
//  DrawingApp
//
//  Created by Abhishek Dantale on 25/06/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import Foundation
import FirebaseAuth


class AuthService {
    //Singleton instance for the class
    static let instance = AuthService()
    
    //Function to register the user
    func registerUser(withEmail emailID:String, withPassword password:String,handler : @escaping (_ done : Bool)->()) {
        Auth.auth().createUser(withEmail: emailID, password: password, completion: { (result,error) in
            if let error = error {
                print(error.localizedDescription)
                handler(false)
            } else {
                handler(true)
            }
        })
    }
    
    //Function to login the user
    func loginUser(withEmail emailID:String, withPassword password:String,handler : @escaping (_ done : Bool)->()){
        Auth.auth().signIn(withEmail: emailID, password: password, completion: { (result,error) in
            if let error = error {
                print(error.localizedDescription)
                handler(false)
            } else {
                handler(true)
            }
        })
    }
    
    //Function to log out the user
    func logOutUser(handler : @escaping (_ done : Bool)->()) {
        do {
            try Auth.auth().signOut()
            handler(true)
        } catch let error as NSError {
            print("Sign out error \(error.localizedDescription)")
            handler(false)
        }
    }
}
