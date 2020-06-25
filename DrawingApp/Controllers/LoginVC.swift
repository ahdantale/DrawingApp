//
//  LoginVC.swift
//  DrawingApp
//
//  Created by Abhishek Dantale on 25/06/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //Outlets for textfields
    var loginCredentialTF : UITextField!
    var passwordTF : UITextField!
    
    //Outlet for the login button
    var loginButton : UIButton!
    
    //View life cycle related functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login"
        // Do any additional setup after loading the view.
        self.setupTextField()
        self.setupLoginButton()
    }
    
    //Function to set up the textFields
    func setupTextField() {
        self.loginCredentialTF = UITextField(frame: .zero)
        self.passwordTF = UITextField(frame: .zero)
        
        self.loginCredentialTF.placeholder = "Email ID"
        self.passwordTF.placeholder = "Password"
        
        self.passwordTF.isSecureTextEntry = true
        
        self.loginCredentialTF.borderStyle = .roundedRect
        self.passwordTF.borderStyle = .roundedRect
        
        self.view.addSubview(self.loginCredentialTF)
        self.view.addSubview(self.passwordTF)
        
        self.loginCredentialTF.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.loginCredentialTF.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: +77),
            self.loginCredentialTF.heightAnchor.constraint(equalToConstant: 56),
            self.loginCredentialTF.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +16),
            self.loginCredentialTF.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.passwordTF.topAnchor.constraint(equalTo: self.loginCredentialTF.bottomAnchor, constant: +31),
            self.passwordTF.heightAnchor.constraint(equalToConstant: 56),
            self.passwordTF.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +16),
            self.passwordTF.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    //Function to set up the login button
    func setupLoginButton() {
        self.loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 56))
        self.loginButton.setTitle("Log-In", for: .normal)
        
        self.loginButton.clipsToBounds = true
        self.loginButton.layer.cornerRadius = self.loginButton.frame.size.height * 0.5
        
        self.loginButton.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.5225917015, alpha: 0.8107700893)
        self.loginButton.addTarget(self, action: #selector(self.loginButtonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(self.loginButton)
        
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.loginButton.heightAnchor.constraint(equalToConstant: 56),
            self.loginButton.topAnchor.constraint(equalTo: self.passwordTF.bottomAnchor, constant: +31),
            self.loginButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +16),
            self.loginButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
    }
    
    //Function for the login button action
    @objc func loginButtonPressed(_ sender : Any) {
        print("Login button pressed")
        guard let loginCredential = self.loginCredentialTF.text else { return }
        guard let password = self.passwordTF.text else { return }
        
        if loginCredential.trimmingCharacters(in: .whitespaces) != "" {
            if password.trimmingCharacters(in: .whitespaces) != "" {
                AuthService.instance.registerUser(withEmail: loginCredential, withPassword: password, handler: { done in
                    if done {
                        let initialVC = InitialVC()
                        self.navigationController?.setViewControllers([initialVC], animated: true)
                    } else {
                        AuthService.instance.loginUser(withEmail: loginCredential, withPassword: password, handler: { done in
                            if done {
                                let initialVC = InitialVC()
                                self.navigationController?.pushViewController(initialVC, animated: true)
                            } else {
                                self.presentAlertController()
                            }
                        })
                    }
                })
            }
        }
        
        
    }
    
    //Function to present the alert controller
    func presentAlertController() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Wrong credentials", message: "", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
    }

   

}
