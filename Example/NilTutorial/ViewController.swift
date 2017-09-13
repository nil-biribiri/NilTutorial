//
//  ViewController.swift
//  NilTutorial
//
//  Created by nilc.nolan@gmail.com on 09/13/2017.
//  Copyright (c) 2017 nilc.nolan@gmail.com. All rights reserved.
//

import UIKit
import NilTutorial

class ViewController: UIViewController {

    @IBOutlet weak var subView:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonAction(_ sender: Any) {
       
        let tutorialVC = NilTutorialViewController(imagesSet: [#imageLiteral(resourceName: "Invoker_1"),#imageLiteral(resourceName: "Invoker_2"),#imageLiteral(resourceName: "Invoker_3")]) {
            // Add action afer skip button pressed here
            print("Skip Button Pressed!!!")
        }
        self.present(tutorialVC, animated: true, completion: nil)
        
    }
    
    @IBAction func subViewButtonAction(_ sender: Any) {
        
        let tutorialVC = NilTutorialViewController(imagesSet: [#imageLiteral(resourceName: "Invoker_1"),#imageLiteral(resourceName: "Invoker_2"),#imageLiteral(resourceName: "Invoker_3")]) {
            // Add action afer skip button pressed here
            print("Skip Button Pressed!!!")
            
            // Remove all child VC
            self.removeAllChildViewController()
            self.subView.removeAllSubViews()
        }
        
        self.configureChildViewController(childController: tutorialVC, onView: self.subView, withFadeAnimate: true)
        
        
    }
    
}

