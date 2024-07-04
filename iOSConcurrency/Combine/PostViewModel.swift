//
//  PostViewModel.swift
//  iOSConcurrency
//
//  Created by Ömer Bozbulut on 3.07.2024.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var errorMessage: IdentifiableError?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = PostService()
    
//MARK: Subscribe and recevice
    func fetchPosts() {
        apiService.fetchPosts()
            .sink { completion in  // Rx -> Subscribe
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            } receiveValue: { posts in
                self.posts = posts
            }
            .store(in: &cancellables)    // Rx -> DisposeBag
    }
}
