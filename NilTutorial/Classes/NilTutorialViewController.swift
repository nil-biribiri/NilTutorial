//
//  NilTutorialViewController.swift
//  NilPageView
//
//  Created by Tanasak Ngerniam on 9/11/2560 BE.
//  Copyright © 2560 NilNolan. All rights reserved.
//

import UIKit

public final class NilTutorialViewController: UIViewController {
    
    fileprivate var completion:(() -> ())? = nil
    fileprivate var imagesSet:[UIImage]?
    fileprivate var imageURLSet:[String]? 
    fileprivate var imageViewAspect:UIViewContentMode = UIViewContentMode.scaleAspectFill
    fileprivate var skipButtonTextColor:UIColor = UIColor.white
    fileprivate var skipButtonTitle:String = "Skip"
    fileprivate var skipButtonIsHide:Bool = false
    
    @IBOutlet fileprivate weak var skipButton:UIButton!{
        didSet{
            skipButton.setTitleColor(self.skipButtonTextColor, for: .normal)
            skipButton.setTitle(self.skipButtonTitle, for: .normal)
            skipButton.isHidden = self.skipButtonIsHide
        }
    }
    
    @IBOutlet fileprivate weak var collectionView:UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            let bundle = Bundle(for: NilTutorialViewController.self)
            
            let nibName = UINib(nibName: TutorialCollectionViewCell.cellIdentifier, bundle:bundle)
            collectionView.register(nibName, forCellWithReuseIdentifier: TutorialCollectionViewCell.cellIdentifier)
        }
    }
    
    @IBOutlet fileprivate weak var pageControl:UIPageControl!{
        didSet{
            pageControl.hidesForSinglePage = true
            pageControl.numberOfPages = self.imagesSet?.count ?? self.imageURLSet?.count ?? 0
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override public var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
    }
    
    deinit {
        print("\(String(describing: NilTutorialViewController.self)): deinit")
    }
    
    public convenience init(imagesSet: [UIImage]?, completion: @escaping () -> () ) {
        let bundle = Bundle(for: NilTutorialViewController.self)
        self.init(nibName: "NilTutorialViewController", bundle: bundle)
        
        self.imagesSet = imagesSet
        self.completion = completion
    }
    
    public convenience init(imageURLSet: [String]?, completion: @escaping () -> () ){
        let bundle = Bundle(for: NilTutorialViewController.self)
        self.init(nibName: "NilTutorialViewController", bundle: bundle)
        
        self.imageURLSet = imageURLSet
        self.completion = completion

    }
    
    public func hideSkipButton(){
        self.skipButtonIsHide = true
    }
    
    public func showSkipButton(){
        self.skipButtonIsHide = false
    }
    
    public func setSkipButtonTextColor(textColor:UIColor){
        self.skipButtonTextColor = textColor
    }
    
    public func setSkipButtonTitle(title:String){
        self.skipButtonTitle = title
    }
    
    public func setImageAspect(imageAspect: UIViewContentMode) {
        self.imageViewAspect = imageAspect
    }
    
    @IBAction func skipButtonDidPress(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        if (self.completion != nil) {
            self.completion!()
        }
        
    }
}

extension NilTutorialViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:TutorialCollectionViewCell.cellIdentifier, for: indexPath) as? TutorialCollectionViewCell {
            
            if let image = self.imagesSet?[indexPath.row]{
                cell.imageView.contentMode = self.imageViewAspect
                cell.imageView.image = image
                return cell
            }else if let imageURL = self.imageURLSet?[indexPath.row]{
                cell.imageView.downloadedFrom(link: imageURL, contentMode: self.imageViewAspect)
                return cell
            }
            
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesSet?.count ?? self.imageURLSet?.count ?? 0
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let lastCell = collectionView.visibleCells.last{
            pageControl.currentPage = (collectionView.indexPath(for: lastCell)?.row)!
        }
    }
}

extension NilTutorialViewController: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
