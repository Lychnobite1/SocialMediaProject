//
//  chatmodel.swift
//  Proje
//
//  Created by MURAT BAŞER on 10.09.2023.
//

import SwiftUI

struct ChatModel : Identifiable{
    var id : Int
    var message : String
    var uidFromFirebase : String
    var messageFrom : String
    var messageTo : String
    var messageDate : Date
    var messageFromMe : Bool
}
