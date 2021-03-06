<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/jsp/header.jsp" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>




<h3> Please Select Your Hotel As a Starting Point</h3>

<div id="map_canvas" style="width-min: 300px; height: 350px; position: relative; background-color: rgb(229, 227, 223);">
    </div>
    <div id="directions-panel"></div>
  
     <div id="right-panel" class="row">
    <div>
    <b>Start:</b>
    <select id="start" name="hotelStart" class="form-control input-sm">
       <c:forEach var="hotelList" items="${hotelList}">
    	 	<option value="${hotelList.latitude}, ${hotelList.longitude}">${hotelList.name}</option>
 	   </c:forEach>
    </select>
    <br>
    <b>Waypoints:</b> <br>
    <i>(Ctrl+Click or Cmd+Click for multiple selection)</i> <br>
    <select multiple id="waypoints" name="landmarks" class="form-control">
    <c:forEach var="landmarkList" items="${landmarkList}">
    	 	<option value="${landmarkList.latitude}, ${landmarkList.longitude}">${landmarkList.name}</option>
 	 </c:forEach>
    </select>
    <br>
    <b>End:</b>
    <select id="end" name="hotelEnd" class="form-control input-sm">
      <c:forEach var="hotelList" items="${hotelList}">
    	 	<option value="${hotelList.latitude}, ${hotelList.longitude}">${hotelList.name}</option>
 	   </c:forEach>
    </select>
    <br>
      <input type="submit" id="submit" class="form-control">
    </div>      
	
    </div> <br>
 
 <c:url var="formAction" value="/users/${userName}"/>   
 <form method="POST" action="${formAction}">
 	
   <div id="save Itinerary" style="float: left;" >
    <div>
    <div>
    	<b>Enter Name To Save Itinerary:</b><br>
    	 <input name="itineraryName" class="form-control input-sm" >
    </div>
    <b>Waypoints:</b> <br>
    <i>(Ctrl+Click or Cmd+Click for multiple selection)</i> <br>
    <select multiple id="waypoints" name="landmarkId" class="form-control">
    <c:forEach var="landmarkList" items="${landmarkList}">
    	 	<option value="${landmarkList.landmarkId}">${landmarkList.name}</option>
 	 </c:forEach>
    </select>
    <br>
      <input type="submit" id="submit" value="Save Itinerary" class="form-control" >
    </div>      
	
    </div>
    </form>
       <script>
       function initMap() {
         var directionsService = new google.maps.DirectionsService;
         var directionsDisplay = new google.maps.DirectionsRenderer;
         var map = new google.maps.Map(document.getElementById('map_canvas'), {
           zoom: 10,
           center: {lat: 39.965741, lng: -83.002793}
         });
         directionsDisplay.setMap(map);
         // Multiple Markers
         var markers = [
             ['Columbus, Ohio', 39.965741,-83.002793]
             
         ];
         

/* 		<c:forEach var="hotel" items="${hotelList}">
			markers.push(["${hotel.name}", ${hotel.latitude}, ${hotel.longitude}]);
		</c:forEach> */
                             

         // Info Window Content
         var infoWindowContent = [
             ['<div class="info_content">' +
             '<h3>Columbus, Ohio</h3>' +
             '<div><img src="http://www.columbussports.org/wp-content/uploads/2012/01/Columbus-Skyline-South-e1332361914545.jpg" style="width: 75%; margin-right: 0px;"</div>' +
             '<p>Home of the Buckeyes and everything else. OH---IO!! <br>Come get your eat on, drink on, art on, sports on, chill on!</p>' + '</div>'],
             ['<div class="info_content">' +
             '<h3>Palace of Westminster</h3>' +
             '<p>The Palace of Westminster is the meeting place of the House of Commons and the House of Lords, the two houses of the Parliament of the United Kingdom. Commonly known as the Houses of Parliament after its tenants.</p>' +
             '</div>']
         ];
             
         // Display multiple markers on a map
         var infoWindow = new google.maps.InfoWindow(), marker, i;
         
         // Loop through our array of markers & place each one on the map  
         for( i = 0; i < markers.length; i++ ) {
             var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
             
             marker = new google.maps.Marker({
                 position: position,
                 map: map,
                 title: markers[i][0]
             });
             
             // Allow each marker to have an info window    
             google.maps.event.addListener(marker, 'click', (function(marker, i) {
                 return function() {
                     infoWindow.setContent(infoWindowContent[i][0]);
                     infoWindow.open(map, marker);
                 }
             })(marker, i));
         }

         document.getElementById('submit').addEventListener('click', function() {
           calculateAndDisplayRoute(directionsService, directionsDisplay);
		
         });
       }
       var widgetDiv = document.getElementById('save-widget');
       map.controls[google.maps.ControlPosition.TOP_LEFT].push(widgetDiv);

       // Append a Save Control to the existing save-widget div.
       var saveWidget = new google.maps.SaveWidget(widgetDiv, {
         place: {
           // ChIJN1t_tDeuEmsRUsoyG83frY4 is the place Id for CourtYard.
           placeId: 'ChIJyY9c6S-POIgRlMVLdUiH6Cc',
           location: {lat: -33.866647, lng: 151.195886}
         },
         attribution: {
           source: 'Google Maps JavaScript API',
           webUrl: 'https://developers.google.com/maps/'
         }
       });

       var marker = new google.maps.Marker({
         map: map,
         position: saveWidget.getPlace().location
       });
       function calculateAndDisplayRoute(directionsService, directionsDisplay) {
         var waypts = [];
         var checkboxArray = document.getElementById('waypoints');
         for (var i = 0; i < checkboxArray.length; i++) {
           if (checkboxArray.options[i].selected) {
             waypts.push({
               location: checkboxArray[i].value,
               stopover: true
             });
           }
         }
     
         

         directionsService.route({
           origin: document.getElementById('start').value,
           destination: document.getElementById('end').value,
           waypoints: waypts,
           optimizeWaypoints: true,
           travelMode: 'DRIVING'
         }, function(response, status) {
           if (status === 'OK') {
             directionsDisplay.setDirections(response);
             var route = response.routes[0];
             var summaryPanel = document.getElementById('directions-panel');
             summaryPanel.innerHTML = '';
             // For each route, display summary information.
             for (var i = 0; i < route.legs.length; i++) {
               var routeSegment = i + 1;
               summaryPanel.innerHTML += '<b>Route Segment: ' + routeSegment +
                   '</b><br>';
               
               summaryPanel.innerHTML += route.legs[i].start_address + ' to ';
               summaryPanel.innerHTML += route.legs[i].end_address + '<br>';
               summaryPanel.innerHTML += route.legs[i].distance.text + '<br><br>';
             }
/*              var input = document.createElement("button");        // Create a <button> element
             var text = document.createTextNode("Save Itinerary")       // Create a text node
             input.appendChild(text);
             document.getElementById('directions-panel').appendChild(input); */
           } else {
             window.alert('Directions request failed due to ' + status);
           }
         });

       }

       </script>
 <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAr5ShZL1BRiM_fdvx6wHIKpe48McMYqb8&callback=initMap">
 </script>

<c:import url="/WEB-INF/jsp/footer.jsp" />