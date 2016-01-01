#platform :ios, '9.0'

xcodeproj '/Volumes/TeklabsMHD1/Repos/ActionButtonApp/ActionButtonApp.xcodeproj'

#def common_pods
    
    
target 'ActionButtonApp' do

use_frameworks!
  pod 'Parse'
  pod 'ParseUI'
  pod 'ParseFacebookUtilsV4'
  pod 'ParseTwitterUtils'
  pod 'FBSDKCoreKit'
  pod 'FBSDKLoginKit'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'TwitterKit'
  pod 'TwitterCore'

#pod 'ParseCrashReporting', '~> 1.7.5'

  # Workaround for the unknown crashes Bolts (https://github.com/BoltsFramework/Bolts-iOS/issues/102)
  #pod 'Bolts', :git => https://github.com/teklabs/Bolts-iOS.git
  #pod 'ParseUI', '1.1.4'
  pod 'MBProgressHUD'
  pod 'FormatterKit'
  pod 'SDWebImage'
  pod 'RealmSwift'
  pod 'AMWaveTransition'
  pod 'pop'
  pod 'UIImageAFAdditions', :git => 'https://github.com/teklabs/UIImageAFAdditions.git'

  pod 'Synchronized'

  pod 'IOStickyHeader'
  pod 'AHKActionSheet', '~> 0.5'
  pod 'AMPopTip', '~> 0.7'
  pod 'ActionButton', git: 'https://github.com/teklabs/ActionButton.git', branch: 'master'
  pod 'PathMenu', git: 'https://github.com/teklabs/PathMenu.git', branch: 'master'
end


#target 'ActionButtonApp' do
#  use_frameworks!
#  common_pods
#end

#inhibit_all_warnings!
#use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end