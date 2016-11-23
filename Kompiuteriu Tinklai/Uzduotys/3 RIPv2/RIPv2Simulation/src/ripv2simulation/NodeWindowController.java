/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ripv2simulation;

import java.util.ArrayList;
import javafx.beans.value.ObservableValue;
import javafx.fxml.FXML;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.util.Callback;
import ripv2simulation.Logic.Node;

/**
 * FXML Controller class
 *
 * @author Laimonas Beniušis
 */
public class NodeWindowController extends BaseController {
    public ArrayList<Node>  nodes;
    @FXML public TableView table;
    private ArrayList< TableColumn<Node, String>> columns;
    @Override
    public void exit() {
        ViewManager.getInstance().closeWindow(title);
    }
    @Override
    public void setUp(String title){
        super.setUp(title);
        nodes = new ArrayList<>();
        columns = new ArrayList<>();
        
        TableColumn<Node, String> nameCol = new TableColumn<>("Address");
        nameCol.setCellValueFactory(new Callback<TableColumn.CellDataFeatures<Node, String>, ObservableValue<String>>() {
            @Override
            public ObservableValue<String> call(TableColumn.CellDataFeatures<Node, String> cellData) {
                return cellData.getValue().propAddress;
            }
        });
        
        TableColumn<Node, String> statusCol = new TableColumn<>("Functional");
        statusCol.setCellValueFactory((TableColumn.CellDataFeatures<Node, String> cellData) -> cellData.getValue().isOperable.asString());
        TableColumn<Node, String> typeCol = new TableColumn<>("Type");
        typeCol.setCellValueFactory((TableColumn.CellDataFeatures<Node, String> cellData) -> cellData.getValue().porpType);

        columns.add(nameCol);
        columns.add(typeCol);
        columns.add(statusCol);
        this.table.getColumns().setAll(columns);
    }
    public void addNewNode(Node node){
        this.table.getItems().add(node);
    }
    public void clearAll(){
        nodes.clear();
        table.getItems().clear();
    }
    
//    public void run() {
//        Platform.runLater(()->{
//            Set<Node> network = NetworkGraph.getNetworkGraph();
//            int currentIteration = 0;
//
//            // Generate's initial routing table
//            node.table = new RoutingTable(node, network);
//
//            while(true){
//                try {
//                    /* If node has not failed, print table and 
//                       broadcast to neighbors */
//                    if(node.isOperable()){
//                        node.table.printTable(currentIteration);
//                        node.broadcast(node.table);
//                    }else{
//                        synchronized (System.out){
//                            System.out.println("\n" + node.getAddress() + " has failed!");	
//                            break;
//                        }
//                    }
//
//                    // Determine if the node has failed or not
//                    if(RIPSimulation.nodeFailureEnabled){
//                        node.tryToFail();
//                    }
//
//                    Thread.sleep(1000);
//                    currentIteration++;				
//                } catch (InterruptedException e) {
//                    e.printStackTrace();
//                }	
//            }	
//        });
//        
//    }

    
}
