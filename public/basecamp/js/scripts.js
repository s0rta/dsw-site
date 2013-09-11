/*------------------------------------*\
    //Google Maps
\*------------------------------------*/
function initialize() {


    var theLatlng = new google.maps.LatLng(39.749222, -104.997152);
    var mapOptions = {
        zoom: 17,
        center: theLatlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        scrollwheel: false
    }
    var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    var marker = new google.maps.Marker({
        position: theLatlng,
        map: map,
        title:"Hello World!"
    });
    google.maps.event.addDomListener(window, 'resize', function() {
        map.setCenter(theLatlng);
    });
}
google.maps.event.addDomListener(window, 'load', initialize);
