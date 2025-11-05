//
//  CreateTweetView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 04.11.25.
//

import SwiftUI

struct CreateTweetView: View {
    @State var text = ""
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Tweet").padding()
                }
                .background(Color("bg"))
                .foregroundStyle(.white)
                .clipShape(Capsule())
            }
            MultilineTextField(text: $text)
        }
        .padding()
    }
}

#Preview {
    CreateTweetView()
}
