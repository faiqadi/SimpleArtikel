//
//  AuthManager.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 25/04/25.
//

import Auth0
import RxSwift
import RxRelay
import JWTDecode

class Auth0Manager {
    static let shared = Auth0Manager()
    var credentialDataRelay =  BehaviorSubject<CredentialModel>(value: CredentialModel.empty)
    
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
    
    func login(){
        Auth0.webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    UserDefaults.isAuthenticated = true
                    UserDefaults.token = credentials.accessToken
                    if CredentialModel.from(credentials.idToken).name != "" {
                        UserDefaults.username = CredentialModel.from(credentials.idToken).name
                    } else {
                        UserDefaults.username = CredentialModel.from(credentials.idToken).email
                    }
                    PersistentTimer.shared.cancelCountdown()
                    PersistentTimer.shared.startCountdown()
                    self.credentialDataRelay.onNext(CredentialModel.from(credentials.idToken))
                    
                case .failure(let error):
                    print("error = \(error)")
                }
            }
    }
    func logout(){
          Auth0.webAuth()
              .clearSession { result in
                  switch result {
                  case .success:
                      UserDefaults.username = ""
                  case .failure:
                     print("Logout Fail")
                  }
              }
      }
}
