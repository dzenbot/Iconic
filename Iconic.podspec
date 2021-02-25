@version                      = '1.5'

Pod::Spec.new do |s|
  s.name                      = 'Iconic'
  s.version                   = @version
  s.summary                   = 'Auto-generated icon font library for iOS'
  s.description               = 'Iconic will help you make icon fonts integration on iOS easy and effortless. Its main component is in charge of auto-generating strongly typed code in Swift, fully compatible with Objective-C, allowing the integration of vector icons as image or text in your apps.'

  s.homepage                  = 'https://github.com/home-assistant/Iconic'
  s.author                    = { 'Ignacio Romero Zurbuchen' => 'iromero@dzen.cl', 'Robbie Trencheny' => 'me@robbiet.us', 'The Home Assistant Authors' => 'hello@home-assistant.io' }

  s.license                   = { :type => 'Apache 2.0', :file => 'LICENSE.md' }

  s.social_media_url          = 'https://twitter.com/hass_devs'

  s.source                    = { :git => 'https://github.com/home-assistant/Iconic.git', :tag => @version }

  s.source_files              = 'Source/*.{swift}'
  s.resources                 = 'Source/**/*.{ttf,otf}'
  s.preserve_paths            = 'Source/*'
  s.framework                 = 'UIKit', 'CoreText'

  s.ios.deployment_target     = '8.0'
  s.tvos.deployment_target    = '9.0'
  s.watchos.deployment_target = '2.0'

  s.swift_version             = '5.0'

  s.prepare_command           = "sh Source/Iconizer.sh"
end
