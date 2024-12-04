package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import models.Categorie;

public class CategorieDAO {

	private Connection connection;

	public CategorieDAO(Connection connection) {
		this.connection = connection;
	}

	public List<Categorie> getAllCategories() {
		List<Categorie> categories = new ArrayList<>();
		String query = "SELECT * FROM Categories";

		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

			while (rs.next()) {
				int categoryID = rs.getInt("CategoryID");
				String name = rs.getString("Name");
				String description = rs.getString("Description");

				Categorie categorie = new Categorie(categoryID, name, description);
				categories.add(categorie);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return categories;
	}
}
