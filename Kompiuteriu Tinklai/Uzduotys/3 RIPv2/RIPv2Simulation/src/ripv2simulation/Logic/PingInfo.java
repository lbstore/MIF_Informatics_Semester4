/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ripv2simulation.Logic;

import java.util.ArrayList;
import java.util.Comparator;

/**
 *
 * @author Laimonas Beniušis
 */
public class PingInfo {
    public ArrayList<String> path;
    public int metric;
    public int hopCount;
    public boolean found;
    public PingInfo(ArrayList<String> list,int met, int hop,boolean f){
        this.path = new ArrayList<>();
        path.addAll(list);
        metric = met;
        hopCount = hop;
        this.found = f;
    }
    public PingInfo(PingInfo pi){
        this.path = new ArrayList<>();
        path.addAll(pi.path);
        metric = pi.metric;
        hopCount = pi.hopCount;
        found = pi.found;
    }
    @Override
    public String toString(){
        String s = "Metric:"+metric+" Hop Count:"+hopCount +" [";
        for(String pa:path){
            
            Node get = NetworkGraph.getNetworkGraph().get(pa);
            s+=get.getAddress()+" "+get.getType()+",";
        }
        s = s.substring(0,s.length()-1);
        s +="]";
        return s;
    }
    public static final Comparator<PingInfo> cmpAsc = (PingInfo f1, PingInfo f2) -> {
        return Integer.compare(f1.metric, f2.metric);
    };
}
