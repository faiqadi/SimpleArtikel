//
//  AuthManager.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 25/04/25.
//

import Auth0

class Auth0Manager {

  let auth0 = Auth0.authentication() /// This is for the Authentication API client NOT webAuth()

  func signup(email: String, password: String, firstName: String, lastName: String, phone: String, address: String, city: String, completion: @escaping (Bool, Error?) -> Void) {
        
        let userMetadata = ["firstName" : firstName, "lastName" : lastName, "email" : email, "phone" : phone, "address" : address, "city" : city]

        auth0.signup(email: email, password: password, connection: "Username-Password-Authentication", userMetadata: userMetadata)
            .start { result in
                switch result {
                case .success(let user):
                    print("User signed up: \(user)") /// Test Message
                    completion(true, nil)
                case .failure(let error):
                    print("Failed to sign up: \(error)") /// Test Message
                    completion(false, error)
                }
            }
    }
}
