//
//  MessageView.swift
//  Proje
//
//  Created by MURAT BAŞER on 10.09.2023.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject var ViewModelTwo = MessageViewModel()
    @ObservedObject var ViewModel = UserStore()
    var body: some View {
        NavigationStack{
            VStack{
                
                List{
                    ForEach(ViewModelTwo.userArrayTwo){i in
                        ForEach(ViewModelTwo.userArray,id: \.userId){iTwo in
                            NavigationLink(destination: ChatView(userToChat: i)){
                                MessageCellView(message: iTwo)
                            }
                        }
                    }
                }
                
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
