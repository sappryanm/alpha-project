package com.techelevator.landmarktours.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

@Component
public class JDBCLandmarksDAO implements LandmarksDAO {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public JDBCLandmarksDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	
	public List<Landmarks> getLandmarks() {
		String sqlSelectLandmarks = "SELECT * "+
									"FROM landmarks";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectLandmarks);
		return mapRowSetToLandmarks(results);
	}

	@Override
	public void saveLandmarks(Landmarks landmarks) {

		jdbcTemplate.update("INSERT INTO landmarks(name, place_id, landmark_id, type, latitude, longitude, street_address, city, state, zip, description) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
							landmarks.getName(), landmarks.getplaceId(), landmarks.getLandmarkId(), landmarks.getType(), landmarks.getLatitude(), landmarks.getLongitude(), landmarks.getStreetAddress(), landmarks.getCity(),
							landmarks.getState(), landmarks.getZip(), landmarks.getDescription());
	}
	
	@Override
	public Landmarks getLandmarksById(String landmarkId) {
		Landmarks landmark = null;
		String sqlSelectLandmarkById = "SELECT * "
										+ "FROM landmarks "
										+ "WHERE landmark_id = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectLandmarkById, landmarkId);
		if(results.next()) {
			landmark = mapRowToLandmarks(results);
		}
		return landmark;
	}

	@Override
	public Landmarks searchLandMarksByRadius(String locationId ) {
		Landmarks landmark = null;
		String sqlSelectLandmarkById = "SELECT ? WHERE , ( 3959 * acos( cos( radians(37) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(-122) ) + "
				+ "sin( radians(37) ) * sin( radians( lat ) ) ) ) AS distance + "
				+ "FROM landmarks HAVING distance < 25 ORDER BY distance LIMIT 0 , 20";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectLandmarkById, locationId);
		if(results.next()) {
			landmark = mapRowToLandmarks(results);
		}
		return landmark;
	}
	@Override
	public Landmarks getLandmarksByType(String type) {
		Landmarks landmark = null;
		String sqlSelectLandmarkById = "SELECT * "
										+ "FROM landmarks "
										+ "WHERE type = ? ";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectLandmarkById, type);
		if(results.next()) {
			landmark = mapRowToLandmarks(results);
		}
		return landmark;
	}
	
//	@Override
//	public Landmarks getMostRecentLandmark() {
//		Landmarks landmark = null;
//		String sqlSelectLandmarks = "SELECT * "+
//									"FROM landmarks";
//		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectLandmarks);
//		
//		return null;
//	}

	private List<Landmarks> mapRowSetToLandmarks(SqlRowSet results) {
		ArrayList<Landmarks> landmarkList = new ArrayList<>();
		while(results.next()) {
			landmarkList.add(mapRowToLandmarks(results));
		}
		return landmarkList;
	}
	

	private Landmarks mapRowToLandmarks(SqlRowSet results) {
		Landmarks landmark = new Landmarks();
		landmark.setName(results.getString("name"));
		landmark.setPlaceId(results.getString("place_id"));
		landmark.setLandmarkId(results.getString("landmark_id"));
		landmark.setType(results.getString("type"));
		landmark.setLatitude(results.getDouble("latitude"));
		landmark.setLongitude(results.getDouble("longitude"));
		landmark.setStreetAddress(results.getString("street_address"));
		landmark.setCity(results.getString("city"));
		landmark.setState(results.getString("state"));
		landmark.setZip(results.getString("zip"));
		landmark.setDescription(results.getString("description"));

		return landmark;
	}








	


}
