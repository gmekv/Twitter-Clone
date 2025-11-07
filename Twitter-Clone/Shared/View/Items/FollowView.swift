//
//  FollowView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.11.25.
//

import SwiftUI

struct FollowView: View {
    var count: Int
    var title: String
    
    var body: some View {
        HStack {
            Text("\(count)")
                .fontWeight(.bold)
                .foregroundStyle(.black)
            
            Text(title)
                .foregroundStyle(.gray)
        }
    }
}
