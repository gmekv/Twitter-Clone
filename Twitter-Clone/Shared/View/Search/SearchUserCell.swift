//
//  SearchUserCell.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.11.25.
//

import SwiftUI

struct SearchUserCell: View {
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Cem")
                    .fontWeight(.heavy)
                Text("@gmekv05")
            }
            Spacer(minLength: 0)
        }
            }
}

#Preview {
    SearchUserCell()
}
