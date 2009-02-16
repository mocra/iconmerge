require "rubygems"
require "rake"

require "choctop"

ChocTop.new do |s|
  # Remote upload target
  s.remote_dir = '/opt/apps/mocra/shared/project_downloads/iconmerge'

  # Custom DMG
  s.background_file = "dmgbackground.png"
  s.app_icon_position = [150, 160]
  s.applications_icon_position =  [469, 160]
  s.icon_text_size = 14
  s.applications_icon =  "appicon.icns"
  s.volume_icon = "dmgicon.icns"
end
