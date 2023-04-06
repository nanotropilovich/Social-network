//
//  SocialcademyApp.swift
//  Socialcademy
//
//  Created by Ilya on 04.04.2023.
//

import SwiftUI
import Firebase
 
@main
struct SocialcademyApp: App {
    init() {
        FirebaseApp.configure()
    }
 
    var body: some Scene {
        WindowGroup {
            PostsList()
        }
    }
}
