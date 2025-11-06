//
//  MainView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.11.25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            TopBar()
            Home()
        }
    }
}

#Preview {
    MainView()
}
