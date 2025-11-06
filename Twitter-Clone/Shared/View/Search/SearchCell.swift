//
//  SearchCell.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 05.11.25.
//

import SwiftUI

struct SearchCell: View {
    
    var tag = ""
    var tweets = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("hello").fontWeight(.heavy)
            Text("Tweets: \(tweets)").fontWeight(.light)
        }
    }
}

#Preview {
    SearchCell()
}
