package dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.Query;

import entities.Pet;
import services.HibernateUtil;

public class PetDao {
	public static List<Pet> getAllPets() {
		List<Pet> petList = new ArrayList<>();
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			String hql = "FROM Pet";
			Query<Pet> query = session.createQuery(hql, Pet.class);
			petList = query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return petList;
	}
}
