//
//  CustomAuthTextField.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 11.11.25.
//

import SwiftUI

struct CustomAuthTextField: View {
    
    var placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(.gray)
                        .allowsHitTesting(false)
                }
                
                TextField("", text: $text)
                    .frame(height: 45)
                    .foregroundStyle(Color.twitterBlue)
                    .focused($isFocused)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isFocused = true
            }
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundStyle(.gray)
                .padding(.top, -2)
        }
        .padding(.horizontal)
        
    }
}

