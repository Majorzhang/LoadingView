Pod::Spec.new do |s|
s.name      = "JZLoading"
s.version   = "0.0.1"
s.summary   = "Loading Loading"
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.homepage  = "https://github.com/Majorzhang"
s.author    = "Jun Zhang"
s.platform  = :ios, "10.0"
s.cocoapods_version = '>= 1.4'
s.swift_version = "4.2"


# ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.source    = { :git => "https://github.com/Majorzhang/LoadingView.git", :branch => 'master' }

# ――― Dependencies ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #``



# ――― Contents ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.source_files = 'LoadingView/**/*.swift'

end
