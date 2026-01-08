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
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        logger.info("🔄 Starting to fetch tweets for feed")
        
        Task {
            do {
                let fetchedTweets = try await RequestServices.fetchTweets()
                
                await MainActor.run {
                    self.tweets = fetchedTweets
                    logger.info("✅ Successfully loaded \(fetchedTweets.count) tweets")
                }
            } catch {
                logger.error("❌ Failed to fetch tweets: \(error.localizedDescription)")
                print("Error fetching tweets: \(error)")
            }
        }
    }
}
