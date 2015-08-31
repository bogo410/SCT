package automobile;

import java.sql.SQLException;
import java.util.*;

import database.DataSourceConnection;
import relazioni.*;


public class Automobile {

	private String targa;
	private boolean stato;	// stato=false : Safe
							// stato=true : Alarm detected
	private String video;
	private int velocita;
	private double latitudine;
	private double longitudine;
	
	
	public Automobile(String targa, boolean stato, String video, int velocita, double d, double e ){
		this.targa = targa;
		this.stato = stato;
		this.video = video;
		this.velocita = velocita;
		this.latitudine = d;
		this.longitudine = e;
	}
	
	public Automobile(String targa, boolean stato, String video, int velocita){
		this.targa = targa;
		this.stato = stato;
		this.video = video;
		this.velocita = velocita;
	}

	// setta nella base di dati l'allarme: "Sending alarm" e salva il link del video registrato
	public void setAllarme() {
		try {
			
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "UPDATE Auto "
						 + "SET Modalita = 'Sending alarm' "
						 + "WHERE Targa = ? ";
			Object[] parametri = new Object[1];
			parametri[0] = this.targa;
			dsc.updateQuery(query, parametri);
			System.out.print("----------" + query + this.targa + "----------");
		} catch (SQLException e) {
					
			System.out.println("Query fallita: " + e);
		}
		
		try {
			
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "INSERT INTO Video(Link, Auto) "
					 	 + "VALUES(  ? , ? ) ";
			Object[] parametri = new Object[2];
			parametri[0] = this.video;
			parametri[1] = this.targa;
			dsc.updateQuery(query, parametri);
			System.out.print("----------" + query + this.video + this.targa + "----------");
		} catch (SQLException e) {
					
			System.out.println("Query fallita: " + e);
		}
	}
	
	// setta nella base di dati la velocità attuale dell'auto
	public void updateVelocita(){
		try {
			
			DataSourceConnection dsc = DataSourceConnection.getIstanza();
			String query = "UPDATE Auto "
						 + "SET Velocita = ? "
						 + "WHERE Targa = ? ";
			Object[] parametri = new Object[2];
			parametri[0] = this.velocita;
			parametri[1] = this.targa;
			dsc.updateQuery(query, parametri);
			System.out.print("----------" + query + this.targa + this.velocita + "----------");
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

	public boolean isStato() {
		return stato;
	}

	public void setStato(boolean stato) {
		this.stato = stato;
	}
	
	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public int getVelocita() {
		return velocita;
	}

	public void setVelocita(int velocita) {
		this.velocita = velocita;
	}

	public double getLatitudine() {
		return latitudine;
	}

	public void setLatitudine(double latitudine) {
		this.latitudine = latitudine;
	}

	public double getLongitudine() {
		return longitudine;
	}

	public void setLongitudine(double longitudine) {
		this.longitudine = longitudine;
	}
	
}
