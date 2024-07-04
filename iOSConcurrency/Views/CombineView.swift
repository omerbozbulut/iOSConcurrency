//
//  CombineView.swift
//  iOSConcurrency
//
//  Created by Ömer Bozbulut on 3.07.2024.
//

import SwiftUI

struct CombineView: View {
    @StateObject private var postViewModel = PostViewModel()
    
    var body: some View {
        ZStack {
            List(postViewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.subheadline)
                }
            }
            .navigationTitle("Posts")
            .onAppear {
                postViewModel.fetchPosts()
            }
            .alert(item: $postViewModel.errorMessage) { errorMessage in
                Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    CombineView()
}
