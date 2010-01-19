package org.ict.wimap.service.impl;

import java.util.List;

import org.ict.wimap.dao.building.BuildingDAO;
import org.ict.wimap.model.building.Building;
import org.ict.wimap.service.BuildingManager;

public class BuildingManagerImpl implements BuildingManager {

	private BuildingDAO  buildingdao;
	
	
	public BuildingDAO getBuildingdao() {
		return this.buildingdao;
	}


	public void setBuildingdao(BuildingDAO buildingdao) {
		this.buildingdao = buildingdao;
	}


	@SuppressWarnings("unchecked")
	@Override
	public List getAllBuildings() {
		return this.buildingdao.findAll(Building.class);
	}

}
