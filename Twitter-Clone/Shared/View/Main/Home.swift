//
//  Home.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 04.11.25.
//

import SwiftUI

struct Home: View {
    
    @State var selectedIndex = 0
    @State var showCreateTweet = false
    @State var text = ""
    
    var body: some View {
        VStack {
            ZStack {
                TabView(selection: $selectedIndex) {
                    Feed()
                        .tabItem {
                            if (selectedIndex == 0) {
                                Image("Home")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color("bg"))
                            } else {
                                Image("Home")
                            }
                        }
                        .tag(0)
                    
                    SearchView()
                        .tabItem {
                            if (selectedIndex == 1) {
                                Image("Search")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color("bg"))
                            } else {
                                Image("Search")
                            }
                        }
                        .tag(1)
                    
                    NotificationsView()
                        .tabItem {
                            if (selectedIndex == 2) {
                                Image("Notifications")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color("bg"))
                            } else {
                                Image("Notifications")
                            }
                        }
                        .tag(2)
                    
                    MessagesView()
                        .tabItem {
                            if (selectedIndex == 3) {
                                Image("Messages")
                                    .renderingMode(.template)
                                    .foregroundStyle(Color("bg"))
                            } else {
                                Image("Messages")
                            }
                        }
                        .tag(3)
                }
                .onChange(of: selectedIndex) { oldValue, newValue in
                    print("Selected tab index: \(newValue)")
                }
                VStack {
                    Spacer()

                    HStack {
                        Spacer()
                        Button {
                            showCreateTweet.toggle()
                        } label: {
                            Image("tweet")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(Color.blue)
                                .foregroundStyle(.white)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 65)
                }

                }
            .sheet(isPresented: $showCreateTweet) {
                CreateTweetView(text: text)
            }
            }
        }
    }


#Preview {
    Home()
}
