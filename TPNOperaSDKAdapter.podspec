Pod::Spec.new do |spec|
  # ―――  基本信息  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name         = "TPNOperaSDKAdapter"
  spec.version      = "6.4.93.2"
  spec.summary      = "Opera Ads Adapter for TopOn (AnyThink) Mediation."

  spec.description  = <<-DESC
    TPNOperaSDKAdapter is a custom adapter that enables the integration of Opera Ads 
    via the TopOn (AnyThink) mediation platform. 
    It allows publishers to maximize revenue by including Opera's demand in their TopOn waterfall.
  DESC

  spec.homepage     = "https://github.com/operaads/TPNOperaSDKAdapter"
  spec.license      = { :type => "Commercial", :file => "LICENSE" }
  spec.author       = { "opera" => "chenl@opera.com" }

  # ―――  平台设置  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform     = :ios, "13.0" 
  spec.swift_version = "5.0"

  # ―――  源码位置  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source = { 
      :git => "https://github.com/operaads/TPNOperaSDKAdapter.git", 
      :tag => "#{spec.version}" 
  }

  # ―――  文件配置  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.vendored_frameworks = "OpAdxAdapterTopon.xcframework"
  spec.static_framework = true

  
  spec.dependency 'TPNiOS','6.4.93'
  
  spec.dependency 'OpAdxSdk', '~> 2.2.10'    


  # ―――  工程配置  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }

end