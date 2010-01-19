package org.ict.wimap.model.building;

/**
 * This is an object that contains data related to the building table.
 * Do not modify this class because it will be overwritten if the configuration file
 * related to this class is modified.
 *
 * @hibernate.class
 *  table="building"
 */

public class Building {
 

	
	public Building(){};
	
	/**
	 * Constructor for required fields
	 */
	public Building (
		java.lang.Integer id,
		java.math.BigDecimal bjingdu,
		java.math.BigDecimal bweidu,
		java.lang.Short floornum) {

		this.setId(id);
		this.setBjingdu(bjingdu);
		this.setBweidu(bweidu);
		this.setFloornum(floornum);
		initialize();
	}

	protected void initialize () {}



	private int hashCode = Integer.MIN_VALUE;

	// primary key
	private java.lang.Integer id;

	// fields
	private java.math.BigDecimal bjingdu;
	private java.math.BigDecimal bweidu;
	private java.lang.Short floornum;



	/**
	 * Return the unique identifier of this class
     * @hibernate.id
     *  generator-class="vm"
     *  column="bid"
     */
	public java.lang.Integer getId () {
		return id;
	}

	/**
	 * Set the unique identifier of this class
	 * @param id the new ID
	 */
	public void setId (java.lang.Integer id) {
		this.id = id;
		this.hashCode = Integer.MIN_VALUE;
	}




	/**
	 * Return the value associated with the column: bjingdu
	 */
	public java.math.BigDecimal getBjingdu () {
		return bjingdu;
	}

	/**
	 * Set the value related to the column: bjingdu
	 * @param bjingdu the bjingdu value
	 */
	public void setBjingdu (java.math.BigDecimal bjingdu) {
		this.bjingdu = bjingdu;
	}



	/**
	 * Return the value associated with the column: bweidu
	 */
	public java.math.BigDecimal getBweidu () {
		return bweidu;
	}

	/**
	 * Set the value related to the column: bweidu
	 * @param bweidu the bweidu value
	 */
	public void setBweidu (java.math.BigDecimal bweidu) {
		this.bweidu = bweidu;
	}



	/**
	 * Return the value associated with the column: floornum
	 */
	public java.lang.Short getFloornum () {
		return floornum;
	}

	/**
	 * Set the value related to the column: floornum
	 * @param floornum the floornum value
	 */
	public void setFloornum (java.lang.Short floornum) {
		this.floornum = floornum;
	}

	public boolean equals (Object obj) {
		if (null == obj) return false;
		if (!(obj instanceof org.ict.wimap.model.building.Building)) return false;
		else {
			org.ict.wimap.model.building.Building building = (org.ict.wimap.model.building.Building) obj;
			if (null == this.getId() || null == building.getId()) return false;
			else return (this.getId().equals(building.getId()));
		}
	}

	public int hashCode () {
		if (Integer.MIN_VALUE == this.hashCode) {
			if (null == this.getId()) return super.hashCode();
			else {
				String hashStr = this.getClass().getName() + ":" + this.getId().hashCode();
				this.hashCode = hashStr.hashCode();
			}
		}
		return this.hashCode;
	}


	public String toString () {
		return super.toString();
	}


}