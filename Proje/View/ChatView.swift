//
//  ChatView.swift
//  Proje
//
//  Created by MURAT BAŞER on 10.09.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import Combine
struct ChatView: View {
    @State private var message = ""
    var userToChat : UserModel
    @ObservedObject var ViewModel = ChatViewModel()
    var body: some View {
        VStack{
            ScrollView(.vertical,showsIndicators: true){
                ForEach(ViewModel.chatArray){ chats in
                    ChatRow(chatMessage: chats, userToChatFromChatView: self.userToChat)
                }
            }
            
            HStack{
                TextField("Message here..", text: $message).frame(width: 300,height: 40)
                    .border(.black)
                
                Button{
                    if self.message != "" {
                        self.sendMessageToFirebase()
                    }
                }label: {
                    Text("Send")
                }.padding(5)
                    
            }.padding(.horizontal)
        }
    }
    func sendMessageToFirebase() {
        let db = Firestore.firestore()
        var ref : DocumentReference?
        let myChatDictionary : [String : Any] = ["chatUserFrom":Auth.auth().currentUser!.uid,"chatUserTo":userToChat.uid,"date":generateDate(),"message":self.message]
        ref = db.collection("Chats").addDocument(data: myChatDictionary,completion: { (error) in
            if error != nil {
                print("message send is error")
            }
            else {
                print("message send is success")
                self.message = ""
            }
        })
    }
    func generateDate() -> String {
        let formetter = DateFormatter()
        formetter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formetter.string(from: Date()) as NSString) as String
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(userToChat: UserModel(id: 1, name: "dasdas", uid: "dasdsad", userimage: "asdas", email: "asdasd"))
    }
}
