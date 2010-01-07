$(function() {
  if(geo_position_js.init()){
  	geo_position_js.getCurrentPosition(success_callback,error_callback,{enableHighAccuracy:true});
  }
  else{
  	// alert("Functionality not available");
  }

  function success_callback(p)
  {
    var scan_id = $('#scan_id').text().replace(/ /g,'');
  	var scan_hash = $('#scan_hash').text().replace(/ /g,'');
  	$.get("/scans/"+ scan_id +"/update_location", { lat: p.coords.latitude.toFixed(2), long: p.coords.longitude.toFixed(2), scan_hash: scan_hash } );
  }

  function error_callback(p)
  {
  	//Do nothing
  }
});