Pod::Spec.new do |spec|
  spec.name           = "DogCeoCommons"
  spec.version        = "0.0.1"
  spec.source_files   = "DogCeoCommons/**/*.{h,m,swift}"
  spec.summary        = "A short description of DogCeoCommons."
  spec.swift_version  = "5.3"
  spec.ios.deployment_target  = "13.0"

  spec.license      = "MIT"
  spec.homepage     = "https://github.com/vsanasc/dog-ceo/blob/master/README.md"
  spec.author       = { "Vitor S. do Nascimento" => "vsantos.nasc@gmail.com" }
  spec.source       = { :git => "https://github.com/vsanasc/dog-ceo.git", :tag => "#{spec.version}" }
end
