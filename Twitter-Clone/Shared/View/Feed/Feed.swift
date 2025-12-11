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
        
        RefreshableScrollView {
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack(spacing: 18){
                    
                    // Sample Tweets...
                    
                    ForEach(viewModel.tweets){ tweet in
                        
                        TweetCellView(viewModel: TweetCellViewModel(tweet: tweet, currentUser: user))
                        
                        Divider()
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                .zIndex(0)
            })
        } onRefresh: { control in
            DispatchQueue.main.async {
                self.viewModel.fetchTweets()
                control.endRefreshing()
            }
            
        }
        
    }
}

