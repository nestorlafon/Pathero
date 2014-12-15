Pod::Spec.new do |s|
  s.name             = "Pathero"
  s.version          = "0.1.1"
  s.summary          = "A helper for creating URL path strings"
  s.description      = <<-DESC
			Pather is a helper to create URL path string.

			It uses blocks to provide a nice chainable funcition syntax, I made it for myself
			but it really made my code nicer and I wanted to share it.
                       DESC
  s.homepage         = "https://github.com/nextorlg/Pathero"
  s.license          = 'MIT'
  s.author           = { "Nestor Lafon-Gracia" => "nestor.lafon@gmail.com" }
  s.source           = { :git => "https://github.com/nextorlg/Pathero.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/nestorlafon'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'Pathero' => ['Pod/Assets/*.png']
  }
end
