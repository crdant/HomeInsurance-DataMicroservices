package io.pivotal.demo.sko.ui;


import io.pivotal.demo.sko.util.GeodeClient;
import io.pivotal.demo.sko.util.SensorEventsMap;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.gemstone.gemfire.pdx.PdxInstance;

@Component
@RestController
@RequestMapping(value = "/controller")
public class Controller {

	static GeodeClient client;
	static{
        client = GeodeClient.getInstance();
        client.setup();
	}

    public Controller() {
    }


    @RequestMapping(value="/getSensorEventsMap")
    public @ResponseBody SensorEventsMap getSensorEventsMap(){

    	SensorEventsMap latestSensorEvents = SensorEventsMap.latestSensorEvents;
    	synchronized (latestSensorEvents) {
			SensorEventsMap map = new SensorEventsMap(latestSensorEvents.getSensorEvents());
			latestSensorEvents.clearAll();
	        return map;
		}


    }


    @RequestMapping(value="/getRiskEventsMap")
    public @ResponseBody SensorEventsMap getRiskEventsMap(){
    	SensorEventsMap riskEvents = SensorEventsMap.riskEvents;
    	synchronized (riskEvents) {
			SensorEventsMap map = new SensorEventsMap(riskEvents.getSensorEvents());
			riskEvents.clearAll();
	        return map;
		}

    }





}
