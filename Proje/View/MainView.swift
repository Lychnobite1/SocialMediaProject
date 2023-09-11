//
//  MainView.swift
//  Proje
//
//  Created by MURAT BAŞER on 8.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
struct MainView: View {
    @State private var isMenu = false
    @State private var isProfilview = false
    @ObservedObject var ViewModel = FirebaseModel()
    @State private var isPostShare = false
    @ObservedObject var PostModel = PostSaveModel()
    @State private var postArray : [PostModel] = []
    @State private var profilUsername = String()
    @State private var profilImage = String()
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    HStack{
                        Text("Do you want to share the post?")
                        Button{
                            self.isPostShare = true
                        }label: {
                            NavigationLink(destination: PostShareView(), isActive: $isPostShare){
                                Text("Share")
                            }
                        }
                    }
                    
                    .padding(.vertical,20)
                    Spacer()
                    List {
                        ForEach(postArray,id: \.id) { i in
                            PostCellView(post: i)
                        }
                    }.listStyle(.inset)
                    
                }
                
                GeometryReader { geo in
                    if self.isMenu == true {
                        HStack{
                            MenuView()
                            Spacer()
                        }
                        .transition(.move(edge: .leading))
                        .animation(.easeIn(duration: 0.3))
                    }
                }
                .background(Color.black.opacity(self.isMenu ? 0.5 : 0))
            }
            .onAppear{
                getProfilInfo()
                getData()
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        withAnimation(.easeIn(duration: 0.3)){
                            self.isMenu.toggle()
                        }
                    }label: {
                        Image(systemName: self.isMenu ? "xmark" : "text.justify")
                            .foregroundColor(self.isMenu ? .white : .black)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        self.isProfilview = true
                    }label: {
                        NavigationLink(destination: ProfilView(), isActive: $isProfilview){
                            if let url = URL(string: self.profilImage){
                                WebImage(url: url)
                                    .resizable()
                                    .frame(width: 40,height: 40)
                                    .clipShape(Circle())
                            }
                        }
                        
                        
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
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
                                            self.postArray.append(Proje.PostModel(userid: userid, likeCount: likeCount, description: description, profil: profilPhoto, username: username, documentId: documentid))
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
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
