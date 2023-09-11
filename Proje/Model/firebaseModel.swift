//
//  firebaseModel.swift
//  Proje
//
//  Created by MURAT BAŞER on 9.09.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
class FirebaseModel : ObservableObject {
    @Published var profilUsername = String()
    @Published var profilImage = String()
    
    func getProfilInfo() {
        let db = Firestore.firestore()
        db.collection("Users").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
            if error != nil {
                print("get documents error!")
            }
            else {
                if let document = snapshot?.documents, let doc = document.first {
                    let data = doc.data()
                    if let username = data["username"] as? String, let profilimageurl = data["imageUrl"] as? String {
                        self.profilImage = profilimageurl
                        self.profilUsername = username
                    }
                }
            }
        }
    }
    
   
}
