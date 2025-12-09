//
//  CustomProfileTextField.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 08.12.25.
//

import SwiftUI

struct CustomProfileTextField: View {
    @Binding var message: String
    var placeholder: String
    
    var body: some View {
        HStack {
            ZStack {
                HStack {
                    if message.isEmpty {
                        Text(placeholder)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    TextField("", text: $message )
                        .foregroundStyle(.blue)
                }
            }
        }
    }}

