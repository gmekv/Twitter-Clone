//
//  RegisterView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 11.11.25.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = AuthViewModel()
    
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.blue)
                    }
Spacer()
                }
                .padding(.horizontal)
                
                Image("Twitter")
                    .resizable()
                    .scaledToFill()
                    .padding(.trailing)
                    .frame(width: 20, height: 20)
            }
            Text("Create your account")
                .font(.title)
                .bold()
                .padding(.top,35)
            
            VStack(alignment: .leading, content: {
                CustomAuthTextField(placeholder: "Name", text: $name)
                CustomAuthTextField(placeholder: "Phone", text: $email)
                SecureAuthTextField(placeholder: "Password", text: $password)
               
            })
            Spacer(minLength: 0)
            VStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)
            }
            HStack {
                Button {
                    self.viewModel.register(reqBody: ["username": "john123"
                                                      , "name": "name", "email": "testemail@gmail.com", "password": "secret123"])
                } label: {
                    Capsule()
                        .frame(width: 60, height: 30, alignment: .center)
                        .foregroundStyle(Color.twitterBlue)
                        .overlay(Text("Next") .foregroundStyle(.white) )
                }
                .padding(.trailing, 24 )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterView()
}
