//
//  SearchBar.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 05.11.25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField("Search Twitter", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .overlay( HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                })
                .onTapGesture {
                    isEditing = true
                }
                .onChange(of: text) { oldValue, newValue in
                    if !newValue.isEmpty && !isEditing {
                        isEditing = true
                    }
                }
            
            Button(action: {
                isEditing = false
                text = ""
                UIApplication.shared.endEditing()
            }, label: {
                Text("Cancel")
                    .foregroundStyle(.black)
                    .padding(.trailing, 8)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
            })
        }
    }
}


