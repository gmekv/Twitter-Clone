//
//  TopBar.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.11.25.
//

import SwiftUI

struct TopBar: View {
    @Binding var x: CGFloat
    @State var width = UIScreen.main.bounds.width
    var body: some View {
        VStack {
            HStack
            {
                Button {
                    withAnimation {
                        x = 0
                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 24))
                        .foregroundStyle(.primary)
                }
                
                Spacer(minLength: 0)
                
                Image("Twitter")
                    .resizable()
                    .scaledToFill()
                    .padding(.trailing)
                    .frame(width: 20, height: 20)
                Spacer(minLength: 0)
            }
            
            .padding()
            
            Rectangle()
                .frame(width: width, height: 1)
                .foregroundStyle(.gray)
        }
        .background(Color.white)
    }
}
