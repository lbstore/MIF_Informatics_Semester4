/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ripv2simulation;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import javafx.fxml.FXML;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyCode;
import ripv2simulation.Logic.NetworkGraph;
import ripv2simulation.Logic.Node;
import ripv2simulation.Logic.PingInfo;

/**
 *
 * @author Laimonas Beniušis
 */
public class AdminWindowController extends BaseController {

    
    @FXML ListView consoleList;
    @FXML TextField textField;
    private static ObservableList<String> list = FXCollections.observableArrayList();
    //private ArrayList<String> stringList = new ArrayList<>();
    //private LinkedList<String> commandHistory = new LinkedList<>();
    private AbstractCommandField field;
    @Override
    public void setUp(String title){
        this.title = title;
        consoleList.setItems(list);
        field = new AbstractCommandField(textField) {
            @Override
            public void submit(String command){
                addLine("$ "+command);
                parseCommand(command);
            }
        };
        
        
    }
    @Override
    public void exit() {
        ViewManager.getInstance().closeWindow(title);
    }
    public static void addLine(String...strings){
        AdminWindowController.list.addAll(Arrays.asList(strings));
    }
    public static void parseCommand(String com){
        if(com.startsWith("exit")){
            System.exit(0);
        }else if(com.startsWith("help")){
            System.out.println("Commands:");
            System.out.println("help");
            System.out.println("generate [(integer)numberOfPairs]");
            System.out.println("start [(double) 0..1 chanceToFail] 1 = 100%");
            System.out.println("topology");
            System.out.println("reset");
            System.out.println("cancel");
            System.out.println("ping [nodeAddress] [nodeAddress]");
            System.out.println("exit");
            
        }else if(com.startsWith("generate")){
            com = com.replace("generate ", "");
            int numNodePairs = 2;
            try{
                numNodePairs = Integer.valueOf(com);
            }catch(Exception e){}
            NetworkGraph.newNetworkGraph(numNodePairs);
            System.out.println("Generated Network Topology: [" + NetworkGraph.networkGraph.size()+"]");
            System.out.print(NetworkGraph.getString());
            NodeWindowController controller = (NodeWindowController) ViewManager.getInstance().getNodeWindow().getController();
            controller.clearAll();
            for(Node node : NetworkGraph.getNetworkGraph().values()){
                    ViewManager.getInstance().addNode(node);
                }
        }else if(com.startsWith("reset")){
            for(Node node : NetworkGraph.getNetworkGraph().values()){
                node.isOperable.set(true);
            }
        }else if(com.startsWith("down")){
            com = com.replace("down ", "");
            NetworkGraph.getNetworkGraph().get(com).isOperable.set(false);
        }else if(com.startsWith("topology")){
            System.out.println("Generated Network Topology: [" + NetworkGraph.networkGraph.size()+"]");
            System.out.print(NetworkGraph.getString());
        }else if(com.startsWith("cancel")){
            Node.canceled.set(true);
        }else if(com.startsWith("ping")){{
            try{
                com = com.replace("ping ", "");
                String[] split = com.split(" ");
                String n1 = split[0];
                String n2 = split[1];
                NetworkGraph.getNetworkGraph();

                ArrayList<PingInfo> pings = new ArrayList<>();
                Node start = NetworkGraph.getNetworkGraph().get(n1);
                ArrayList<String> newList = new ArrayList<>();
                start.ping(n2, new PingInfo(newList,0,0,false), pings,0);
                Iterator<PingInfo> iterator = pings.iterator();
                while(iterator.hasNext()){
                    PingInfo info = iterator.next();
                    if((!info.found)||(info.hopCount>15)){
                        iterator.remove();
                    }
                }
                pings.sort(PingInfo.cmpAsc);
                if(pings.size()>0){
                    System.out.println(pings.get(0).toString());
                }else{
                    System.out.println("Failed to find path");
                }
            }catch (Exception ex){}
            
        }
        }else if(com.startsWith("start")){
            com = com.replace("start ", "");
            Double failureChance = 0.20;
            try{
                failureChance = Double.valueOf(com);

            }catch(Exception e){}
                for(Node node : NetworkGraph.getNetworkGraph().values()){
                    node.failChance = failureChance;
                }
            final double failureChanceFinal = failureChance;
            
            Task<Void> task = new Task<Void>() {
                
                @Override
                protected Void call() throws Exception {
                    
                    List<Thread> routerThreads = new ArrayList<>();
            
                    try{
                        long startTime = Calendar.getInstance().getTimeInMillis();
                        System.out.println("\nBeginning Simulation"+" Failure Rate:"+failureChanceFinal);
                        Thread.sleep(2000);
                        for(Node node : NetworkGraph.getNetworkGraph().values()){
                            Thread curRouter = new Thread(node);
                            routerThreads.add(curRouter);
                        }
                        for(Thread curThread : routerThreads){
                            curThread.start();
                        }
                        for(Thread curThread : routerThreads){
                            curThread.join();
                        }
                        if(Node.canceled.get()){
                            this.cancel();
                            System.out.println("Canceled");
                        }else{
                            System.out.println("\nRouters failed. Simulation terminated.");
                            long endTime = Calendar.getInstance().getTimeInMillis();
                            System.out.println("Finished in "+(double)(endTime-startTime)/1000);
                        }
                    }catch (InterruptedException e){
                            e.printStackTrace();
                    }
                    Node.canceled.setValue(false);
                    
                    return null;
                }
            };

            new Thread(task).start();
        }
    }
    
}
