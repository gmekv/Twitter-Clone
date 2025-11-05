//
//  Feed.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 04.11.25.
//

import SwiftUI

struct Feed: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 18) {
                ForEach(1...20, id: \.self) { _ in
                    TweetCellView(tweet: "Sample tweet text", tweetImage: "post")
                }
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .zIndex(0)
    }
}

#Preview {
    Feed()
}
