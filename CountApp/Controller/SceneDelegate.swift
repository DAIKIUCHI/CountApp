//
//  SceneDelegate.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/07/03.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let targetViewController: String = "RegisterViewController"

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else {
            return
        }

//        print(UserDefaults.standard.object(forKey: "saveContent") as Any)
        print("-----------目標-------------")
        print(UserDefaults.standard.object(forKey: "target") as Any)
        print("-----------回数-------------")
        print(UserDefaults.standard.object(forKey: "count") as Any)
        
        //目標が入っていない時は目標設定画面から表示させる
        if UserDefaults.standard.object(forKey: "target") == nil {
            changeRootView()
        }

    }
    
     /// ルートViewの変更
     func changeRootView() {
        //利用するストーリーボードを指定
        let storyboard: UIStoryboard =  UIStoryboard(name: "Main",bundle:nil)
        // storyboard ID で遷移先コントローラーを変更(ナビゲーションコントローラー使ってない場合)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: targetViewController) as UIViewController
        
        let _: UINavigationController = self.window?.rootViewController as! UINavigationController
        window?.rootViewController = viewController
        // 表示
//        self.window?.makeKeyAndVisible()
    }
    
//     /// ルートViewの変更
//     func changeRootView() {
//        //利用するストーリーボードを指定
//        let storyboard:UIStoryboard =  UIStoryboard(name: "Main",bundle:nil)
//
//
//        // storyboard ID で遷移先コントローラーを変更(ナビゲーションコントローラー使っている場合)
//        let viewController : UIViewController = storyboard.instantiateViewController(withIdentifier: targetViewController) as UIViewController
//
//        let navigationController: UINavigationController = self.window!.rootViewController as! UINavigationController
//
//        navigationController.pushViewController(viewController, animated: false)
//    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        
        
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    


}

