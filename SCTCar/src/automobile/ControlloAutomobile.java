package automobile;

import java.util.List;
import java.util.Random;

import relazioni.Auto;
import relazioni.Posizione;

public class ControlloAutomobile{
	private float lat = 45.4038087f;
	private float lon = 10.9975166f;
	
	private Automobile automobile = new Automobile( "ED 377 AW", false, null , -1);
	private Posizione posizione = new Posizione( lat, lon, automobile.getTarga() );
	
	public void start() {
		
		System.out.println("\n Inizio controllo Auto: \n\n-----------" );
			
		//simulazione
		simulaAllarme();
		
		while(true){
				
			//simulazione
			simulaVelPos();
			
			//controlla se il sensore rileva l'allarme
			if( automobile.isStato() ){
				automobile.setAllarme();
				automobile.setStato(false);
			}
			
			//imposta velocità e posizione attuali
				automobile.updateVelocita();
				posizione.updatePosizione();
			
			try {
				Thread.sleep(20000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			
			System.out.println("\n fine ciclo controllo auto \n\n-----------" );
			
			}

		}

	//simula il movimento dell'auto
	private void simulaVelPos() {
		
		automobile.setVelocita( new Random().nextInt(200) );
		posizione.setLatitudine( posizione.getLatitudine() + new Random().nextInt(4) );
		posizione.setLongitudine( posizione.getLongitudine() + new Random().nextInt(6) );
		
	}

	//simula un allarme
	private void simulaAllarme() {
		System.out.println("\n Inizio simulazione: \n\n-----------" );
		
		automobile.setStato(true);
		automobile.setVideo("https://www.youtube.com/?hl=it&gl=IT");
		
	}
	
}
