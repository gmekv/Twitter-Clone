//
//  NotificationsView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 04.11.25.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<9) { _ in
                    NotificationCell()
                }
            }
        }
    }
}

#Preview {
    NotificationsView()
}
