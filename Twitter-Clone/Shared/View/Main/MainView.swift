//
//  MainView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.11.25.
//

import SwiftUI

struct MainView: View {
    let user: User
    @State var width = UIScreen.main.bounds.width - 90
    @State var x = -UIScreen.main.bounds.width - 30
    @State var dragOffset: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center) ) {
                    VStack {
                        TopBar(x: $x)
                        Home (user: user)
                    }
                    .onTapGesture {
                        // Close menu when tapping main content area
                        if x == 0 {
                            withAnimation {
                                x = -width
                            }
                        }
                    }
                    
                    SlideMenu()
                        .frame(width: width)
                        .offset(x: x + dragOffset)
                        .ignoresSafeArea(.all, edges: .vertical)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // Only allow dragging when menu is visible or being dragged
                                    if x == 0 || dragOffset != 0 {
                                        dragOffset = max(min(value.translation.width, 0), -width)
                                    }
                                }
                                .onEnded { value in
                                    withAnimation(.spring()) {
                                        let totalOffset = x + dragOffset
                                        let velocity = value.predictedEndTranslation.width
                                        
                                        // Decide whether to snap open or closed
                                        if velocity < -300 {
                                            // Fast swipe left - close
                                            x = -width
                                        } else if velocity > 300 {
                                            // Fast swipe right - open
                                            x = 0
                                        } else if totalOffset > -width/2 {
                                            // Past middle point - open
                                            x = 0
                                        } else {
                                            // Before middle point - close
                                            x = -width
                                        }
                                        
                                        dragOffset = 0
                                    }
                                }
                        )
                }
                .navigationBarHidden(true)
                .navigationTitle("")
                }
            }
        }
}


