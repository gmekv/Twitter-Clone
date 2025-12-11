//
//  FeedViewModel.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.12.25.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject {
    
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        
        RequestServices.requestDomain = "http://localhost:3000/tweets"
        
        RequestServices.fetchData { res in
            switch res {
                case .success(let data):
                    guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data as! Data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.tweets = tweets
                    }

                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
