//
//  SlidingPostView.swift
//  Proje
//
//  Created by MURAT BAŞER on 10.09.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct SlidingPostView: View {
    @State private var postArray : [PostModel] = []
    var body: some View {
        VStack{
            List{
                ForEach(postArray,id: \.id){ i in
                    Text(i.description)
                }
            }.listStyle(.inset)
        }.onAppear{
            let db = Firestore.firestore()
            db.collection("Posts").whereField("userid", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
                if error != nil {
                    print("error")
                }
                else {
                    for i in snapshot!.documents {
                        let documentid = i.documentID
                        let data = i.data()
                        self.postArray.append(PostModel(userid: data["userid"] as! String, likeCount: data["likeCount"] as! Int, description: data["description"] as! String, profil: data["profilPhoto"] as! String, username: data["username"] as! String, documentId:documentid))
                    }
                }
            }
        }
    }
}


struct SlidingPostView_Previews: PreviewProvider {
    static var previews: some View {
        SlidingPostView()
    }
}
