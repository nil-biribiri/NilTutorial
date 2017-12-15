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
    fileprivate var showSkipButtonOnlyLastPage:Bool = false
    fileprivate var skipButtonCGRect:CGRect?
    fileprivate var scrollTime:Double = 5.0
    fileprivate var autoScrollIsEnabled:Bool = false
    
    fileprivate var timer:Timer? = nil {
        willSet {
            timer?.invalidate()
        }
    }
    
    public var skipButton = UIButton()
    
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
        
        self.setupSkipButton()
        autoScrollIsEnabled ? setupScrollTimer() : ()
        
        // Do any additional setup after loading the view.
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)        
        timer?.invalidate()

    }
    
    @objc fileprivate func moveScreen() {
        guard self.imagesSet?.count ?? self.imageURLSet?.count ?? 0 > 0 else {
            return
        }
        var scrollPage = pageControl.currentPage
        if pageControl.currentPage + 1 == self.imagesSet?.count ?? self.imageURLSet?.count ?? 0{
            scrollPage = -1
        }
        scrollPage = scrollPage + 1
        self.collectionView.scrollToItem(at: IndexPath(item: scrollPage, section: 0), at: .right, animated: true)
    }
    
    fileprivate func setupScrollTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: self.scrollTime, target: self, selector: #selector(self.moveScreen), userInfo: nil, repeats: true)
        
    }
    
    fileprivate func setupSkipButton(){
        DispatchQueue.main.async {
            self.skipButton.frame = self.skipButtonCGRect ?? CGRect(x: self.view.frame.width - 70, y: 30, width: 60, height: 30)
        }
        skipButton.setTitleColor(self.skipButtonTextColor, for: .normal)
        skipButton.setTitle(self.skipButtonTitle, for: .normal)
        skipButton.titleLabel?.adjustsFontSizeToFitWidth = true
        skipButton.titleLabel?.lineBreakMode = .byClipping
        skipButton.isHidden = self.skipButtonIsHide
        skipButton.isHidden = self.showSkipButtonOnlyLastPage
        skipButton.addTarget(self, action: #selector(skipButtonDidPress), for: .touchUpInside)
        self.view.addSubview(skipButton)
        
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
    
    public func enableAutoScroll(){
        self.autoScrollIsEnabled = true
    }
    
    public func setAutoScrollTime(seconds autoScrollTime: Double){
        self.scrollTime = autoScrollTime
    }
    
    public func showSkipButtonLastPage(){
        self.showSkipButtonOnlyLastPage = true
    }
    
    public func setSkipButtonCGRect(cgRect: CGRect){
        self.skipButtonCGRect = cgRect
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
    
    @objc fileprivate func skipButtonDidPress() {
        
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
    
    
    public func scrollViewDidScroll(_ scrollView:UIScrollView) {
        let midX:CGFloat = scrollView.bounds.midX
        let midY:CGFloat = scrollView.bounds.midY
        let point:CGPoint = CGPoint(x:midX, y:midY)
        
        guard
            let indexPath:IndexPath = collectionView.indexPathForItem(at:point)
            else{ return }
        if self.showSkipButtonOnlyLastPage{
            if indexPath.row == ((self.imagesSet?.count ?? self.imageURLSet?.count ?? 0) - 1 ){
                self.skipButton.isHidden = false
            }else{
                self.skipButton.isHidden = true
            }
        }else{
            self.skipButtonIsHide ? (self.skipButton.isHidden = true) : (self.skipButton.isHidden = false)
        }
        
        pageControl.currentPage = indexPath.row
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
