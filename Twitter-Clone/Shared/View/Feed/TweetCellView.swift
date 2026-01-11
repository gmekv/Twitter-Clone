//
//  TweetCellView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 05.11.25.
//

import SwiftUI
import Kingfisher

struct TweetCellView: View {
    @ObservedObject var viewModel: TweetCellViewModel
    var didLike: Bool { return viewModel.tweet.didLike ?? false }

    init(viewModel: TweetCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, content: {
                if let user = viewModel.user {
                    
                    NavigationLink(destination: UserProfile(user: user)) {
                        if viewModel.user?.avatarExists == true {
                            KFImage(URL(string: APIConfig.Endpoints.userAvatar(id: viewModel.tweet.userId)))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 55, height: 55)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.gray)
                                )
                        }
                    }
                } else {
                    
                    // Loading placeholder - shows while user data is being fetched
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 55, height: 55)
                        .overlay(
                            Image(systemName: "person.fill")
                                .foregroundColor(.red)
                        )
                        .redacted(reason: .placeholder)
                }
                
                
                VStack(alignment: .leading, spacing: 10, content: {
                    
                    (
                        
                        Text("\(viewModel.tweet.username) ")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            
                            +
                            
                        Text("@\(viewModel.tweet.username)")
                            .foregroundColor(.gray)
                    )
                    
                    Text(viewModel.tweet.text)
                        .frame(maxHeight: 100, alignment: .top)
                    
                    if viewModel.tweet.image == "true" {
                        GeometryReader{ proxy in

                            KFImage(URL(string: APIConfig.Endpoints.tweetImage(id: viewModel.tweet.id)))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.frame(in: .global).width, height: 250)
                                .cornerRadius(15)
                        }
                        .frame(height: 250)
                    }
                    
                })
                Spacer()
                // Has been added after designing
            })
            
            
            // Cell Bottom
            
            
            HStack(spacing : 50) {
                
                Button(action: {
                    
                }) {
                    
                    Image("Comments").resizable().frame(width: 16, height: 16)
                    
                }.foregroundColor(.gray)
                
                Button(action: {
                    
                }) {
                    
                    Image("Retweet").resizable().frame(width: 18, height: 14)
                    
                }.foregroundColor(.gray)
                
                Button(action: {
                    if (self.didLike) {
                        print("it has not been liked")
                        viewModel.unlikeTweet()

                    }
                    else {
                        print("it has been liked")
                        viewModel.likeTweet()
                    }
                }) {
                    
                    if (self.didLike == false) {
                        Image("love").resizable().frame(width: 18, height: 15)
                    }
                    else {
                        Image("love").resizable().renderingMode(.template).foregroundColor(.red).frame(width: 18, height: 15)
                    }
                    
                }.foregroundColor(.gray)
                
                Button(action: {
                    
                }) {
                    
                    Image("upload").resizable().renderingMode(.template).frame(width: 16, height: 16)
                    
                }.foregroundColor(.gray)
            }
            .padding(.top, 4)
        }
    }
}


