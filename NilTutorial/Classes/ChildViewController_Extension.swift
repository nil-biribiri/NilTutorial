//
//  ChildViewController_Extension.swift
//  Pods
//
//  Created by Tanasak Ngerniam on 9/13/2560 BE.
//
//

public extension UIView {
    
    func removeAllSubViews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
}

public extension UIViewController {
    
    func removeAllChildViewController() {
        self.childViewControllers.forEach({ $0.removeFromParentViewController()})
    }
    
    func configureChildViewController(childController: UIViewController, onView: UIView?, withFadeAnimate: Bool = true, animateDuration: Double? = 0.2) {
        
        weak var holderView = self.view
        
        let duration = animateDuration ?? 0.2
        
        if let onView = onView {
            holderView = onView
        }
        addChildViewController(childController)
        
        if(withFadeAnimate){
            childController.view.alpha = 0.0
            holderView?.addSubview(childController.view)
            UIView.animate(withDuration: duration, animations: { childController.view.alpha = 1.0 })
        }else{
            holderView?.addSubview(childController.view)
        }
        
        constrainViewEqual(holderView: holderView!, view: childController.view)
        childController.didMove(toParentViewController: self)
        
        
    }
    
    
    func constrainViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        //pin 100 points from the top of the super
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                        toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                           toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                         toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                          toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
        
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
    
}
