//
//  SceneDelegate.swift
//  ChatMSG
//
//  Created by Julia on 2023/04/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let mainVC = MessageListViewController()
        mainVC.view.backgroundColor = .systemBackground
        let naviVC = UINavigationController(rootViewController: mainVC)
        naviVC.navigationBar.tintColor = .orange
        window.rootViewController = naviVC
        window.makeKeyAndVisible()
    }


}

