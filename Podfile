# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def app_pods
  
  pod 'Alamofire',                                        '5.4.0'
  pod 'AlamofireNetworkActivityLogger',                   '~> 3.4.0'
  
  pod 'CocoaLumberjack/Swift',                            '3.7.4'
  
  pod 'Kingfisher',                                       '~> 7.0'
  
  pod 'NSObject+Rx'
  
  pod 'Reusable',                                         '4.1.2'
  pod 'R.swift',                                          '6.1.0'
  pod 'RxCocoa',                                          '6.5.0'
  pod 'RxSwift',                                          '6.5.0'
  
  pod 'SwiftyJSON',                                       '~> 4.0'
  pod 'SVProgressHUD',                                    '2.2.5'
end

target 'RandomMe' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RandomMe
  app_pods

  target 'RandomMeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RandomMeUITests' do
    # Pods for testing
  end

end
