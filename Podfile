target 'BestBuyCatalog' do
	use_frameworks!

  	pod 'Alamofire', '~> 4.0'
	pod 'AlamofireImage', '~> 3.1'

	target 'BestBuyCatalogTests' do
		inherit! :search_paths
	end

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
end
