//
//  MessageCellView.swift
//  Proje
//
//  Created by MURAT BAŞER on 10.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct MessageCellView: View {
    var message : MessageUser
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    if let url = URL(string: message.profilImage) {
                        WebImage(url: url)
                            .resizable()
                            .frame(width: 90,height: 90)
                            .clipShape(Circle())
                    }
                    VStack(alignment: .leading, spacing: 10){
                        Text(message.username)
                            .font(.system(size: 20))
                            .fontDesign(.serif)
                        Text("Mesaj için tıklayınız")
                            .font(.system(size: 14))
                    }
                    Spacer()
                    
                }.padding(.horizontal)
                
            }
            .navigationTitle("Messages")
        }
    }
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        MessageCellView(message: MessageUser(userId: "asdasdasdsa", username: "Murat Başer", profilImage: "nofoto"))
    }
}
