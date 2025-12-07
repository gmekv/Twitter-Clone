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
    
    init(viewModel: TweetCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, content: {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    
                    Text("\(self.viewModel.tweet.user)")
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    +
                    Text("\(self.viewModel.tweet.username)")
                        .foregroundStyle(.gray)
                    
                    
                    Text(self.viewModel.tweet.text)
                        .frame(maxHeight: 100, alignment: .top)
                    
                    if viewModel.tweet.image == "true" {
                        GeometryReader{ proxy in
                            let imageURL = "http://localhost:3000/tweets/\(viewModel.tweet.id)/image"
                            
                            KFImage(URL(string: imageURL))
                                .placeholder {
                                    ProgressView()
                                        .frame(width: proxy.size.width, height: 250)
                                }
                                .onFailure { error in
                                    print("❌ Image load failed: \(error)")
                                    print("📍 Attempted URL: \(imageURL)")
                                }
                                .onSuccess { result in
                                    print("✅ Image loaded successfully from: \(imageURL)")
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.size.width, height: 250)
                                .cornerRadius(15)
                                .clipped()
                        }
                        .frame(height: 250)
                        .onAppear {
                            print("🖼️ Attempting to load image for tweet: \(viewModel.tweet.id)")                        }
                    }
                
                    
                }
                
                Spacer()
            })
            //Cell bottom
            
            HStack(spacing: 50) {
                Button {
                    
                } label: {
                    Image("Comments").resizable()
                        .frame(width: 16, height: 16)
                }
                
                Button {
                    
                } label: {
                    Image("Retweet").resizable()
                        .frame(width: 16, height: 14)
                }
                .foregroundStyle(.gray)
                Button {
                    
                } label: {
                    Image("love").resizable()
                        .frame(width: 18, height: 15)
                }.foregroundStyle(.gray)
                    .padding(.top,4)
                
                
                Button {
                    
                } label: {
                    Image("upload").resizable()
                        .renderingMode(.template)
                        .frame(width: 18, height: 15)
                }.foregroundStyle(.gray)
                    .padding(.top,4)
            }
        }
        }
    }

//#Preview {
//    TweetCellView(tweet: "sample", tweetImage: "post")
//}

var sampleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
