package org.ict.wimap.util;

import org.hibernate.SessionFactory;
import org.ict.wimap.service.BuildingManager;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ServiceLocator {

	private static ApplicationContext ctx;
	
	static {
		ctx = new ClassPathXmlApplicationContext("spring-config.xml");
	}
	
	private ServiceLocator(){}
	
	public static SessionFactory getSessionFactory(){
		return ctx.getBean("wimapfactory", SessionFactory.class);
	}
	
	public static BuildingManager getBuildingManager(){
		return ctx.getBean("buildingManager", BuildingManager.class);
	}
	
}
