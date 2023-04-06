//
//  Post.swift
//  Socialcademy
//
//  Created by Ilya on 04.04.2023.
//

import Foundation

struct Post: Identifiable {
    var id = UUID()
    
    var title: String
    var content: String
    var authorName: String
    var timestamp = Date()
    
    func contains(_ string: String) -> Bool {
        let properties = [title, content, authorName].map { $0.lowercased() }
        let query = string.lowercased()
     
        let matches = properties.filter { $0.contains(query) }
        return !matches.isEmpty
    }
    //case sensitive
    
}


extension Post {
    static let testPost = Post(
        title: "Lorem ipsum",
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        authorName: "Jamie Harris"
    )
    
    
}
//test data
