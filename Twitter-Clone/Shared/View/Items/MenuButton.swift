//
//  MenuButton.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 07.11.25.
//

import SwiftUI



struct MenuButton: View {
    var title: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(title)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundStyle(.gray)
            
            Text(title)
                .foregroundStyle(.black)
            Spacer(minLength: 0)
                .padding(.vertical, 12)
                    }
    }
}
