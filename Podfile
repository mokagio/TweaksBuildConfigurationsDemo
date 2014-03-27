platform :ios, "6.0"

main_target = "TweaksBuildConfigurationsDemo"

target main_target do
  pod 'Tweaks', '1.0.0'
end

target "#{main_target}Tests" do

end

post_install do |installer_representation|
  installer_representation.project.targets.each do |target|
    if target.name == "Pods-#{main_target}-Tweaks"
      target.build_configurations.each do |config|
        if config.name != 'Release' && config.name != 'Debug'
          # Linking still fails with these values
          #
          # config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'DEBUG=0']
          # config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'FB_TWEAK_ENABLED=0']

          # Linking succeds with these values
          #
          # config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'DEBUG=1']
          config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'FB_TWEAK_ENABLED=1']
        end
      end
    end
  end
end