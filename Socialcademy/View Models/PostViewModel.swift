//
//  PostViewModel.swift
//  Socialcademy
//
//  Created by Ilya on 04.04.2023.
//

import Foundation


@MainActor
class PostsViewModel: ObservableObject {
    @Published var posts = [Post.testPost]
    func makeCreateAction() -> NewPostForm.CreateAction {
        return { [weak self] post in
            self?.posts.insert(post, at: 0)
        }
    }
}
