//
//  PostCellView.swift
//  Proje
//
//  Created by MURAT BAŞER on 9.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
struct PostCellView: View {
    var post : PostModel
    @State private var isLike = false
    @State private var isMenu = false
    @State private var count : Int = 0
    @State private var ViewModel = FirebaseModel()
    var body: some View {
        VStack{
            HStack(spacing: 20){
                if let url = URL(string: post.profil){
                    WebImage(url: url)
                        .resizable()
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                }
                Text(post.username)
                Text(post.documentId).hidden()
                Spacer()
                
               
            }.padding(.horizontal)
            Text(post.description)
                .padding(.horizontal)
                .padding(.vertical,4)
            HStack{
                Image(systemName: "hand.thumbsup")
                Text("\(count)")
                Spacer()
                Button{
                    
                    
                }label: {
                    Image(systemName: self.isLike ? "heart.fill" : "heart")
                        .foregroundColor(self.isLike ? .red : .black)
                }
                .onTapGesture {
                    self.isLike.toggle()
                    if self.isLike == true {
                        self.count += 1
                    }
                    else {
                        self.count -= 1
                    }
                }
                .padding(.horizontal)
                
                
                
                Button{
                    
                }label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(.black)
                }
                
            }.padding(.horizontal,40)
                .font(.system(size: 21))
                .padding(.vertical,2)
        }
        .onAppear{
            self.ViewModel.getProfilInfo()
        }
    }
}

struct PostCellView_Previews: PreviewProvider {
    static var previews: some View {
        PostCellView(post: PostModel(userid: "asdasdasd", likeCount: 0, description: "adasdas", profil: "asdasd", username: "asdasdas", documentId: "asdasdas"))
    }
}
