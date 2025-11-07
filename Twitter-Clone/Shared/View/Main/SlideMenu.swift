//
//  SlideMenu.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.11.25.
//

import SwiftUI

struct SlideMenu: View {
    @State var show = false
    var menuButtons = ["Profile","Lists","Topics","Bookmarks","Moments"]
//    var edges = UIApplication.shared.windows.first?.safeAreaInsets

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 12) {
                    Image("logo")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    Text("Cem")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    Text("gmekv")
                        .foregroundStyle(.gray)
                    
                    HStack(spacing: 20) {
                        FollowView(count: 8, title: "Following")
                        FollowView(count: 16, title: "Followers")
                    }
                    .padding(.top, 10)
                    
                    Divider()
                        .padding(.top, 10)
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        self.show.toggle()
                    }
                } label: {
                    Image(systemName: show ? "chevron.down" : "chevron.up")
                        .foregroundStyle(Color(.blue))
                }
                }
                VStack(alignment: .leading) {
                    ForEach(menuButtons, id: \.self) { item in
                        MenuButton(title: item)
                    }
                    
                    Divider()
                        .padding(.top)
                    Button {
                        
                    } label: {
                        MenuButton(title: "Twitter Ads")
                    }
                    Divider()
                    Button {
                        
                    } label: {
                        Text("Setting and privacy")
                            .foregroundStyle(.black)
                    }
                    .padding(.top, 20)
                    Button {
                        
                    } label: {
                        Text("Help Centre")
                            .foregroundStyle(.black)
                    }

                    Spacer(minLength: 0)
                    Divider()
                        .padding(.bottom)
                    HStack {
                        Button {
                            
                        } label: {
                            Image("help")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundStyle(Color("bg"))
                        }
                        Spacer(minLength: 0)
                        Image("barcode")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 26, height: 26)
                            .foregroundStyle(Color("bg"))
                    }
                }
                .opacity(show ? 1 : 0)
                .frame(height: show ? nil : 0)
            VStack(alignment: .leading) {
                Button {
                    
                } label: {
                    Text("Create a new account")
                        .foregroundStyle(Color(.blue))
                }
                
                Button {
                    
                } label: {
                    Text("Add an exiting account")
                        .foregroundStyle(Color(.blue))
                }
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(!show ? 1 : 0)
            .frame(height: !show ? nil : 0)
        }
        .padding(.top, 50) // Push the menu down from the top
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // Fill entire height
        .background(Color(.systemBackground)) // Add background color to match the app
    }
}

#Preview {
    SlideMenu()
}
