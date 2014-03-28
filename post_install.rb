post_install do |installer_representation|
  installer_representation.project.targets.each do |target|
    if target.name == "Pods-TweaksBuildConfigurationsDemo-Tweaks"
      target.build_configurations.each do |config|
        if config.name != 'Release' && config.name != 'Debug'
          # Linking still fails with these values
          #
          # config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'DEBUG=0']
          # config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'FB_TWEAK_ENABLED=0']

          # Linking succeeds with these values
          #
          # config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'DEBUG=1']
          config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'FB_TWEAK_ENABLED=1']
        end
      end
    end
  end
end