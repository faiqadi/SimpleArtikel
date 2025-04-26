# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ArticleMiniProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ArticleMiniProject

  target 'ArticleMiniProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ArticleMiniProjectUITests' do
    # Pods for testing
  end
pod 'Alamofire'
pod 'Auth0'
pod 'GIFImageView'
pod 'IQKeyboardManagerSwift'
pod 'JWTDecode'
pod 'KeychainSwift'
pod 'Kingfisher'
pod 'ObjectMapper'
pod 'PasswordTextField'
pod 'SnapKit'
pod 'RxSwift'
pod 'RxCocoa'

end
post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
