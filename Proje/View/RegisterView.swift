//
//  RegisterView.swift
//  Proje
//
//  Created by MURAT BAŞER on 8.09.2023.
//

import SwiftUI

struct RegisterView: View {
    @State private var mail = ""
    @State private var password = ""
    @State private var passwordAgain = ""
    @State private var username = ""
    @State private var errorMessage = ""
    @State private var isPicker = false
    @State private var selectedImage : UIImage?
    @ObservedObject var ViewModel = LoginModel()
    var body: some View {
        VStack{
            ZStack{
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .frame(width: 110,height: 110)
                        .clipShape(Circle())
                }
                else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 110,height: 110)
                        .clipShape(Circle())
                }
                
                Button{
                    self.isPicker = true
                }label: {
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                }
                .offset(x:50,y: 50)
            }
            TextField("Email", text: $mail)
                .padding(15)
                .border(.black.opacity(0.3))
                .padding()
            SecureField("Password", text: $password)
                .padding(15)
                .border(.black.opacity(0.3))
                .padding()
            SecureField("Password Again", text: $passwordAgain)
                .padding(15)
                .border(.black.opacity(0.3))
                .padding()
            TextField("Username", text: $username)
                .padding(15)
                .border(.black.opacity(0.3))
                .padding()
            Button{
                if mail == "" || password == "" || passwordAgain == "" || username == "" {
                    self.errorMessage = "There is empty places"
                }
                else if password != passwordAgain {
                    self.errorMessage = "Passwords is different"
                }
                else if selectedImage == nil {
                    self.errorMessage = "please select image"
                }
                else {
                    ViewModel.signUp(email: mail, password: password, username: username, image: selectedImage!)
                    self.errorMessage = "Sign up is success"
                    
                }
            }label: {
                Text("Sign Up")
            }
            .frame(width: 250,height: 50)
            .background(.blue)
            .cornerRadius(20)
            .foregroundColor(.white)
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .offset(y:30)
            
            Text(errorMessage)
                .foregroundColor(.red)
                .offset(y:50)
            
        }.offset(y:-40)
            .sheet(isPresented: $isPicker){
                ImagePicker(selectedImage: $selectedImage, isPicker: $isPicker)
            }
    }
}



struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
