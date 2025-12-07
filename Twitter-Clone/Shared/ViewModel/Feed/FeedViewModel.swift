//
//  FeedViewModel.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.12.25.
//

import Foundation
import Combine


class FeedViewModel: ObservableObject {
    @Published var tweets: [Tweet] = []
    @Published var  isLoading: Bool = false
    //change
    @Published var errorMessage: String?
    
    func fetchTweets() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedTweets = try await RequestServices.fetchTweets()
            
            await MainActor.run {
                self.tweets = fetchedTweets
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to load tweets. Please try again."
                self.isLoading = false
            }
        }
    }
}
