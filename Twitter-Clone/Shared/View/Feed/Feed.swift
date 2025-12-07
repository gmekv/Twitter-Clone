//
//  Feed.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 04.11.25.
//

import SwiftUI

struct Feed: View {
    @StateObject var viewModel = FeedViewModel()
    let user: User
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 18) {
                ForEach(viewModel.tweets) { tweet in
                    TweetCellView(viewModel: TweetCellViewModel(tweet: tweet))
                    Divider()
                }
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .zIndex(0)
       
        .task {
            await viewModel.fetchTweets()
        }
    }
       
}

