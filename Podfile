# The use of implicit sources has been deprecated.
source 'https://github.com/CocoaPods/Specs.git'

# ignore all warnings from all pods
inhibit_all_warnings!

# Use frameworks instead of static libraries for Pods.
use_frameworks!

platform :ios, ’12.0’

def all_pods
    #Networking
    pod 'Alamofire'
    pod 'ObjectMapper'
    pod 'Firebase/Auth'
    
    #Photo
    pod 'Kingfisher'

    #Tools
    pod 'SVProgressHUD'
    pod 'IQKeyboardManagerSwift'
    pod 'SkyFloatingLabelTextField'
    
    #Menu
    pod 'LGSideMenuController'

end

target ‘GitInfo’ do
    all_pods
end

target 'GitInfoUITests' do
  all_pods
end
