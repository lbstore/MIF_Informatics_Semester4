/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import javafx.application.Platform;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;

/**
 *
 * @author Laimonas Beniušis
 */
public class ConnectionToIRC {
    public Socket socket;
    public BufferedWriter writer;
    public BufferedReader reader;
    public String channel;
    public String nick;
    public String login;
    public Task thread;
    public String allTheText;
    public ObservableList<String> list;
    public ConnectionToIRC(String server,String login,String channel) throws Exception{
        list = FXCollections.observableArrayList();
        this.socket = new Socket(server,6667); 
        writer = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
        reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));

        writer.write("NICK " + login + "\r\n");
        writer.write("USER " + login + " 8 * : Java IRC Hacks Bot\r\n");
        writer.flush( );
        System.out.println("Passed connection");
            
           

        String line = null;
        while ((line = reader.readLine( )) != null) {
            if (line.indexOf("004") >= 0) {
                // We are now logged in.
                break;
            }
            else if (line.indexOf("433") >= 0) {
                System.out.println("Nickname is already in use.");
                return;
            }
        }
        
        System.out.println("Passed log in");
        writer.write("JOIN" + channel+"\r\n");
        writer.flush();
        System.out.println("Passed join");
        this.channel = channel;
        Platform.runLater(() ->{
                try {
                    String ln = null;
                    while ((ln = reader.readLine( )) != null) {
                        if (ln.toLowerCase( ).startsWith("PING ")) {
                            // We must respond to PINGs to avoid being disconnected.
                            writer.write("PONG " + ln.substring(5) + "\r\n");
                            writer.write("PRIVMSG " + channel + " :I got pinged!\r\n");
                            writer.flush( );

                        }
                        else {
                            // Print the raw line received by the bot.
                            System.out.println(ln);
                            allTheText +="\n"+ln;
                            list.add(ln);
                            
                        }
                    }
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
                System.out.println("END THREAD");
            });
        
        
        
    }

    

            
  
    
    
    
}
//             The server to connect to and our details.


//        String server = "irc.freenode.net";
//        String nick = "simple_bot";
//        String login = "simple_bot";
//
//        // The channel which the bot will join.
//        String channel = "#irchacks";
//        
//        // Connect directly to the IRC server.
//        Socket socket = new Socket(server, 6667);
//        BufferedWriter writer = new BufferedWriter(
//                new OutputStreamWriter(socket.getOutputStream( )));
//        BufferedReader reader = new BufferedReader(
//                new InputStreamReader(socket.getInputStream( )));
//        
//        // Log on to the server.
//        writer.write("NICK " + nick + "\r\n");
//        writer.write("USER " + login + " 8 * : Java IRC Hacks Bot\r\n");
//        writer.flush( );
//        
//        // Read lines from the server until it tells us we have connected.
//        String line = null;
//        while ((line = reader.readLine( )) != null) {
//            if (line.contains("004")) {
//                // We are now logged in.
//                break;
//            }
//            else if (line.contains("433")) {
//                System.out.println("Nickname is already in use.");
//                return;
//            }
//        }
//        
//        // Join the channel.
//        System.out.println("Join channel");
//        writer.write("JOIN " + channel + "\r\n");
//        writer.flush( );
//        writer.write("Hello");
//        // Keep reading lines from the server.
//        Platform.runLater(() ->{
//            
//            try {
//                String linen = null;
//                while ((linen = reader.readLine( )) != null) {
//                    if (linen.toLowerCase( ).startsWith("PING ")) {
//                        // We must respond to PINGs to avoid being disconnected.
//                        writer.write("PONG " + linen.substring(5) + "\r\n");
//                        writer.write("PRIVMSG " + channel + " :I got pinged!\r\n");
//                        writer.flush( );
//                        
//                    }
//                    else {
//                        // Print the raw line received by the bot.
//                        System.out.println(linen);
//                    }
//                }   } catch (IOException ex) {
//                ex.printStackTrace();
//            }
//        });
//    