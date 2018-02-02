#
# Be sure to run `pod lib lint NilTutorial.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NilTutorial'
  s.version          = '0.2.7'
  s.summary          = 'Create app tutorial view using UICollectionView'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the poit.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'App tutorial lib using UICollectionView writing in Swift 3.0.'

  s.homepage         = 'https://github.com/nil-biribiri/NilTutorial'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NilNilNil' => 'nilc.nolan@gmail.com' }
  s.source           = { :git => 'https://github.com/nil-biribiri/NilTutorial.git', :branch => "master", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'NilTutorial/Classes/*'
  
  # s.resource_bundles = {
  #   'NilTutorial' => ['NilTutorial/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
