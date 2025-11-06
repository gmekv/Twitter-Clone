//
//  MessageCell.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.11.25.
//

import SwiftUI

struct MessageCell: View {
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundStyle(.gray)
                .opacity(0.3)
            
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Cem")
                            .foregroundStyle(.primary)
                        
                        Text("gmekv")
                            .foregroundStyle(.gray)
                        Spacer(minLength: 0)
                        
                        Text("6/20/21")
                            .foregroundStyle(.gray)
                            .padding(.trailing)
                    }
                    Text("Hey, how is it going")
                        .foregroundStyle(.gray)
                    Spacer()
                }
            }
            .padding(.top, 2)
        }
        .frame(width: width, height: 84)
    }
}

#Preview {
    MessageCell()
}
