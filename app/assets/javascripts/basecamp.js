//= require_self
//= require ./basecamp/jquery.fancybox
//= require ./basecamp/jquery.flexslider

// Enable the visual refresh
google.maps.visualRefresh = true;

function initialize() {
	var center = new google.maps.LatLng(39.747233, -104.996333);
	var mapOptions = {
		zoom: 16,
		minZoom: 3,
		zoomControl: true,
		scrollwheel: false,
		center: center,
		mapTypeControl: false,
	};
  
  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

	var infoString = '<div class="infowindow">' +
        '<h3>Basecamp</h3>' +
        '<div class="infowindow-content">' +
        '<p>1515 Arapahoe St. Denver, CO <br> (corner of Arapahoe and 16th St. Mall)</p>' +
        '</div>' +
        '</div>';
    var infoWindow = new google.maps.InfoWindow({
        content: infoString
    });

	marker = new google.maps.Marker({
		map: map,
		animation: google.maps.Animation.DROP,
		position: center
	});
	google.maps.event.addListener(marker, 'click', function () {
		infoWindow.open(map, marker);
	});
	
	google.maps.event.addDomListener(window, "resize", function() {
		map.setCenter(center); 
	});
}

google.maps.event.addDomListener(window, 'load', initialize);


$(function(){
	$('.flexslider').flexslider({
		animation: "slide",
         animationLoop: false,
         itemWidth: 140,
         itemMargin: 0,
         minItems: 6,
         maxItems: 6,
         controlNav: false,
         slideshow: false
	});
	$('.fancybox').fancybox({
		padding:0,
		helpers: {
		    overlay: {
		      locked: false
		    }
		}
	});
});


