//
//  TweetCellViewModel.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.12.25.
//

import SwiftUI
import Combine


class TweetCellViewModel: ObservableObject {
    @Published var tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
}
