require 'dbus'
require 'rubygems'
require 'rest_fs/client'

r=RestFs::Client.new
bus = DBus::SessionBus.instance
service = bus.service("org.gnome.SettingsDaemon")
object = service.object("/org/gnome/SettingsDaemon/MediaKeys")
object.introspect
object.default_iface = "org.gnome.SettingsDaemon.MediaKeys"
url="/sensors/icomx-platform:last"
object.on_signal("MediaPlayerKeyPressed") do |u,v|
    if v=="Previous"
      puts("Button 1")
      r.update!(url,"1")
    elsif v=="Play" or v=="Pause" 
      puts("Button 2")
      r.update!(url,"2")
    elsif v=="Next"
      puts("Button 3")
      r.update!(url,"3")
    end
end

loop = DBus::Main.new
loop << bus
loop.run
