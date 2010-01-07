/*
 ### jQuery Google Maps Plugin v1.00 - 2009-12-25 ###
 * Home: http://www.mayzes.org/googlemaps.jquery.html
 * Code: http://www.mayzes.org/js/jquery.googlemaps.js
 *
 * licensed under the GPL licenses:
 *   http://www.gnu.org/licenses/gpl.html
 ###
*/
jQuery.fn.googleMaps = function(options) {
	if (!window.GBrowserIsCompatible || !GBrowserIsCompatible()) 
		return this;

	// Fill default values where not set by instantiation code
	var opts = $.extend({}, $.googleMaps.defaults, options);
	
	//$.fn.googleMaps.includeGoogle(opts.key, opts.sensor);
	return this.each(function() {
		// Create Map
		$.googleMaps.gMap = new GMap2(this, options);
		// Latitude & Longitude Center Point
		var center 	= $.googleMaps.mapLatLong(opts.latitude, opts.longitude);
		// Set the center of the Map with the new Center Point and Depth
		$.googleMaps.gMap.setCenter(center, opts.depth);
		
		// Let's see if the user has set advanced options
		if ( opts.polyline )
			// Draw a PolyLine on the Map
			$.googleMaps.gMap.addOverlay($.googleMaps.mapPolyLine(opts.polyline));
		
		if ( opts.pan ) {
			// Set Default Options
			opts.pan = $.googleMaps.mapPanOptions(opts.pan);
			// Pan the Map
			window.setTimeout(function() {
				$.googleMaps.gMap.panTo($.googleMaps.mapLatLong(opts.pan.panLatitude, opts.pan.panLongitude));
			}, opts.pan.timeout);
		}
		
		if ( opts.layer )
			// Set the Custom Layer
			$.googleMaps.gMap.addOverlay(new GLayer(opts.layer));
		
		if ( opts.markers )
			$.googleMaps.mapMarkers(center, opts.markers);

		if ( opts.controls.type || opts.controls.zoom ||  opts.controls.mapType ) {
			$.googleMaps.mapControls(opts.controls);
		}
		else {
			if ( !opts.controls.hide ) 
				$.googleMaps.gMap.setUIToDefault();
		}	  
	});
};

