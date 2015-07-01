package login;

import database.DataSourceConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class Auto {
	
	private String targa;
	private String modello;
	private float latitudine;
	private float longitudine;
	private String modalita;
	private int velocita;
	private String codResponsabile;
	
	public Auto(String targa, String modello, float latitudine, float longitudine, String modalita, int velocita, String codResponsabile) {
		
		this.targa = targa;
		this.modello = modello;
		this.latitudine = latitudine;
		this.longitudine = longitudine;
		this.modalita = modalita;
		this.velocita = velocita;
		this.codResponsabile = codResponsabile;
	}

//costruttore utilizzato da eventuale query
	public Auto(ResultSet rs) throws SQLException {
		
		this.targa = rs.getString("targa");
		this.modello = rs.getString("modello");
		this.latitudine = rs.getFloat("latitudine");
		this.longitudine = rs.getFloat("longitudine");
		this.modalita = rs.getString("modalita");
		this.velocita = rs.getInt("velocita");
		this.codResponsabile = rs.getString("codResponsabile");
	}

}
