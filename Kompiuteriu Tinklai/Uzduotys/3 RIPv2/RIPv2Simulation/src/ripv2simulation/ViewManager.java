/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ripv2simulation;



import java.util.HashMap;
import javafx.application.Platform;

import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;

/**
 *
 * @author lemmin
 */
public class ViewManager {
    private final String WINDOW_TITLE = "Node ";
    private final String WORKER_TITLE ="Darbuotojas ";
    private final String ADMIN_TITLE ="Admin ";
    private final String TABLE_TITLE="Lentele ";
    private final String nodeWindowTitle = "Nodes";
    private static final ViewManager INSTANCE = new ViewManager();
    private ViewManager(){
        this.windows = new HashMap<>();
    };
    public HashMap<String,Frame> windows;

    public static ViewManager getInstance(){
        return INSTANCE;
    }
    private int findSmallestAvailable(HashMap<String,Frame> map,String title){
        int i =1;
        while(true){
            if(map.containsKey(title + i)){
                i++;
            }else{
                return i;
            }
        }
    }
    
// WINDOW ACTIONS
    
    public void newNodeWindow(){
        if(windows.containsKey(nodeWindowTitle)){
            return;
        }
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("NodeWindow.fxml"));
            Parent root = loader.load();
            NodeWindowController controller = loader.<NodeWindowController>getController();
            Stage stage = new Stage();
            stage.setTitle(nodeWindowTitle);
            stage.setScene(new Scene(root));
            stage.setOnCloseRequest((WindowEvent we) -> {
                controller.exit();
                
            });
            Frame frame = new Frame(stage,controller);
            windows.put(frame.getTitle(),frame);
            controller.setUp(stage.getTitle());
            stage.show();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
    }
    public void addNode(ripv2simulation.Logic.Node node){
        NodeWindowController controller = (NodeWindowController) getNodeWindow().getController();
        controller.addNewNode(node);
    }
    public Frame getNodeWindow(){
        return windows.get(nodeWindowTitle);
    }
    public void newAdminWindow(){
        try {
            int index = findSmallestAvailable(windows,ADMIN_TITLE);
            
            
            FXMLLoader loader = new FXMLLoader(getClass().getResource("AdminWindow.fxml"));
            Parent root = loader.load();
            AdminWindowController controller = loader.<AdminWindowController>getController();
            Stage stage = new Stage();
            stage.setTitle(ADMIN_TITLE+index);
            stage.setScene(new Scene(root));
            stage.setOnCloseRequest((WindowEvent we) -> {
                controller.exit();
            });
            Frame frame = new Frame(stage,controller);
            windows.put(frame.getTitle(),frame);
            stage.show();
            controller.setUp(stage.getTitle());
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
    }

    public void closeWindow(String title){
        windows.get(title).getStage().close();
        windows.remove(title);
        if(windows.isEmpty()){
            Platform.exit();
        }
    }
    public void closeAllWindows(){
        String[] keys = windows.keySet().toArray(new String[0]);
        for(String s:keys){
            closeWindow(s);
        }
    }

}
