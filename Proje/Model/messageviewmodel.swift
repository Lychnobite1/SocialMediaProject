//
//  messageviewmodel.swift
//  Proje
//
//  Created by MURAT BAŞER on 10.09.2023.
//

import SwiftUI
import Firebase
import Combine
class MessageViewModel : ObservableObject {
    var userArray : [MessageUser] = []
    var userArrayTwo : [UserModel] = []
    let db = Firestore.firestore()
    var objectWillChange = PassthroughSubject<Array<Any>,Never>()
    
    
    init() {
        // get datas
        db.collection("Users").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("error")
            }
            else {
                self.userArray.removeAll(keepingCapacity: false)
                self.userArrayTwo.removeAll(keepingCapacity: false)
                for i in snapshot!.documents {
                    if let userid = i.get("userId") as? String {
                        if let username = i.get("username") as? String {
                            if let profilImage = i.get("imageUrl") as? String {
                                if let email = i.get("userEmail") as? String {
                                    if userid != Auth.auth().currentUser!.uid {
                                        let createdUser = MessageUser(userId: userid, username: username, profilImage: profilImage)
                                        self.userArray.append(createdUser)
                                        let currentIndex = self.userArrayTwo.last?.id
                                        
                                        self.userArrayTwo.append(UserModel(id: (currentIndex ?? -1) + 1, name: username, uid: userid, userimage: profilImage, email: email))
                                    }
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

