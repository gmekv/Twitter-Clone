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
    @State private var isSecure: Bool = true
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(.gray)
                        .allowsHitTesting(false)
                }

                if isSecure {
                    SecureField("", text: $text)
                        .frame(height: 45)
                        .foregroundStyle(Color.twitterBlue)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                } else {
                    TextField("", text: $text)
                        .frame(height: 45)
                        .foregroundStyle(Color.twitterBlue)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                }
            }
            .overlay(alignment: .trailing) {
                Button {
                    isSecure.toggle()
                    DispatchQueue.main.async {
                        isFocused = true
                    }
                } label: {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 8)
                }
                .buttonStyle(.plain)
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

