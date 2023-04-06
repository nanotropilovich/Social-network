//
//  PostList.swift
//  Socialcademy
//
//  Created by Ilya on 04.04.2023.
//

import Foundation
import SwiftUI

struct PostsList: View {
    
    // private var posts = [Post.testPost]
    @StateObject var viewModel = PostsViewModel()
    @State private var showNewPostForm = false

    @State private var searchText = ""
 
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                if searchText.isEmpty || post.contains(searchText) {
                    PostRow(post: post)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Posts")
            .toolbar {
                Button {
                    showNewPostForm = true
                } label: {
                    Label("New Post", systemImage: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showNewPostForm) {
            NewPostForm(createAction: viewModel.makeCreateAction())
        }
    }
    
}
