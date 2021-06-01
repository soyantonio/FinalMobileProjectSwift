//
//  FinalMobileProjectSwiftApp.swift
//  FinalMobileProjectSwift
//
//  Created by Jesús Antonio Pérez Reyes on 01/06/21.
//
//

import SwiftUI
import Firebase

@main
struct FinalMobileProjectSwiftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}