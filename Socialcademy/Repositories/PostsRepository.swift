

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


#if DEBUG
struct PostsRepositoryStub: PostsRepositoryProtocol {
    func delete(_ post: Post) async throws {}
    
    let state: Loadable<[Post]>
 
    func fetchPosts() async throws -> [Post] {
        return try await state.simulate()
    }
 
    func create(_ post: Post) async throws {}
}
#endif
protocol PostsRepositoryProtocol {
    func delete(_ post: Post) async throws
    func fetchPosts() async throws -> [Post]
    func create(_ post: Post) async throws
}
struct PostsRepository: PostsRepositoryProtocol {
    func delete(_ post: Post) async throws {
        let document = PostsRepository.postsReference.document(post.id.uuidString)
        try await document.delete()
    }
    static let postsReference = Firestore.firestore().collection("posts")
    
    func create(_ post: Post) async throws {
        let document = PostsRepository.postsReference.document(post.id.uuidString)
        try await document.setData(from: post)
    }
    
    func fetchPosts() async throws -> [Post] {
        let snapshot = try await PostsRepository.postsReference
            .order(by: "timestamp", descending: true)
            .getDocuments()
        return snapshot.documents.compactMap { document in
            try! document.data(as: Post.self)
        }
    }
    
    
}

private extension DocumentReference {
    func setData<T: Encodable>(from value: T) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            // Method only throws if there’s an encoding error, which indicates a problem with our model.
            // We handled this with a force try, while all other errors are passed to the completion handler.
            try! setData(from: value) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume()
            }
        }
    }
}
