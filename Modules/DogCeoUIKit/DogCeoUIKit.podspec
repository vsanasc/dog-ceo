Pod::Spec.new do |spec|
  spec.name           = "DogCeoUIKit"
  spec.version        = "0.0.1"
  spec.source_files   = "DogCeoUIKit/**/*.{h,m,swift}"
  spec.summary        = "A short description of DogCeoUIKit."
  spec.swift_version  = "5.3"
  spec.ios.deployment_target  = "13.0"

  spec.dependency "DogCeoCommons"

  spec.ios.framework  = "UIKit"

  spec.license      = "MIT"
  spec.homepage     = "https://github.com/vsanasc/dog-ceo/blob/master/README.md"
  spec.author       = { "Vitor S. do Nascimento" => "vsantos.nasc@gmail.com" }
  spec.source       = { :git => "https://github.com/vsanasc/dog-ceo.git", :tag => "#{spec.version}" }
end
