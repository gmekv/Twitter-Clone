//
//  TopBar.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.11.25.
//

import SwiftUI

struct TopBar: View {
    @State var width = UIScreen.main.bounds.width
    var body: some View {
        VStack {
            HStack
            {
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 24))
                        .foregroundStyle(Color("bg"))
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
                .opacity(0.3)
        }
        .background(Color.white)
    }
}
#Preview {
    TopBar()
}
