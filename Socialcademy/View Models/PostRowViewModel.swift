//
//  PostRowViewModel.swift
//  Socialcademy
//
//  Created by Ilya on 07.04.2023.
//

import Foundation
@MainActor
@dynamicMemberLookup
class PostRowViewModel: ObservableObject {
    typealias Action = () async throws -> Void
 
    @Published var post: Post
    @Published var error: Error?
 
    private let deleteAction: Action
    private let favoriteAction: Action
    subscript<T>(dynamicMember keyPath: KeyPath<Post, T>) -> T {
        post[keyPath: keyPath]
    }
    init(post: Post, deleteAction: @escaping Action, favoriteAction: @escaping Action) {
        self.post = post
        self.deleteAction = deleteAction
        self.favoriteAction = favoriteAction
    }
    
    private func withErrorHandlingTask(perform action: @escaping Action) {
        Task {
            do {
                try await action()
            } catch {
                print("[PostRowViewModel] Error: \(error)")
                self.error = error
            }
        }
    }
    
    
    func deletePost() {
        withErrorHandlingTask(perform: deleteAction)
    }
     
    func favoritePost() {
        withErrorHandlingTask(perform: favoriteAction)
    }
    
    
}
