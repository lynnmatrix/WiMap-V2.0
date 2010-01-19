package org.ict.wimap.ui.building;

import java.util.Map;

import org.ict.wimap.service.BuildingManager;
import org.ict.wimap.util.ServiceLocator;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.util.Initiator;
 

public class ListBuildings implements Initiator {

	@Override
	public void doAfterCompose(Page arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean doCatch(Throwable arg0) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void doFinally() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doInit(Page page, Map arg1) throws Exception {
		BuildingManager manager = ServiceLocator.getBuildingManager();
		
		page.setVariable("allBuildings", manager.getAllBuildings());
		
	}
	
	

}
