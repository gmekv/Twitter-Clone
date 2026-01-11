//
//  FeedViewModel.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.12.25.
//

import Foundation
import Combine
import OSLog

class FeedViewModel: ObservableObject {
    
    @Published var tweets = [Tweet]()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.app", category: "FeedViewModel")
    
    
    
    func fetchTweets() async {
        
        do {
            let fetchedTweets = try await RequestServices.fetchTweets()
            await MainActor.run {
                self.tweets = fetchedTweets
            }
        } catch {
            logger.error("❌ Failed")
        }
    }
}
