package dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.Query;

import entities.Student;
import services.HibernateUtil;

public class StudentDao {
    public static List<Student> getAllStudents() {
        List<Student> studentList = new ArrayList<>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            String hql = "FROM Student";
            Query<Student> query = session.createQuery(hql, Student.class);
            studentList = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return studentList;
    }
}
