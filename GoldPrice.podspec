Pod::Spec.new do |spec|
  spec.name = "GoldPrice"
  spec.version = "0.0.1"
  spec.summary = "Get realtime gold prices."
  spec.homepage = "https://pickaxe.nyc"
  spec.license = { type: 'Apache 2.0', file: 'LICENSE' }
  spec.authors = { "Mike Singleton" => 'mike@pickaxe.nyc' }
  spec.social_media_url = "http://twitter.com/msingleton"

  spec.platform = :ios, "11.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/msingleton/GoldPrice.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "GoldPrice/**/*.{h,swift}"

  spec.dependency "Curry", "~> 4.0.2"

  spec.swift_version = '4.2'
end