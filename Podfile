# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# Since we may have mulitple targets in which we may want to use same pods, defining common_pods below -
def common_pods
    pod 'SDWebImage', '5.1'
end

target 'DubizzleApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DubizzleApp
  common_pods
  
  target 'DubizzleAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DubizzleAppUITests' do
    # Pods for testing
  end

end
