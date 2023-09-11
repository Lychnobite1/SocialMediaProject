//
//  LoginModel.swift
//  Proje
//
//  Created by MURAT BAŞER on 8.09.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
class LoginModel : ObservableObject {
    @Published var issignIn = false
    func signIn(email : String,password : String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("sign in error")
            }
            else {
                self.issignIn = true
                print("sign in success")
                
            }
        }
    }

    
    func signUp(email : String,password : String,username:String,image:UIImage){
        // sign up
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("sign up error")
            }
            else {
                let storage = Storage.storage()
                let storageReferance = storage.reference()
                let mediaFolder = storageReferance.child("images")
                if let data = image.jpegData(compressionQuality: 0.5) {
                    let uuid = UUID().uuidString
                    let imageReferance = mediaFolder.child("\(uuid).jpg")
                    imageReferance.putData(data,metadata: nil) { (metadata, error) in
                        if error != nil {
                            print("putdata error")
                        }
                        else {
                            imageReferance.downloadURL { (url, error) in
                                let imageUrl = url?.absoluteString
                                print("sign up success")
                                // database
                                let db = Firestore.firestore()
                                var ref : DocumentReference?
                                let myDictionary : [String : Any] = ["username":username,"userEmail":email,"userId":result!.user.uid,"imageUrl":imageUrl]
                                ref = db.collection("Users").addDocument(data: myDictionary,completion: { (error) in
                                    if error != nil {
                                        print("error")
                                    }
                                    else {
                                        print("database saved")
                                    }
                                })
                            }
                        }
                    }
                }
                
            }
        }
    }

    func logOut() {
        do{
            try Auth.auth().signOut()
            print("loggout success")
        }
        catch{
            print("error")
        }
    }
    
    
}


