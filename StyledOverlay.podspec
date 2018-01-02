Pod::Spec.new do |s|
  s.name             = 'StyledOverlay'
  s.version          = '3.2'
  s.license          = 'MIT'
  s.summary          = 'StyledOverlay is a UIView with styling options and preset action overlays'
  s.homepage         = 'https://github.com/Rehsco/StyledOverlay.git'
  s.authors          = { 'Martin Jacob Rehder' => 'gitrepocon01@rehsco.com' }
  s.source           = { :git => 'https://github.com/Rehsco/StyledOverlay.git', :tag => s.version }
  s.ios.deployment_target = '10.0'

  s.dependency 'StyledLabel'
  s.dependency 'MJRFlexStyleComponents'
  
  s.framework    = 'UIKit'
  s.source_files = 'StyledOverlay/*.swift'
  s.resources    = 'StyledOverlay/**/*.xcassets'
  s.requires_arc = true
end
