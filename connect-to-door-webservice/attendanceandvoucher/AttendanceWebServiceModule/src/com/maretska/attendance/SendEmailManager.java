package com.maretska.attendance;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmailManager {
	private String SMTP_HOST = "smtp.gmail.com";
	private String FROM_ADDRESS = "voucher.approval@photoninfotech.net";
	private String PASSWORD = "aS3ve$Fo";
	private String FROM_NAME = "MKT - Leave Control and Voucher System";

	public boolean sendMail(String[] recipients, String[] bccRecipients, String subject, String message) {  
		try {  
			Properties props = new Properties();  
			props.put("mail.smtp.host", SMTP_HOST);  
			props.put("mail.smtp.auth", "true");  
			props.put("mail.debug", "false");  
			props.put("mail.smtp.ssl.enable", "true");  

			Session session = Session.getInstance(props, new SocialAuth());  
			Message msg = new MimeMessage(session);  

			InternetAddress from = new InternetAddress(FROM_ADDRESS, FROM_NAME);  
			msg.setFrom(from);  

			InternetAddress[] toAddresses = new InternetAddress[recipients.length];  
			for (int i = 0; i < recipients.length; i++) {  
				toAddresses[i] = new InternetAddress(recipients[i]);  
			}  
			msg.setRecipients(Message.RecipientType.TO, toAddresses);  


			InternetAddress[] bccAddresses = new InternetAddress[bccRecipients.length];  
			for (int j = 0; j < bccRecipients.length; j++) {  
				bccAddresses[j] = new InternetAddress(bccRecipients[j]);  
			}  
			msg.setRecipients(Message.RecipientType.BCC, bccAddresses);  

			msg.setSubject(subject);  
			msg.setContent(message, "text/plain");  
			Transport.send(msg);  
			return true;  
		} catch (UnsupportedEncodingException ex) {  
			return false;  

		} catch (MessagingException ex) {  
			return false;  
		}  
	}  

	class SocialAuth extends Authenticator {  

		@Override  
		protected PasswordAuthentication getPasswordAuthentication() {  

			return new PasswordAuthentication(FROM_ADDRESS, PASSWORD);  

		}  
	}  

}
