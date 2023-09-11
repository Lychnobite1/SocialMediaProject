//
//  userstore.swift
//  Proje
//
//  Created by MURAT BAŞER on 10.09.2023.
//

/*
 imageUrl
 userEmail
 userId
 username
 */
import SwiftUI
import Firebase
import Combine

class UserStore : ObservableObject {
    let db = Firestore.firestore()
    var userArray : [UserModel] = []
    
    var objectWillChange = PassthroughSubject<Array<Any>, Never>()
    
    init(){
        // verileri çekelim
        
        db.collection("Users").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("error")
            }
            else {
                self.userArray.removeAll(keepingCapacity: false)
                for i in snapshot!.documents {
                    if let useruid = i.get("userId") as? String {
                        if let useremail = i.get("userEmail") as? String {
                            if let username = i.get("username") as? String {
                                    if let image = i.get("imageUrl") as? String {
                                        let currentIndex = self.userArray.last?.id
                                        let createdUser = UserModel(id: (currentIndex ?? -1) + 1, name: username, uid: useruid, userimage: image,email: useremail)
                                        self.userArray.append(createdUser)
                                    }
                                }
                                
                            
                        }
                    }
                    
                    
                }
                self.objectWillChange.send(self.userArray)
                
            }
        }
    }
    
}
