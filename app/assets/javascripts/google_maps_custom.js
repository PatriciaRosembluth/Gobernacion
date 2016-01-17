function gmap_show(project) {
    if ((project.latitude == null) || (project.longitude == null) ) {
        return 0;
    }

    handler = Gmaps.build('Google');
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        markers = handler.addMarkers([
            {
                "lat": project.latitude,
                "lng": project.longitude,
                "picture": {
                    //"url": 'http://www.planet-action.org/img/2009/interieur/icons/orange-dot.png',
                    "width":  32,
                    "height": 32
                }
            }
        ]);
        handler.bounds.extendWith(markers);
        handler.fitMapToBounds();
        handler.getMap().setZoom(17);
    });
}

function gmap_form(project) {
    handler = Gmaps.build('Google');
    handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        if (project && project.latitude && project.longitude) {
            markers = handler.addMarkers([
                {
                    "lat": project.latitude,
                    "lng": project.longitude,
                    "picture": {
                        "url": 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
                        "width":  32,
                        "height": 32
                    }
                }
            ]);
            handler.bounds.extendWith(markers);
            handler.fitMapToBounds();
            handler.getMap().setZoom(17);
        }
        else {
            handler.fitMapToBounds();
            handler.map.centerOn([-17.3941855, -66.1585695]);
            handler.getMap().setZoom(15);
        }
    });

    var markerOnMap;

    function placeMarker(location) {
        if (markerOnMap) {
            markerOnMap.setPosition(location);
        }
        else {
            markerOnMap = new google.maps.Marker({
                position: location,
                map: handler.getMap()
            });
        }
    }

    if(document.getElementById("map_lat").value != ""){
        placeMarker(new google.maps.LatLng(document.getElementById("map_lat").value, document.getElementById("map_lng").value));
    }

    google.maps.event.addListener(handler.getMap(), 'click', function(event) {
        placeMarker(event.latLng);
        document.getElementById("map_lat").value = event.latLng.lat();
        document.getElementById("map_lng").value = event.latLng.lng();
    });
}
