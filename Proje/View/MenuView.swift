//
//  MenuView.swift
//  Proje
//
//  Created by MURAT BAŞER on 9.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct MenuView: View {
    @ObservedObject var ViewModel = FirebaseModel()
    @State private var ismessageView = false
    init() {
        self.ViewModel.getProfilInfo()
    }
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 30){
                Divider()
                    .background(.white)
                    .frame(width: 180,height: 5)
                if let url = URL(string: ViewModel.profilImage) {
                    WebImage(url: url)
                        .resizable()
                        .frame(width: 110,height: 110)
                        .clipShape(Circle())
                        .offset(x:30)
                }
                Text(ViewModel.profilUsername)
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .offset(x:30)

                Divider()
                    .background(.white)
                    .frame(width: 180,height: 5)

                Button{
                    
                }label: {
                    Label("Profil", systemImage: "person")
                }
                .foregroundColor(.white)
                .font(.system(size: 20))
                Button{
                    self.ismessageView = true
                }label: {
                    NavigationLink(destination: MessageView(), isActive: $ismessageView){
                        Label("Messages", systemImage: "message")
                    }
                }
                .foregroundColor(.white)
                .font(.system(size: 20))
                Spacer()
            }
            .frame(width: 250)
            .background(.black)
            .edgesIgnoringSafeArea(.bottom)
            
            .onAppear{
                self.ViewModel.getProfilInfo()
            }
            
            
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
