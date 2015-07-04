package relazioni;

import database.DataSourceConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Posizione{

	private float latitudine;
	private float longitudine;
	private String data;
	private String ora;
	private String auto;

	public Posizione(float latitudine, float longitudine, String data, String ora){
	
	this.latitudine = latitudine;
	this.longitudine = longitudine;
	this.data = data;
	this.ora = ora;
	this.auto = auto;
	}
	
	// costruttore utilizzato da eventuale query
	public Posizione(ResultSet rs) throws SQLException {
		
		this.latitudine = rs.getFloat("latitudine");
		this.longitudine = rs.getFloat("longitudine");
		this.data = rs.getString("data");
		this.ora = rs.getString("ora");
		this.auto = rs.getString("auto");
	}
	
	
	
	
	//funziona?????????
	
	
	
	
	
	//Esegue la query per ottenere l'ultima posizione dell'auto con la targa inserita
	public static Posizione getPosizioneAttuale(String Auto) {
					
		Posizione res = null;
		try {
					
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "SELECT * FROM Posizione WHERE Auto = ? ORDER BY Data DESC, Ora DESC ";
			Object[] parametri = new Object[1];
			parametri[0] = Auto;
			ResultSet rs = dsc.eseguiQuery(query, parametri);
			System.out.print("----------" + query + Auto + "----------");
			if (rs.next())	 	//escamotage per ottimizzare la query(seleziona solo la prima riga,
								//altrimenti avremmo dovuto fare una join più pesante)
				res = new Posizione(rs);
		} catch (SQLException e) {
						
			System.out.println("Query fallita: " + e);
		}
		return res;
				
	}	
	
	//Esegue la query per ottenere tutte le posizioni dell'auto con la targa inserita
	//in ordine dalla più attuale alla più vecchia
	public static List<Posizione> getListaPosizioni(String Auto) {
	
		List<Posizione> res = new ArrayList<>();
		try {
					
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "SELECT * FROM Posizione WHERE Auto = ? ORDER BY Data DESC, Ora DESC ";
			Object[] parametri = new Object[1];
			parametri[0] = Auto;
			ResultSet rs = dsc.eseguiQuery(query, parametri);
			System.out.print("----------" + query + Auto + "----------");
			while (rs.next())
				res.add(new Posizione(rs));
		} catch (SQLException e) {
						
			System.out.println("Query fallita: " + e);
		}
		return res;
				
	}

	//Getters e Setters
	public float getLatitudine() {
		return latitudine;
	}

	public void setLatitudine(float latitudine) {
		this.latitudine = latitudine;
	}

	public float getLongitudine() {
		return longitudine;
	}

	public void setLongitudine(float longitudine) {
		this.longitudine = longitudine;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getOra() {
		return ora;
	}

	public void setOra(String ora) {
		this.ora = ora;
	}

	public String getAuto() {
		return auto;
	}

	public void setAuto(String auto) {
		this.auto = auto;
	}

}