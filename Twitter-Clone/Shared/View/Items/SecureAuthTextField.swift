//
//  SecureAuthTextField.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 11.11.25.
//

import SwiftUI

struct SecureAuthTextField: View {
    
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Text(placeholder)
                    .foregroundStyle(.gray)
                
                SecureField("", text: $text)
                    .frame(height: 45)
                    .foregroundStyle(Color.twitterBlue)
            }
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundStyle(.gray)
                .padding(.top, -2)
        }
        .padding(.horizontal)
    }
}
