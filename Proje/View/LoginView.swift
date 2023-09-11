//
//  ContentView.swift
//  Proje
//
//  Created by MURAT BAŞER on 8.09.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var mail = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var issignIn = false
    @ObservedObject var ViewModel = LoginModel()
    @State private var errorMessage = ""
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, spacing: 25){
                TextField("Email", text: $mail)
                    .padding(15)
                    .border(.black.opacity(0.3))
                    .padding()
                SecureField("Password", text: $password)
                    .padding(15)
                    .border(.black.opacity(0.3))
                    .padding()
                Button{
                    if mail != "" || password != "" {
                        ViewModel.signIn(email: self.mail, password: self.password)
                        self.mail = ""
                        self.password = ""
                        self.errorMessage = ""
                    }
                    else {
                        self.errorMessage = "There is a empty places"
                    }
                    
                    if ViewModel.issignIn == true {
                        self.issignIn = true
                    }
                }label: {
                    Text("Sign In")
                }
                .frame(width: 250,height: 50)
                .background(.blue)
                .cornerRadius(20)
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                
                NavigationLink(destination: MainView(), isActive: $ViewModel.issignIn){
                    EmptyView()
                }
                
                
                
                
                Text(errorMessage)
                    .foregroundColor(.red)
                    .offset(y:25)
                HStack{
                    Text("Don't you have an account?")
                    Button{
                        self.isSignUp = true
                    }label: {
                        Text("Sign Up")
                    }
                }.offset(y:50)
                
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $isSignUp){
                RegisterView()
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
