# NilTutorial

[![CI Status](http://img.shields.io/travis/nil-biribiri/NilTutorial.svg?style=flat)](https://travis-ci.org/nil-biribiri/NilTutorial)
[![Version](https://img.shields.io/cocoapods/v/NilTutorial.svg?style=flat)](http://cocoapods.org/pods/NilTutorial)
[![License](https://img.shields.io/cocoapods/l/NilTutorial.svg?style=flat)](http://cocoapods.org/pods/NilTutorial)
[![Platform](https://img.shields.io/cocoapods/p/NilTutorial.svg?style=flat)](http://cocoapods.org/pods/NilTutorial)

Create app tutorial view using UICollectionView

![Preview](https://thumbs.gfycat.com/HarmlessPoshBoa-size_restricted.gif)

## Requirements

iOS 8.0+

Xcode 8.3+

Swift 3.0+


## Installation

NilTutorial is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NilTutorial'
```

## Usages

Local images set
```swift
  let tutorialVC = NilTutorialViewController(imagesSet: []) {
            // Add action afer skip button pressed here
          !!!")
        }
```

Load images set from url (async)
```swift

let tutorialVC = NilTutorialViewController(imageURLSet: []) {
            // Add action afer skip button pressed here
           
        }

```

In AppDelegate
```swift

import NilTutorial

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        let tutorialVC = NilTutorialViewController(imagesSet: []) {
            // Add action afer skip button pressed here
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.window?.rootViewController = mainVC
        }
        self.window?.rootViewController = tutorialVC
        
        return true
    }
```

Present new TutorialVC

![Preview](https://thumbs.gfycat.com/FloweryOrderlyDoe-size_restricted.gif)

```swift
import NilTutorial

let appTutorialVC = NilTutorialViewController(imagesSet: []) {
            // Add skip button action here
}
        self.present(appTutorialVC, animated: true, completion: nil)
```

Add TutorialVC into SubView

![Preview](https://thumbs.gfycat.com/RewardingWillingDeer-size_restricted.gif)

```swift
let tutorialVC = NilTutorialViewController(imagesSet: []) {
            // Add action afer skip button pressed here
            print("Skip Button Pressed!!!")
            
            // Remove all child VC
            self.removeAllChildViewController()
            self.subView.removeAllSubViews()
        }
        
        self.configureChildViewController(childController: tutorialVC, onView: self.subView, withFadeAnimate: true)      
```

## Customization

```swift
        // Set Skip button title
        tutorialVC.setSkipButtonTitle(title: )
        
        // Set image aspect 
        tutorialVC.setImageAspect(imageAspect: )

```


## Author

NilNilNil, nilc.nolan@gmail.com

## License

NilTutorial is available under the MIT license. See the LICENSE file for more info.
