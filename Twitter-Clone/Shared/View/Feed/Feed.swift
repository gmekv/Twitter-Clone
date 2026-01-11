//
//  Feed.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 04.11.25.
//

import SwiftUI

struct Feed: View {
    
    @ObservedObject var viewModel = FeedViewModel()
    let user: User
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 18) {
                ForEach(viewModel.tweets) { tweet in
                    TweetCellView(viewModel: TweetCellViewModel(tweet: tweet, currentUser: user))
                    Divider()
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .task {
            await viewModel.fetchTweets()
        }
        .refreshable {
            await viewModel.fetchTweets()
        }
    }
}

