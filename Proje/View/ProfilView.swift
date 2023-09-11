//
//  ProfilView.swift
//  Proje
//
//  Created by MURAT BAŞER on 9.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseAuth
struct ProfilView: View {
    @ObservedObject var ViewModel = FirebaseModel()
    @State private var isLogout = false
    @ObservedObject var LoginViewModel = LoginModel()
    @ObservedObject var PostModelView = PostSaveModel()
    var body: some View {
        NavigationStack{
            VStack{
                if let url = URL(string: self.ViewModel.profilImage){
                    WebImage(url: url)
                        .resizable()
                        .frame(width: 100,height: 100)
                        .clipShape(Circle())
                }
                HStack{
                    ZStack{
                        Rectangle().fill(.white)
                            .frame(width: (UIScreen.main.bounds.width / 2) - 10,height: 80)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(.black)
                            )
                        VStack{
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 20,height: 20)
                            Text(self.ViewModel.profilUsername)
                                .font(.system(size: 22))
                        }
                    }
                    ZStack{
                        Rectangle().fill(.white)
                            .frame(width: (UIScreen.main.bounds.width / 2) - 10,height: 80)
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(.black)
                            )
                        VStack{
                            Image(systemName: "arrowshape.turn.up.right")
                                .resizable()
                                .frame(width: 20,height: 20)
                            Text("\(PostModelView.postCounter)")
                                .font(.system(size: 22))

                        }
                    }
                }
                SlidingMainView()
                Spacer()
                    
            }
            .onAppear{
                self.ViewModel.getProfilInfo()
                self.PostModelView.getPostCount(userid: Auth.auth().currentUser!.uid)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        self.LoginViewModel.logOut()
                        self.isLogout = true
                        
                    }label: {
                        Text("Logout")
                    }
                    
                }
            }
            .background(
                NavigationLink(destination: LoginView(), isActive: $isLogout){
                    EmptyView()
                }
            )
        }
    }
}


struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
