//
//  MainTabView.swift
//  Socialcademy
//
//  Created by Ilya on 08.04.2023.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            PostsList()
                .tabItem {
                    Label("Posts", systemImage: "list.dash")
                }
            PostsList(viewModel: PostsViewModel(filter: .favorites))
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}
