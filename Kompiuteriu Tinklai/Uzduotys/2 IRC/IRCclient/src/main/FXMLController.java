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
import java.net.URL;
import java.util.ResourceBundle;
import javafx.application.Platform;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;
import javafx.scene.text.Text;

/**
 * FXML Controller class
 *
 * @author Laimonas Beniušis
 */
public class FXMLController implements Initializable {

    
    @FXML public TextField server;
    @FXML public TextField channel;
    @FXML public TextField nick;
    @FXML public ListView list;
    @FXML public TextField message;
    
    public Socket socket;
    public BufferedWriter writer;
    public BufferedReader reader;
    String serverLoc = "irc.freenode.net";
    String nickLoc = "simple_bot";
    String loginLoc = "simple_bot";
    String channelLoc = "#irchacks";
    public Task thread;
    public String allTheText;
    public ObservableList<String> textList;
    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
            textList = FXCollections.observableArrayList();
            //list.getItems().setAll(textList);
        
    }
    public void connect() throws IOException{
        
        if(socket != null){
            socket.close();
        }
        serverLoc = server.getText().trim();
        channelLoc = "#"+channel.getText().trim();
        loginLoc = nick.getText().trim();
        nickLoc = nick.getText().trim();
        
        System.out.println("PARAMETERS");
        System.out.println("<"+serverLoc+">");
        System.out.println("<"+channelLoc+">");
        System.out.println("<"+loginLoc+">");
        System.out.println("<"+nickLoc+">");
        
        socket = new Socket(serverLoc,6667); 
        writer = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
        reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));

        writer.write("NICK " + loginLoc + "\r\n");
        writer.write("USER " + loginLoc + " 8 * : Java IRC Hacks Bot\r\n");
        writer.flush();
        System.out.println("Passed connection");
            
           

        String line = null;
        while ((line = reader.readLine( )) != null) {
            if (line.contains("004")) {
                // We are now logged in.
                break;
            }
            else if (line.contains("433")) {
                this.addToList("Nickname is already in use.");
                System.out.println("Nickname is already in use.");
                return;
            }
        }
        
        System.out.println("Passed log in");
        writer.write("JOIN " + channelLoc +"\r\n");
        writer.flush();
        System.out.println("Passed join");
        
            Task<Void> task = new Task<Void>() {
            @Override
            protected Void call() throws Exception {
            
                String ln = null;
                while ((ln = reader.readLine( )) != null) {
                    if(!socket.isConnected()){
                        addToList("Session closed");
                        return null;
                    }
                    Thread.sleep(1);
                    if (ln.toUpperCase( ).startsWith("PING ")) {
                        // We must respond to PINGs to avoid being disconnected.
                        writer.write("PONG " + ln.substring(5) + "\r\n");
                        writer.write("PRIVMSG " + channelLoc + " :I got pinged!\r\n");
                        writer.flush( );

                    }
                    else {
                        // Print the raw line received by the bot.
                        System.out.println(ln+"  "+textList.size());
                        addToList(ln);
                        
                        
                        
                        
                    }
                }
                return null;
            }
        };
        Platform.runLater(()->{
            Thread t = new Thread(task);
            t.setDaemon(true);
            t.start();
        });
        
           
    }
    public void writeMsg() throws IOException{
            
        String msg = message.getText();
        message.clear();
        if(!msg.startsWith("/")){

            writer.write("PRIVMSG " + channelLoc + " "+ msg+"\r\n");
            
            addToList(nickLoc+": "+msg);
        }else{
            writer.write( msg.substring(1)+" "+channelLoc+"\r\n");
        }
        writer.flush();
    }
    private void addToList(String ln){
        
        Platform.runLater(()->{
            allTheText +="\n"+ln;
            textList.add(ln);
            list.getItems().setAll(textList);
        });
    }
    
    
}
