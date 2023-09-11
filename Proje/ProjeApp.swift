//
//  ProjeApp.swift
//  Proje
//
//  Created by MURAT BAŞER on 8.09.2023.
//

import SwiftUI
import Firebase
@main
struct ProjeApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser != nil {
                MainView()
            }
            else {
                LoginView()
            }
            
        }
    }
}
