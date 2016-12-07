# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "scoped_hash"
  spec.version       = "0.1.0"
  spec.authors       = ["Houcheng Lin"]
  spec.email         = ["houcheng@gmail.com"]

  spec.summary       = %q{Scoped Hash provides scoped access to hash structure}
  spec.homepage      = %q{https://github.com/houcheng/scoped_hash}
  spec.license       = ""

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ["lib"]

  # develop dependency
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"

  # runtime dependency
  spec.add_runtime_dependency "mash"
end
