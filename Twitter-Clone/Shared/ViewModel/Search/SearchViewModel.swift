//
//  SearchViewModel.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 11.01.26.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        AuthServices.requestDomain = APIConfig.Endpoints.allUsers
        
        AuthServices.fetchUsers { res in
            switch res {
                case .success(let data):
                    guard let users = try? JSONDecoder().decode([User].self, from: data as! Data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.users = users
                    }

                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.name.lowercased().contains(lowercasedQuery) || $0.username.lowercased().contains(lowercasedQuery) })
    }
    
}
