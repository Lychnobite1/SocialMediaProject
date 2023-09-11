//
//  postSaveModel.swift
//  Proje
//
//  Created by MURAT BAŞER on 9.09.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
class PostSaveModel : ObservableObject {
    @Published var postArray : [PostModel] = []
    @Published var profilUsername = String()
    @Published var profilImage = String()
    @Published var postCounter : Int = 0
    
    
    
    func uploadData(id : UUID,description:String,likeCount:Int,profiPhoto:String,username:String) {
        let db = Firestore.firestore()
        var ref : DocumentReference?
        let firestoreData : [String : Any] = ["userid":Auth.auth().currentUser!.uid,"description":description,"likeCount":likeCount,"profilPhoto":profiPhoto,"username":username,"date":FieldValue.serverTimestamp()]
        ref = db.collection("Posts").addDocument(data: firestoreData,completion: { (error) in
            if error != nil {
                print("addDocument error")
            }
            else {
                print("upload is success")
            }
        })
    }
    
    
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
    
    
    func getData() {
        self.getProfilInfo()
        let db = Firestore.firestore()
        db.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("error")
            }
            else {
                if snapshot != nil {
                    self.postArray.removeAll(keepingCapacity: false)
                    for i in snapshot!.documents {
                        let documentid = i.documentID
                        
                        if let description = i.get("description") as? String {
                            if let likeCount = i.get("likeCount") as? Int {
                                if let username = i.get("username") as? String {
                                    if let profilPhoto = i.get("profilPhoto") as? String {
                                        if let userid = i.get("userid") as? String {
                                            self.postArray.append(PostModel(userid: userid, likeCount: likeCount, description: description, profil: profilPhoto, username: username, documentId: documentid))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getPostCount(userid:String) {
        let db = Firestore.firestore()
        db.collection("Posts").whereField("userid", isEqualTo: userid).getDocuments { (snapshot, error) in
            if error != nil {
                print("error")
            }
            else {
                self.postCounter = snapshot?.documents.count ?? 0
            }
        }
    }
    
    
    
    
}

