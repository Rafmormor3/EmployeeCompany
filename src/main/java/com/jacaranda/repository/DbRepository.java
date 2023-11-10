package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jacaranda.model.EmployeeProject;
import com.jacaranda.util.BdUtil;

public class DbRepository {

	
	public static <T> T find(Class<T> c, int id) throws Exception {
		Transaction transaction = null;
		Session session;
		T result=null;
		try {
			session = BdUtil.getSessionFactory().openSession();
		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			result = session.find(c, id);
		}catch (Exception e) {
			throw new Exception("error al obtener la entidad");
		}
		return result;
	}
	
	public static <T> T find(Class<T> c, String name) throws Exception {
		Transaction transaction = null;
		Session session;
		T result=null;
		try {
			session = BdUtil.getSessionFactory().openSession();
		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			result = session.find(c, name);
		}catch (Exception e) {
			throw new Exception("error al obtener la entidad");
		}
		return result;
	}
	
	public static <T> T find(Class<T> c, T objet) throws Exception {
		Transaction transaction = null;
		Session session;
		T result=null;
		try {
			session = BdUtil.getSessionFactory().openSession();
		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			result = session.find(c, objet);
		}catch (Exception e) {
			throw new Exception("error al obtener la entidad");
		}
		return result;
	}
	
	public static <T> List<T> findAll(Class<T> c) throws Exception {
		
		Session session;
		List<T> resultList=null;
		
		try {
			session = BdUtil.getSessionFactory().openSession();
			
		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			resultList = (List<T>) session.createSelectionQuery( "From "+c.getName() ).getResultList();
		}catch (Exception e) {
			throw new Exception("error al obtener la entidad");
		}
		return resultList;
	}
	
	public static <T> T add(T t) throws Exception{
		
		Transaction transaction = null;
		
		Session session = null;
		T result=null;
		
		try {
			session = BdUtil.getSessionFactory().openSession();
		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		transaction = (Transaction)session.beginTransaction();
		
		try {
			session.persist(t);
			transaction.commit();
		}catch (Exception e) {
			e.getMessage();
			transaction.rollback();
			throw new Exception("Error al introducir");
		}
		
		
		session.close();
		return result;
	}
	
	public static <T> T update(T t) throws Exception{
			
		Transaction transaction = null;
		
		Session session = null;
		T result=null;
		
		try {
			session = BdUtil.getSessionFactory().openSession();
		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		transaction = (Transaction)session.beginTransaction();
		
		try {
			session.merge(t);
			transaction.commit();
		}catch (Exception e) {
			e.getMessage();
			transaction.rollback();
			throw new Exception("Error al introducir");
		}
		
		
		session.close();
		return result;
	}
	
	public static <T> T delete(T t) throws Exception{
		
		Transaction transaction = null;
		Session session = null;
		T result=null;
		
		try {
			session = BdUtil.getSessionFactory().openSession();
		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		transaction = (Transaction)session.beginTransaction();
		
		try {
			session.remove(t);
			transaction.commit();
		}catch (Exception e) {
			e.getMessage();
			transaction.rollback();
			throw new Exception("Error al introducir");
		}
		
		
		session.close();
		return result;
	}

}