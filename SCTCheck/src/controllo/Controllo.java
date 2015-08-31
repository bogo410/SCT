package controllo;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;

import relazioni.*;

public class Controllo {
	static List<Auto> parcoAuto;
	
	public static void main(String[] args) {
		
		System.out.println("\n Inizio controllo Server: \n\n-----------" );

		while(true){
			parcoAuto = Auto.getListaAuto();
			
			controlloAllarmi( parcoAuto );
			System.out.println("\n ciclo di controllo parco auto finito \n\n\n-----------" );
			
			try {
				Thread.sleep(4000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

	}

	private static void controlloAllarmi(List<Auto> parcoAuto2) {
		String messaggio;
		
		for (Auto auto : parcoAuto) {
			System.out.println("\n Controllo allarmi su: " + auto.getTarga());
			
			//controlla se è stato superato il limite di velocità da qualche auto
			if( auto.getVelocita() > auto.getLimite()){
				auto.updateModalita("Limit exceeded");
			}
			
			//controlla se ci sono allarmi e in caso positivo invia l'e-mail all'amministratore e al responsabile
			if( auto.getModalita().equals("Alarm received") || auto.getModalita().equals("Sending alarm") ){
				System.out.println("\n Trovato allarme su: " + auto.getTarga());
				String destinatari[] = { auto.getMailResp(), auto.getMailAdmin()};
				Vector<String> destinatari2 = new Vector<String> (2);	//
				destinatari2.add(auto.getMailResp());	//
				destinatari2.add(auto.getMailAdmin());	//
				
				messaggio =   "Attenzione! " 
							+ "\n\nRilevato Allarme auto: " + auto.getTarga() 
							+ " di tipo: " + auto.getModalita() + "."
							+ "\nPosizione Attuale: Latitudine = " + auto.getLatitudine().substring(0, 6) + " Longitudine = " + auto.getLongitudine().substring(0, 6)
							+ "\nVelocità: " + auto.getVelocita() + " km/h"
							+ "\nLimite Impostato: " + auto.getLimite() + " km/h"
							+ "\n\n";
				auto.updateModalita(auto.getModalita() + " (notified)");
				try {
					inviaMail(destinatari2, "Allarme auto: " + auto.getTarga(), messaggio);
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
	//funzione per l'invio di e-mail
	@SuppressWarnings("rawtypes")
	public static void inviaMail(Vector<String> destinatari, String subject, String message ) throws MessagingException
	{

		final String username = "safecartracking@gmail.com";
		final String password = "univr000";
		 
		// Impostazioni SMTP
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		 
		// istanzio un oggetto Session
		Session session = Session.getInstance(props,
				  new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(username, password);
					}
				  });
		 
		try {
			 
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(username));
			// Destinatari
			InternetAddress[] addressTo = new InternetAddress[destinatari.size()]; 

			int i=0;
			for ( Enumeration e = destinatari.elements(); e.hasMoreElements(); ){
				addressTo[i] = new InternetAddress( (String)e.nextElement() );
				i++;
			}
			
			msg.setRecipients(Message.RecipientType.TO, addressTo);
			    			
			msg.setSubject(subject);
			msg.setText(message);
 
			Transport.send(msg);
 
			System.out.println("Done");
 
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	
}
