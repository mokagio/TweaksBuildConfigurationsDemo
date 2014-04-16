platform :ios, "6.0"

xcodeproj "TweaksBuildConfigurationsDemo.xcodeproj", { 'Beta' => :debug, 'QA' => :release }

target "TweaksBuildConfigurationsDemo" do
  pod 'Tweaks', '1.0.0'
end

target "TweaksBuildConfigurationsDemoTests" do

end

post_install do |installer_representation|
  installer_representation.project.targets.each do |target|
    if target.name == "Pods-TweaksBuildConfigurationsDemo-Tweaks"
      target.build_configurations.each do |config|
        if config.name == 'QA'
          config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'FB_TWEAK_ENABLED=1']
        end
      end
    end
  end
end