package login;

import database.DataSourceConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class Dipendente {

	private String matricola;
	private String nome;
	private String cognome;
	private String password;
	private String numTelefono;
	private String ruolo;

	public Dipendente(String matricola, String nome, String cognome, String password, String ruolo, String numTelefono) {
		
		this.matricola = matricola;
		this.nome = nome;
		this.cognome = cognome;
		this.password = password;
		this.ruolo = ruolo;
		this.numTelefono = numTelefono;
	}

	// costruttore utilizzato da eventuale query
	public Dipendente(ResultSet rs) throws SQLException {
		
		this.matricola = rs.getString("matricola");
		this.nome = rs.getString("nome");
		this.cognome = rs.getString("cognome");
		this.password = rs.getString("password");
		this.ruolo = rs.getString("ruolo");
		this.numTelefono = rs.getString("numTelefono");
	}

	//Esegue la query per ottenere il dipendente con la matricola inserita
	public static Dipendente getDipendente(String matricola) {
		
		Dipendente res = null;
		try {
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "SELECT * FROM Dipendente WHERE matricola = ? ";      	// punto e virgola??????
			Object[] parametri = new Object[1];
			parametri[0] = matricola;
			ResultSet rs = dsc.eseguiQuery(query, parametri);
			System.out.print("----------" + query + matricola + "----------");
			if (rs.next())
				res = new Dipendente(rs);
		} catch (SQLException e) {
			System.out.println("Query fallita: " + e);
		}
		return res;
	}

	//Esegue la query per ottenere tutti i dipendenti 
	public static List<Dipendente> getDipendenti() {
		
		List<Dipendente> res = new ArrayList<>();
		try {
			
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "SELECT * FROM Dipendente ";
			ResultSet rs = dsc.eseguiQuery(query, null);
			while (rs.next())
				res.add(new Dipendente(rs));
		} catch (SQLException e) {
			
			System.out.println("Query fallita: " + e);
		}
		return res;
	}

	//Getters e Setters
	public String getMatricola() {
		return matricola;
	}

	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRuolo() {
		return ruolo;
	}

	public void setRuolo(String ruolo) {
		this.ruolo = ruolo;
	}
	
	public String getNumTelefono() {
		return numTelefono;
	}

	public void setNumTelefono(String numTelefono) {
		this.numTelefono = numTelefono;
	}
}
