Pod::Spec.new do |spec|
  spec.name         = "DogCeoCore"
  spec.version      = "0.0.1"
  spec.source_files  = "DogCeoCore/**/*.{h,m,swift}"
  spec.summary        = "A short description of DogCeoCore."
  spec.swift_version  = "5.3"
  spec.ios.deployment_target  = "13.0"

  spec.dependency "DogCeoCommons"
  spec.dependency "DogCeoUIKit"
  spec.dependency "DogCeoDashboard"

  spec.license      = "MIT"
  spec.homepage     = "https://github.com/vsanasc/dog-ceo/blob/master/README.md"
  spec.author       = { "Vitor S. do Nascimento" => "vsantos.nasc@gmail.com" }
  spec.source       = { :git => "https://github.com/vsanasc/dog-ceo.git", :tag => "#{spec.version}" }
end
