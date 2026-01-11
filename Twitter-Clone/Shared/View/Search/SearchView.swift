//
//  SearchView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 04.11.25.
//

import SwiftUI

struct SearchView : View {
    
    @State var text = ""
    @State var isEditing = false
    
    var users: [User] {
        return text.isEmpty ? viewModel.users : viewModel.filteredUsers(text)
    }
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var body : some View {
        
        VStack {
            
            ScrollView {
                SearchBar(text: $text, isEditing: $isEditing)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                
                LazyVStack {
                    ForEach(users) { user in
                        NavigationLink(destination: UserProfile(user: user)) {
                            SearchUserCell(user: user)
                                .padding(.leading)
                        }
                    }
                }
            }
        }
    }
}

//struct SearchCell : View {
//    
//    var tag = ""
//    var tweets = ""
//    
//    var body : some View{
//        
//        VStack(alignment : .leading,spacing : 5){
//            
//            Text(tag).fontWeight(.heavy)
//            Text(tweets + " Tweets").fontWeight(.light)
//        }
//    }
//}
