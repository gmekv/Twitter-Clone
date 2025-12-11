//
//  UserProfile.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 07.11.25.
//

import SwiftUI
import Kingfisher

struct UserProfile: View {
    
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    var isCurrentUser: Bool { return viewModel.user.isCurrentUser ?? false}
    var isFollowed: Bool { return viewModel.user.isFollowed ?? false}
    
    @State var offset: CGFloat = 0
    
    // For Dark Mode Adoption..
    @Environment(\.colorScheme) var colorScheme
    
    @State var currentTab = "Tweets"
    
    // For Smooth Slide Animation...
    @Namespace var animation
    
    @State var tabBarOffset: CGFloat = 0
    
    @State var titleOffset: CGFloat = 0
    
    @State private var selectedImage: UIImage?
    @State var profileImage: Image?
    @State var imagePickerRepresented = false
    
    @State var editProfileShow = false
    
    @State var width = UIScreen.main.bounds.width
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
        
    }
    
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(spacing: 15) {
                
                // Header View...
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .global).minY
                    
                    ZStack {
                        Image("banner")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180, alignment: .center)
                            .cornerRadius(0)
                        
                        BlurView()
                            .opacity(blurViewOpacity())
                        
                        VStack(spacing: 5) {
                            Text(viewModel.user.name)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("150 Tweets")
                                .foregroundColor(.white)
                        }
                        .offset(y: 120)
                        .offset(y: titleOffset > 100 ? 0 : -getTitleTextOffset())
                        .opacity(titleOffset < 100 ? 1 : 0)
                    }
                    .clipped()
                    .frame(height: minY > 0 ? 180 + minY : nil)
                    .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                    .onChange(of: minY) { newValue in
                        offset = newValue
                    }
                }
                
                .frame(height: 180)
                .zIndex(1)
                
                // Profile Image...
                
                VStack {
                    
                    HStack {
                        
                        VStack {
                            if profileImage == nil {
                                
                                Button {
                                    self.imagePickerRepresented.toggle()
                                } label: {
                                    KFImage(URL(string: "http://localhost:3000/users/\(self.viewModel.user.id)/avatar"))
                                        .placeholder({
                                            Image("blankpp")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 75, height: 75)
                                                .clipShape(Circle())
                                        })
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                        .padding(8)
                                        .background(colorScheme == .dark ? Color.black : Color.white)
                                        .clipShape(Circle())
                                        .offset(y: offset < 0 ? getOffset() - 20 : -20)
                                        .scaleEffect(getScale())
                                }
                            }
                            
                            else if let image = profileImage {
                                VStack {
                                    HStack(alignment: .top) {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 75, height: 75)
                                            .clipShape(Circle())
                                            .padding(8)
                                            .background(colorScheme == .dark ? Color.black : Color.white)
                                            .clipShape(Circle())
                                            .offset(y: offset < 0 ? getOffset() - 20 : -20)
                                            .scaleEffect(getScale())
                                        
                                        
                                    }
                                    .padding()
                                    
                                    Spacer()
                                }
                            }
                            
                        }
                        
                        Spacer()
                        
                        if (self.isCurrentUser) {
                            Button(action: {
                                
                                editProfileShow.toggle()
                            }, label: {
                                Text("Edit Profile")
                                    .foregroundColor(.blue)
                                    .padding(.vertical,10)
                                    .padding(.horizontal)
                                    .background(
                                        
                                        Capsule()
                                            .stroke(Color.blue, lineWidth: 1.5)
                                    )
                            })
                            .onAppear {
                                print("called")
                                KingfisherManager.shared.cache.clearCache()
                            }
                            .sheet(isPresented: $editProfileShow, onDismiss: {
                                KingfisherManager.shared.cache.clearCache()
                                AuthViewModel.shared.fetchUser(userId: viewModel.user.id)
                            }, content: {
                                EditProfileView(user: $viewModel.user)
                            })
                        }
                        else {
                            
                            Button(action: {
                                isFollowed ? self.viewModel.unfollow() : self.viewModel.follow()
                            }, label: {
                                Text(isFollowed ? "Following" : "Follow")
                                    .foregroundColor(isFollowed ? .black : .white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
//                                    .background(isFollowed ? Color.white : Color.black)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 3)
//                                            .stroke(Color.black, lineWidth: isFollowed ? 1.5 : 0)
//                                    )
                                    .background(
                                        
                                        ZStack {
                                            Capsule()
                                                .stroke(Color.black, lineWidth: isFollowed ? 1.5 : 0)
                                                .foregroundColor(isFollowed ? .white : .black)
                                            Capsule()
                                                .foregroundColor(isFollowed ? .white : .black)
                                        }
                                )
                            })
                            
                        }
                        
//                        .sheet(isPresented: $editProfileShow) {
//                            AuthViewModel.shared.fetchUser(userId: viewModel.user.id)
//                            KingfisherManager.shared.cache.clearCache()
//                        } content: {
//                            EditProfileView(user: $viewModel.user)
//                        }
                    }
                    .padding(.top, -25)
                    .padding(.bottom, -10)
                    
                    // Profile Data...
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text(viewModel.user.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("@\(viewModel.user.username)")
                                .foregroundColor(.gray)
                            
                            Text(viewModel.user.bio ?? "Make education not fail! 4️⃣2️⃣ Founder @TurmaApp soon.. @ProbableApp")
                            
                            HStack(spacing: 8) {
                                if let userLocation = viewModel.user.location {
                                    if (userLocation != "") {
                                        HStack(spacing: 2) {
                                            Image(systemName: "mappin.circle.fill")
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.gray)
                                            Text(userLocation)
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14))
                                        }
                                    }
                                }
                                
                                if let userWebsite = viewModel.user.website {
                                    if (userWebsite != "") {
                                        HStack(spacing: 2) {
                                            Image(systemName: "link")
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.gray)
                                            Text(userWebsite)
                                                .foregroundColor(Color("twitter"))
                                                .font(.system(size: 14))
                                        }
                                    }
                                }
                            }
                            
                            HStack(spacing: 5) {
                                
                                Text("4,560")
                                    .foregroundColor(.primary)
                                    .fontWeight(.semibold)
                                
                                Text("Followers")
                                    .foregroundColor(.gray)
                                
                                Text("680")
                                    .foregroundColor(.primary)
                                    .fontWeight(.semibold)
                                    .padding(.leading,10)
                                
                                Text("Following")
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 8)
                        })
                        .padding(.leading, 8)
                        .overlay(
                            
                            GeometryReader { proxy in
                                let minY = proxy.frame(in: .global).minY
                                
                                Color.clear
                                    .onChange(of: minY) { newValue in
                                        titleOffset = newValue
                                    }
                            }
                            .frame(width: 0, height: 0)
                            
                            ,alignment: .top
                        )
                        
                        Spacer()
                    }
                    
                    // Custom Segmented Menu...
                    
                    VStack(spacing: 0) {
                        
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            
                            HStack(spacing: 0){
                                
                                TabButton(title: "Tweets", currentTab: $currentTab, animation: animation)
                                
                                TabButton(title: "Tweets & Likes", currentTab: $currentTab, animation: animation)
                                
                                TabButton(title: "Media", currentTab: $currentTab, animation: animation)
                                
                                TabButton(title: "Likes", currentTab: $currentTab, animation: animation)
                            }
                        })
                        
                        Divider()
                    }
                    .padding(.top,30)
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 0)
                    .overlay(
                        
                        GeometryReader { reader in
                            let minY = reader.frame(in: .global).minY
                            
                            Color.clear
                                .onChange(of: minY) { newValue in
                                    tabBarOffset = newValue
                                }
                        }
                        .frame(width: 0, height: 0)
                        
                        ,alignment: .top
                    )
                    .zIndex(1)
                    
                    VStack(spacing: 18) {
                        
                        // Sample Tweets...
                        
                        ForEach(viewModel.tweets){ tweet in
                            
                            TweetCellView(viewModel: TweetCellViewModel(tweet: tweet, currentUser: AuthViewModel.shared.currentUser!))
                            
                            Divider()
                        }
                    }
                    .padding(.top)
                    .zIndex(0)
                }
                .padding(.horizontal)
                // Moving the view back if it goes > 80...
                .zIndex(-offset > 80 ? 0 : 1)
            }
        })
        .ignoresSafeArea(.all, edges: .top)
    }
    
    func getTitleTextOffset()->CGFloat{
        
        // some amount of progress for slide effect..
        let progress = 20 / titleOffset
        
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        
        return offset
    }
    
    // Profile Shrinking Effect...
    func getOffset()->CGFloat{
        
        let progress = (-offset / 80) * 20
        
        return progress <= 20 ? progress : 20
    }
    
    func getScale()->CGFloat{
        
        let progress = -offset / 80
        
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        
        // since were scaling the view to 0.8...
        // 1.8 - 1 = 0.8....
        
        return scale < 1 ? scale : 1
    }
    
    func blurViewOpacity()->Double{
        
        let progress = -(offset + 80) / 150
        
        return Double(-offset > 80 ? progress : 0)
    }
}



extension View {
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}

extension UserProfile {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

