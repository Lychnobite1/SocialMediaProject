//
//  ChatRow.swift
//  Proje
//
//  Created by MURAT BAŞER on 10.09.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct ChatRow: View {
    var chatMessage : ChatModel
    var userToChatFromChatView : UserModel
    var body: some View {
        Group {
            if chatMessage.messageFrom == Auth.auth().currentUser!.uid && chatMessage.messageTo == userToChatFromChatView.uid {
                HStack{
                    Spacer()
                    Text(chatMessage.message)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(10)
                        .background(.red.opacity(0.3))
                        .cornerRadius(30)
                }
                
            }
            else if chatMessage.messageFrom == userToChatFromChatView.uid && chatMessage.messageTo == Auth.auth().currentUser!.uid {
                HStack{
                    Text(chatMessage.message)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(10)
                        .background(.red.opacity(0.3))
                        .cornerRadius(30)
                    Spacer()
                }
            }
            else {
                // no
            }
            
        }.frame(width: UIScreen.main.bounds.width * 0.95)
    }
}


struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chatMessage: ChatModel(id: 1, message: "asdasd", uidFromFirebase: "asdasd", messageFrom: "asdasdas", messageTo: "asdasdas", messageDate: Date(), messageFromMe: true), userToChatFromChatView: UserModel(id: 1, name: "asdasd", uid: "asdasd", userimage: "asdasd", email: "asdsad"))
    }
}
