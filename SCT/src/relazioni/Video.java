package relazioni;

import database.DataSourceConnection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Video{

	private String data;
	private String ora;
	private String targa;

	public Video(String data, String ora, String targa){
	
	this.data = data;
	this.ora = ora;
	this.targa = targa;
	
	}
}