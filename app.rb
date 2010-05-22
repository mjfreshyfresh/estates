require 'rubygems'
require 'sinatra'
require 'cgi'
require 'estate'

get '/' do
  @estates = Estate.portland
  erb :map
end

__END__

@@ layout
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>Estate Sales near MJ</title>
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAzr2EBOXUKnm_jVnk0OJI7xSosDVG8KKPE1-m51RBrvYughuyMxQ-i1QfUnH94QxWIa6N4U6MouMmBA"
            type="text/javascript"></script>
    <%= yield %>
  </head>

  <body onload="initialize()" onunload="GUnload()">
    <div align="center">    
      <div id="map_canvas" style="width: 650px; height: 450px;"></div>
    </div>      
  </body>
</html>

@@ map
<script type="text/javascript">

var map = null;

function initialize() {
  if (GBrowserIsCompatible()) {
    var map = new GMap2(document.getElementById("map_canvas"));
    map.addControl(new GLargeMapControl());
    map.addControl(new GMapTypeControl());
    map.addControl(new GScaleControl());    
    map.setCenter(new GLatLng(45.532415,  -122.666130), 12);

    var geocoder = new GClientGeocoder();
    <% @estates.each do |estate| %>
      showAddress(map, geocoder, '<%= CGI::unescape(estate) %>');
    <% end %>
  }
}

function showAddress(map, geocoder, address) {
  geocoder.getLatLng(
    address,
    function(point) {
      if (!point) {
        console.log("Fail:" + address);
      } else {
        var marker = new GMarker(point, {'title': address});
        map.addOverlay(marker);
      }
    }
  );
}
</script>