//
//  PostShareView.swift
//  Proje
//
//  Created by MURAT BAŞER on 9.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct PostShareView: View {
    @State private var description = ""
    @ObservedObject var ViewModel = FirebaseModel()
    @ObservedObject var PostViewModel = PostSaveModel()
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    if let url = URL(string: self.ViewModel.profilImage){
                        WebImage(url: url)
                            .resizable()
                            .frame(width: 60,height: 60)
                            .clipShape(Circle())
                    }
                    
                    TextField("What do you thing?", text: $description,axis: .vertical)
                        .frame(height: 50)
                        .padding(.horizontal)
                        .border(.black.opacity(0.2))
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                        }
                    
                    
                    
                }.padding(.horizontal)
            }
            .onAppear{
                self.ViewModel.getProfilInfo()
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        if self.description != "" {
                            self.PostViewModel.uploadData(id: UUID(), description: description, likeCount: 0, profiPhoto: ViewModel.profilImage, username: ViewModel.profilUsername)
                        }
                    }label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}
