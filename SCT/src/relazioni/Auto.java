package relazioni;

import database.DataSourceConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class Auto {
	
	private String targa;
	private String modello;
	private String modalita;
	private int velocita;
	private String codResponsabile;
	
	public Auto(String targa, String modello, float latitudine, float longitudine, String modalita, int velocita, String codResponsabile) {
		
		this.targa = targa;
		this.modello = modello;
		this.modalita = modalita;
		this.velocita = velocita;
		this.codResponsabile = codResponsabile;
	}

	//costruttore utilizzato da eventuale query
	public Auto(ResultSet rs) throws SQLException {
		
		this.targa = rs.getString("targa");
		this.modello = rs.getString("modello");
		this.modalita = rs.getString("modalita");
		this.velocita = rs.getInt("velocita");
		this.codResponsabile = rs.getString("codResponsabile");
	}
	
	//Esegue la query per ottenere l'auto con la targa inserita
	public static Auto getAuto(String Targa) {
				
		Auto res = null;
		try {
				
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "SELECT * FROM Auto WHERE Targa = ? ";
			Object[] parametri = new Object[1];
			parametri[0] = Targa;
			ResultSet rs = dsc.eseguiQuery(query, parametri);
			System.out.print("----------" + query + Targa + "----------");
			while (rs.next()) 											//if al posto del while?????????????????????????
				res = new Auto(rs);
		} catch (SQLException e) {
					
			System.out.println("Query fallita: " + e);
		}
		return res;
			
	}
		
	//Esegue la query per ottenere le auto appartenenti al dipendente con la matricola inserita
	public static List<Auto> getAutoDip(String codResponsabile) {
			
		List<Auto> res = new ArrayList<>();
		try {
				
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "SELECT * FROM Auto WHERE CodResponsabile = ? ";
			Object[] parametri = new Object[1];
			parametri[0] = codResponsabile;
			ResultSet rs = dsc.eseguiQuery(query, parametri);
			System.out.print("----------" + query + codResponsabile + "----------");
			while (rs.next())
				res.add(new Auto(rs));
		} catch (SQLException e) {
				
			System.out.println("Query fallita: " + e);
		}
		return res;
		
	}

	//Esegue la query per ottenere tutte le auto 
	public static List<Auto> getListaAuto() {
			
		List<Auto> res = new ArrayList<>();
		try {
				
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "SELECT * FROM Auto ";
			ResultSet rs = dsc.eseguiQuery(query, null);
			while (rs.next())
				res.add(new Auto(rs));
		} catch (SQLException e) {
				
			System.out.println("Query fallita: " + e);
		}
		return res;

	}
	
	//Esegue la query per ottenere il ruolo dell'utente loggato
	public static String getRuoloUtente(String matricolaUtente){
		
		String res = "";
		try {
			
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "SELECT DISTINCT D.Ruolo "
						 + "FROM Auto AS A RIGHT JOIN Dipendente AS D "
						 + "ON A.CodResponsabile = D.Matricola "
						 + "WHERE D.Matricola = ? ";
			Object[] parametri = new Object[1];
			parametri[0] = matricolaUtente;
			ResultSet rs = dsc.eseguiQuery(query, parametri);
			System.out.print("----------" + query + matricolaUtente + "----------");
			if (rs.next())
				res = new String(rs.getString(1));
		} catch (SQLException e) {
					
			System.out.println("Query fallita: " + e);
		}
		
		System.out.print("\n\n----------res="+ res + "----------");
		
		return res;
	}
	
	//esegue l'update della modalità con la stringa passata
	public void updateModalita(String nuovaModalita){
		try {
			
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "UPDATE Auto "
						 + "SET Modalita = ? "
						 + "WHERE Targa = ? ";
			Object[] parametri = new Object[2];
			parametri[0] = nuovaModalita;
			parametri[1] = this.targa;
			dsc.updateQuery(query, parametri);
			System.out.print("----------" + query + this.targa + nuovaModalita + "----------");
		} catch (SQLException e) {
					
			System.out.println("Query fallita: " + e);
		}
	}

	//Getters e Setters
	public String getTarga() {
		return targa;
	}

	public void setTarga(String targa) {
		this.targa = targa;
	}

	public String getModello() {
		return modello;
	}

	public void setModello(String modello) {
		this.modello = modello;
	}

	public String getModalita() {
		return modalita;
	}

	public void setModalita(String modalita) {
		this.modalita = modalita;
	}

	public int getVelocita() {
		return velocita;
	}

	public void setVelocita(int velocita) {
		this.velocita = velocita;
	}

	public String getCodResponsabile() {
		return codResponsabile;
	}

	public void setCodResponsabile(String codResponsabile) {
		this.codResponsabile = codResponsabile;
	}
	
}
