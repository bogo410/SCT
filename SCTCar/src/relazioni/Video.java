package relazioni;

import database.DataSourceConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Video{

	private String link;
	private String data;
	private String ora;
	private String auto;

	public Video(String data, String ora, String auto){
	
	this.link = link;
	this.data = data;
	this.ora = ora;
	this.auto = auto;
	}
	
	// costruttore utilizzato da eventuale query
	public Video(ResultSet rs) throws SQLException {
		
		this.link = rs.getString("link");
		this.data = rs.getString("data");
		this.ora = rs.getString("ora");
		this.auto = rs.getString("auto");
	}
	
	//Esegue la query per ottenere tutti i video dell'auto con la targa inserita
	//in ordine dal più attuale al più vecchio
	public static List<Video> getListaVideo(String Auto) {
	
		List<Video> res = new ArrayList<>();
		try {
					
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "SELECT * FROM Video WHERE Auto = ? ORDER BY Data DESC, Ora DESC ";
			Object[] parametri = new Object[1];
			parametri[0] = Auto;
			ResultSet rs = dsc.eseguiQuery(query, parametri);
			System.out.print("----------" + query + Auto + "----------");
			while (rs.next())
				res.add(new Video(rs));
		} catch (SQLException e) {
						
			System.out.println("Query fallita: " + e);
		}
		return res;
				
	}

	//Getters e Setters
	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
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