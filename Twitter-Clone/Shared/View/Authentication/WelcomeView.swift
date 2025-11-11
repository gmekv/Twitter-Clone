//
//  WelcomeView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 10.11.25.
//

import SwiftUI

struct WelcomeView: View {
    private var attributedText: AttributedString {
        var text = AttributedString("By signing up, you agree to our Terms, Privacy Policy, and Cookie Use.")
        let blueColor = Color.twitterBlue
        
        if let termsRange = text.range(of: "Terms") {
            text[termsRange].foregroundColor = blueColor
        }
        if let privacyRange = text.range(of: "Privacy Policy") {
            text[privacyRange].foregroundColor = blueColor
        }
        if let cookieRange = text.range(of: "Cookie Use") {
            text[cookieRange].foregroundColor = blueColor
        }
        
        return text
    }
    

    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 0)
                Image("Twitter")
                    .resizable()
                    .scaledToFill()
                    .padding(.trailing)
                    .frame(width: 20, height: 20)
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
            Text("See What is happening in the world right now.")
                .font(.system(size: 30, weight: .heavy, design: .default))
                .frame(width: getRect().width * 0.9, alignment: .center)
            Spacer(minLength: 0)
            VStack(alignment: .center, spacing: 10) {
                Button {
                    print("Sign in with Google")
                } label: {
                    HStack(spacing: -4) {
                        Image("google")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("Continue with Google")
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundStyle(.black)
                            .padding()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 36)
                            .stroke(Color.black, lineWidth: 1)
                            .opacity(0.3)
                            .frame(width: 320, height: 60, alignment: .center)
                    )
                }
                
                Button {
                    print("apple")
                } label: {
                    HStack(spacing: -4) {
                        Image(systemName: "applelogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.black)
                        Text("Continue with Apple")
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundStyle(.black)
                            .padding()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 36)
                            .stroke(Color.black, lineWidth: 1)
                            .opacity(0.3)
                            .frame(width: 320, height: 60, alignment: .center)
                    )
                }
                }
            HStack {
                Rectangle()
                    .foregroundStyle(.gray)
                    .opacity(0.3)
                    .frame(width: (getRect().width * 0.35), height: 1)
                Text("Or")
                    .foregroundStyle(.black)
                Rectangle()
                    .foregroundStyle(.gray)
                    .opacity(0.3)
                    .frame(width: (getRect().width * 0.35), height: 1)
            }
            NavigationLink {
                RegisterView().navigationBarHidden(true)
            } label: {
                RoundedRectangle(cornerRadius: 36)
                    .foregroundStyle(Color.twitterBlue)
                    .frame(width: 320, height: 60, alignment: .center)
                    .overlay {
                        Text("Create account")
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding()
                    }
            }

            VStack(alignment: .leading) {
                VStack {
                    Text(attributedText)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .frame(width: getRect().width * 0.9, alignment: .leading)
                }
            }
            
            Spacer().frame(height: 20)
            
            HStack(spacing: 2) {
                Text("Have an account already? ")
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                
                NavigationLink {
                    LogInView().navigationBarHidden(true)
                } label: {
                    Text("Log in")
                        .font(.callout)
                        .foregroundStyle(Color.twitterBlue)
                }
                
                Spacer()
            }
            .frame(width: getRect().width * 0.9)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        }
    }


#Preview {
    WelcomeView()
}