$.googleMaps = {
	maps: {},
	marker: {},
	gMap: {},
	num: 1,
	defaults: {
	// Default Map Options
		latitude: 	37.4419,
		longitude: 	-122.1419,
		depth: 		13,
		controls: {
			hide: false
		},
		layer:		null
	},
	mapPolyLine: function(options) {
		// Default PolyLine Options
		polylineDefaults = {
			startLatitude: 	37.4419,
			startLongitude: -122.1419,
			endLatitude:	37.4519,
			endLongitude:	-122.1519,
			color: 			'#ff0000',
			pixels: 		2
		}
		// Merge the User & Default Options
		options = $.extend({}, polylineDefaults, options);
		//Return the New Polyline
		return new GPolyline([
			$.googleMaps.mapLatLong(options.startLatitude, options.startLongitude),
			$.googleMaps.mapLatLong(options.endLatitude, options.endLongitude)], 
			options.color, 
			options.pixels
		);
	},
	mapLatLong: function(latitude, longitude) {
		// Returns Latitude & Longitude Center Point
		return new GLatLng(latitude, longitude );
	},
	mapPanOptions: function(options) {
		// Returns Panning Options
		var panDefaults = {
			panLatitude:	37.4569, 	
			panLongitude:	-122.1569,
			timeout: 		0
		}
		return options = $.extend({}, panDefaults, options);
	},
	mapMarkersOptions: function(icon) {
		//Define an icon
		var gIcon = new GIcon(G_DEFAULT_ICON);	
		if ( icon.image ) 
			// Define Icons Image
			gIcon.image = icon.image;
		if ( icon.shadow )
			// Define Icons Shadow
			gIcon.shadow = icon.shadow;
		if ( icon.iconSize )
			// Define Icons Size
			gIcon.iconSize = new GSize(icon.iconSize);
		if ( icon.shadowSize )
			// Define Icons Shadow Size
			gIcon.shadowSize = new GSize(icon.shadowSize);
		if ( icon.iconAnchor )
			// Define Icons Anchor
			gIcon.iconAnchor = new GPoint(icon.iconAnchor);
		if ( icon.infoWindowAnchor )
			// Define Icons Info Window Anchor
			gIcon.infoWindowAnchor = new GPoint(icon.infoWindowAnchor);
		if ( icon.dragCrossImage ) 
			// Define Drag Cross Icon Image
			gIcon.dragCrossImage = icon.dragCrossImage;
		if ( icon.dragCrossSize )
			// Define Drag Cross Icon Size
			gIcon.dragCrossSize = new GSize(icon.dragCrossSize);
		if ( icon.dragCrossAnchor )
			// Define Drag Cross Icon Anchor
			gIcon.dragCrossAnchor = new GPoint(icon.dragCrossAnchor);
		if ( icon.maxHeight )
			// Define Icons Max Height
			gIcon.maxHeight = icon.maxHeight;
		if ( icon.PrintImage )
			// Define Print Image
			gIcon.PrintImage = icon.PrintImage;
		if ( icon.mozPrintImage )
			// Define Moz Print Image
			gIcon.mozPrintImage = icon.mozPrintImage;
		if ( icon.PrintShadow )
			// Define Print Shadow
			gIcon.PrintShadow = icon.PrintShadow;
		if ( icon.transparent )
			// Define Transparent
			gIcon.transparent = icon.transparent;
		return gIcon;
	},
	mapMarkers: function(center, markers) {
		if ( markers.length >= 1 ) {
			for ( i = 0; i<markers.length; i++) {
				var gIcon = null;
				if ( markers[i].icon ) {
					gIcon = $.googleMaps.mapMarkersOptions(markers[i].icon);
				}
				if ( markers[i].latitude && markers[i].longitude )
					// Latitude & Longitude Center Point
					center = $.googleMaps.mapLatLong(markers[i].latitude, markers[i].longitude);
					
				$.googleMaps.marker[i] = new GMarker(center, {draggable: markers[i].draggable, icon: gIcon});
				$.googleMaps.gMap.addOverlay($.googleMaps.marker[i]);
				if ( markers[i].info ) {
					// Individual Marker Information
					$(markers[i].info.layer).hide();
					// Marker Div Layer Exists
					if ( markers[i].info.popup ) {
						// Map Marker Shows an Info Box on Load
						$.googleMaps.marker[i].openInfoWindowHtml($(markers[i].info.layer).html());
					}
					// Hide Div Layer With Info Window HTML
					var layer = markers[i].info.layer;
					GEvent.addListener($.googleMaps.marker[i], "click", function() {
						// Map Marker Shows an Info Box on Click
						this.openInfoWindowHtml($(layer).html());
					});
					$.googleMaps.num++;
				}
			}
		}
		else {
			var gIcon = null;
			if ( markers.icon ) {
				gIcon = $.googleMaps.mapMarkersOptions(markers.icon);
			}
			if ( markers.latitude && markers.longitude )
				// Latitude & Longitude Center Point
				center = $.googleMaps.mapLatLong(markers.latitude, markers.longitude);
			if ( center ) {
				$.googleMaps.marker = new GMarker(center, {draggable: markers.draggable, icon: gIcon});
				$.googleMaps.gMap.addOverlay($.googleMaps.marker);
				if ( markers.info ) {
					// Individual Marker Information
					if ( markers.info.layer ) {
						// Marker Div Layer Exists
						if ( markers.info.popup ) {
							// Map Marker Shows an Info Box on Load
							$(markers.info.layer).hide();
							$.googleMaps.marker.openInfoWindowHtml($(markers.info.layer).html());
						}
						// Hide Div Layer With Info Window HTML
						$(markers.info.layer).hide();
						GEvent.addListener($.googleMaps.marker, "click", function() {
							// Map Marker Shows an Info Box on Click
							this.openInfoWindowHtml($(markers.info.layer).html());
						});	
					}
				}
			}
		}
	},
	mapControlsLocation: function(location) {
		switch (location) {
			case 'G_ANCHOR_TOP_RIGHT' :
				return G_ANCHOR_TOP_RIGHT;
			break;
			case 'G_ANCHOR_BOTTOM_RIGHT' :
				return G_ANCHOR_BOTTOM_RIGHT;
			break;
			case 'G_ANCHOR_TOP_LEFT' :
				return G_ANCHOR_TOP_LEFT;
			break;
			case 'G_ANCHOR_BOTTOM_LEFT' :
				return G_ANCHOR_BOTTOM_LEFT;
			break;
		}
		return;
	},
	mapControl: function(control) {
		switch (control) {
			case 'GLargeMapControl3D' :
				return new GLargeMapControl3D();
			break;
			case 'GLargeMapControl' :
				return new GLargeMapControl();
			break;
			case 'GSmallMapControl' :
				return new GSmallMapControl();
			break;
			case 'GSmallZoomControl3D' :
				return new GSmallZoomControl3D();
			break;
			case 'GSmallZoomControl' :
				return new GSmallZoomControl();
			break;
			case 'GScaleControl' :
				return new GScaleControl();
			break;
			case 'GMapTypeControl' :
				return new GMapTypeControl();
			break;
			case 'GHierarchicalMapTypeControl' :
				return new GHierarchicalMapTypeControl();
			break;
			case 'GOverviewMapControl' :
				return new GOverviewMapControl();
			break;
			case 'GNavLabelControl' :
				return new GNavLabelControl();
			break;
		}
		return;
	},
	mapTypeControl: function(type) {
		switch ( type ) {
			case 'G_NORMAL_MAP' :
				return G_NORMAL_MAP;
			break;
			case 'G_SATELLITE_MAP' :
				return G_SATELLITE_MAP;
			break;
			case 'G_HYBRID_MAP' :
				return G_HYBRID_MAP;
			break;
		}
		return;
	},
	mapControls: function(options) {
		// Default Controls Options
		controlsDefaults = {
			type: {
				location: 'G_ANCHOR_TOP_RIGHT',
				x: 10,
				y: 10,
				control: 'GMapTypeControl'
			},
			zoom: {
				location: 'G_ANCHOR_TOP_LEFT',
				x: 10,
				y: 10,
				control: 'GLargeMapControl3D'
			}
		};
		// Merge the User & Default Options
		options = $.extend({}, controlsDefaults, options);
		options.type = $.extend({}, controlsDefaults.type, options.type);
		options.zoom = $.extend({}, controlsDefaults.zoom, options.zoom);
		
		if ( options.type ) {
			var controlLocation = $.googleMaps.mapControlsLocation(options.type.location);
			var controlPosition = new GControlPosition(controlLocation, new GSize(options.type.x, options.type.y));
			$.googleMaps.gMap.addControl($.googleMaps.mapControl(options.type.control), controlPosition);
		}
		if ( options.zoom ) {
			var controlLocation = $.googleMaps.mapControlsLocation(options.zoom.location);
			var controlPosition = new GControlPosition(controlLocation, new GSize(options.zoom.x, options.zoom.y))
			$.googleMaps.gMap.addControl($.googleMaps.mapControl(options.zoom.control), controlPosition);
		}
		if ( options.mapType ) {
			if ( options.mapType.length >= 1 ) {
				for ( i = 0; i<options.mapType.length; i++) {
					if ( options.mapType[i].remove )
						$.googleMaps.gMap.removeMapType($.googleMaps.mapTypeControl(options.mapType[i].remove));
					if ( options.mapType[i].add )
						$.googleMaps.gMap.addMapType($.googleMaps.mapTypeControl(options.mapType[i].add));
				}
			} 
			else {
				if ( options.mapType.add )
					$.googleMaps.gMap.addMapType($.googleMaps.mapTypeControl(options.mapType.add));
				if ( options.mapType.remove )
					$.googleMaps.gMap.removeMapType($.googleMaps.mapTypeControl(options.mapType.remove));
			}
		}
	}
};