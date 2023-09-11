//
//  postmodel.swift
//  Proje
//
//  Created by MURAT BAŞER on 9.09.2023.
//

import SwiftUI

struct PostModel : Identifiable {
    let id = UUID()
    let userid : String
    let likeCount : Int
    let description : String
    let profil : String
    let username : String
    let documentId : String
}



