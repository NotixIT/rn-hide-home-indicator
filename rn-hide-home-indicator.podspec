require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "rn-hide-home-indicator"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = "https://github.com/notix/rn-hide-home-indicator"
  s.license      = package["license"]
  s.authors      = package["author"]
  s.platforms    = { :ios => min_ios_version_supported }
  s.source       = { :git => "https://github.com/notix/rn-hide-home-indicator.git", :tag => "#{s.version}" }
  s.source_files = "ios/**/*.{h,m,mm}"

  if respond_to?(:install_modules_dependencies, true)
    install_modules_dependencies(s)
  else
    s.dependency "React-Core"
  end
end
