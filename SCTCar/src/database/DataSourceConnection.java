package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DataSourceConnection {
	
	private String urlDB;
	private String userDB;
	private String passDB;
	private Connection connection;
	
	private static DataSourceConnection istanza;

	//Accede alla base di dati
	private DataSourceConnection() {
		
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		urlDB = "jdbc:postgresql://localhost/parcoauto";
		userDB = "safecar";
		passDB = "1234";
		try {
			connection = DriverManager.getConnection(urlDB, userDB, passDB);
		} catch (SQLException e) {
			System.out.println("Connessione non riuscita");
		}
	}

	//Se non esiste già, crea una istanza di DataSourceConnection
	public static DataSourceConnection getIstanza() {
		if(istanza == null)
			return istanza = new DataSourceConnection();
		else
			return istanza;
	}

	//Esegue la query
	public ResultSet eseguiQuery(String query, Object[] parametri) throws SQLException {
		PreparedStatement ps = connection.prepareStatement(query);

		if (parametri != null) {
			if (parametri.length > 0) {
				for (int i = 0; i < (parametri.length); i++) {
					ps.setObject(i + 1, parametri[i]);
				}
			}
		}
		ResultSet result = esegui(ps);
		return result;
	}
	
	//Esegue la query con il prepared statement preparato da updateQuery
	private ResultSet esegui(PreparedStatement ps) throws SQLException {
		ResultSet result = null;
		result = ps.executeQuery();
		return result;
	}

	//Esegue la query di update
	public int updateQuery(String query, Object[] parametri) throws SQLException {
		PreparedStatement ps = connection.prepareStatement(query);
		if (parametri != null) {
			if (parametri.length > 0) {
				for (int i = 0; i < (parametri.length); i++) {
					ps.setObject(i + 1, parametri[i]);
				}
			}
		}
		int result = update(ps);
		ps.close();
		return result;
	}

	//Esegue l'update con il prepared statement preparato da updateQuery
	private int update(PreparedStatement ps) throws SQLException {
		int result = -1;
		result = ps.executeUpdate();
		return result;
	}

	//Chiude la connessione
	public void closeConnection() throws SQLException {
		connection.close();
	}
}
