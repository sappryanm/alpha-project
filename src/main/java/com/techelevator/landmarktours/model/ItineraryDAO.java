package com.techelevator.landmarktours.model;

import java.util.List;

public interface ItineraryDAO {
	
	public List<Itinerary> getItinerary();
	public void saveItinerary(Itinerary itinerary);
	public Itinerary getItineraryByName(String itinerary);

}