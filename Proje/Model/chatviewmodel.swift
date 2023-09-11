//
//  chatviewmodel.swift
//  Proje
//
//  Created by MURAT BAŞER on 10.09.2023.
//

import SwiftUI
import Firebase
import Combine

class ChatViewModel : ObservableObject {
    let db = Firestore.firestore()
    var chatArray : [ChatModel] = []
    
    var objectWillChange = PassthroughSubject<Array<Any>,Never>()
    init(){
        db.collection("Chats").whereField("chatUserFrom", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("error")
            }
            else {
                self.chatArray.removeAll(keepingCapacity: false)
                for i in snapshot!.documents {
                    let documentid = i.documentID
                    if let chatMessage = i.get("message") as? String {
                        if let messageFrom = i.get("chatUserFrom") as? String {
                            if let messageTo = i.get("chatUserTo") as? String {
                                if let dataString = i.get("date") as? String {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                    let dateFromFB = dateFormatter.date(from: dataString)
                                    let currentIndex = self.chatArray.last?.id
                                    let createdChat = ChatModel(id: (currentIndex ?? -1) + 1, message: chatMessage, uidFromFirebase: documentid, messageFrom: messageFrom, messageTo: messageTo, messageDate: dateFromFB!, messageFromMe: true)
                                    self.chatArray.append(createdChat)
                                    
                                }
                            }
                        }
                    }
                }
                
                self.db.collection("Chats").whereField("chatUserTo", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { (snapshot, error) in
                    if error != nil {
                        print("error")
                    }
                    else {
                        for i in snapshot!.documents {
                            let documentid = i.documentID
                            if let chatMessage = i.get("message") as? String {
                                if let messageFrom = i.get("chatUserFrom") as? String {
                                    if let messageTo = i.get("chatUserTo") as? String {
                                        if let dateString = i.get("date") as? String {
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                            let dateFromFB = dateFormatter.date(from: dateString)
                                            
                                            let currentIndex = self.chatArray.last?.id
                                            let createdChat = ChatModel(id: (currentIndex ?? -1) + 1, message: chatMessage, uidFromFirebase: documentid, messageFrom: messageFrom, messageTo: messageTo, messageDate: dateFromFB!, messageFromMe: true)
                                            self.chatArray.append(createdChat)
                                        }
                                    }
                                }
                            }
                        }
                        self.chatArray = self.chatArray.sorted(by: {
                            $0.messageDate.compare($1.messageDate) == .orderedAscending
                        })
                        self.objectWillChange.send(self.chatArray)
                    }
                }
            }
        }
    }
    
    
 
}
