//
//  LogINView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 11.11.25.
//

import SwiftUI

struct LogInView: View {
    @State var email = ""
    @State var password = ""
    @State var emailDone = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        if !emailDone  {
            VStack {
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
                    Text("To get started first enter your phone, email, or @username")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    CustomAuthTextField(placeholder: "Phone email or username", text: $email)
                }
                Spacer(minLength: 0)
                VStack {
                    Button {
                        if !email.isEmpty {
                            self.emailDone.toggle()
                        }
                    } label: {
                        Capsule()
                            .frame(width: 360, height: 40, alignment: .center)
                            .foregroundStyle(Color.twitterBlue)
                            .overlay(Text("Next"))
                            .foregroundStyle(.white)
                    }
                    .padding(.bottom, 4)
                    Text("Forgot Password?")
                    
                }
            }
        }
        else {
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Button {
                                
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
                    Text("Enter your password")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    SecureAuthTextField(placeholder: "Password", text: $password)
                }
                Spacer(minLength: 0)
                VStack {
                    Button {
                        self.emailDone.toggle()
                    } label: {
                        Capsule()
                            .frame(width: 360, height: 40, alignment: .center)
                            .foregroundStyle(Color.twitterBlue)
                            .overlay(Text("Log in"))
                            .foregroundStyle(.white)
                    }
                    .padding(.bottom, 4)
                    Text("Forgot Password?")
                    
                }
            }
        }
        }
        
    }


#Preview {
    LogInView()
}
