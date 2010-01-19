package org.ict.wimap.dao.building;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class BuildingDAO extends HibernateDaoSupport {

	public void saveOrUpdate(Object ob) {
        super.getHibernateTemplate().saveOrUpdate(ob);
        
    }
    
    public void delete(Object ob) {
        super.getHibernateTemplate().delete(ob);
    }
    
    public Object find(Class<?> clazz, Long id) {
        Object ob =  super.getHibernateTemplate().load(clazz,id);
        return ob;
    }

    public List<?> findAll(Class<?> clazz) {
        List<?> list = super.getHibernateTemplate().find(" from " + clazz.getName());
        return list;
    }

}