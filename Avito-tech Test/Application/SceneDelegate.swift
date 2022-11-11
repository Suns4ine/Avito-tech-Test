//
//  SceneDelegate.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 10.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let container = MainContainer.assemble(with: .init())
        let controller = container.viewController
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: controller)
        controller.navigationController?.setNavigationBarHidden(true, animated: false)
        window?.makeKeyAndVisible()
    }
}

