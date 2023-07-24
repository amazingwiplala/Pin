//
//  ViewController.swift
//  Pin
//
//  Created by Jeanine Chuang on 2023/7/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            
            //偵測目前使用者點選了哪一個Tab
            let tabbarIndex = tabBarController.viewControllers!.firstIndex(of: viewController)!
            
            //偵測目前畫面上停留的是哪一個View
            let getCurrentView = tabBarController.selectedViewController!.view!
            
            //remove subviews
            //檢查目前是不是已經有毛玻璃View和“建立View"，若有的話要先移除，不然會產生千千萬萬個View
            //程式產生"建立View"時，已指定View.Tag＝999，因此可以透過viewWithTag的function找到它
            if let viewWithTag = getCurrentView.viewWithTag(999)  {
                //將"建立View"移除
                viewWithTag.removeFromSuperview()
            }
            
            //程式產生毛玻璃View時，已指定View.Tag＝998，因此可以透過viewWithTag的function找到它
            if let maskWithTag = getCurrentView.viewWithTag(998)  {
                //將毛玻璃View移除
                maskWithTag.removeFromSuperview()
            }
        
            //如果使用者點選“建立Tab”
            if  tabbarIndex == 2 {
                    
                //---- 毛玻璃View ----//
                //設定毛玻璃效果
                let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
                
                //產生一個新的view，加上毛玻璃效果
                let blurView = UIVisualEffectView(effect: blurEffect)
                
                //給毛玻璃View加個標籤，之後需要透過Tag找到它
                blurView.tag = 998
                
                //指定View在螢幕上的座標和長寬尺寸
                //毛玻璃要蓋住整個View，所以直接取用目前的尺寸
                blurView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                
                //在目前顯示的View上面，加一層新的View
                getCurrentView.addSubview(blurView)
                    
                //---- "建立View" ----
                //直接把透過Storyboard繪製的View作為"建立View"
                //預先在Storyboard的Identity面板設定View的Id="MyView"
                //利用Id找到已繪製好的View
                let myview =  storyboard!.instantiateViewController(withIdentifier: "MyView").view
                
                //給"建立View"加個標籤，之後需要透過Tag找到它
                myview?.tag = 999
                
                //指定View在螢幕上的座標和長寬尺寸
                //View是在螢幕的下方，高度300，因此Y座標可以利用上一層View的高度-300計算而得
                myview?.frame = CGRectMake(0, self.view.frame.size.height-300, self.view.frame.size.width, 300);
                
                //在目前顯示的View上面，加一層新的View
                getCurrentView.addSubview(myview!)
                
                //確保"建立View"蓋在所有View的最上方
                getCurrentView.bringSubviewToFront(myview!)
                    
                return false
                    
            } else {
                    
                return true
            }
    }
}



