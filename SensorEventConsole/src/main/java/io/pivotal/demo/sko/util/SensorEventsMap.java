package io.pivotal.demo.sko.util;


import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Vector;

public class SensorEventsMap implements Serializable{

	public static SensorEventsMap latestSensorEvents = new SensorEventsMap();
	public static SensorEventsMap riskEvents= new SensorEventsMap();

	//thread-safe
	private List<MappedSensorEvent> sensorEvents = new Vector<MappedSensorEvent>();

	public SensorEventsMap() {

	}

	public SensorEventsMap(Collection<MappedSensorEvent> t){
		sensorEvents.addAll(t);
	}

	public Collection<MappedSensorEvent> getSensorEvents() {
		return sensorEvents;
	}


	public void addSensorEvent(long id, double value, String location, boolean risk, long timestamp){
		sensorEvents.add(new MappedSensorEvent(id, value, location, risk, timestamp));
	}

	public void clearAll(){
		sensorEvents.clear();
	}


	public void addSensorEvent(MappedSensorEvent t) {
		sensorEvents.add(t);

	}

	public void addSensorEvent(long id, double value,
	String location, long timestamp) {
		addSensorEvent(id, value, location, false, timestamp);
	}

}
