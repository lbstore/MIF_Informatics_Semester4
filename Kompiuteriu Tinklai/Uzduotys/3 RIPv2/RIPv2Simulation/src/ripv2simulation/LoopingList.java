/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ripv2simulation;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.ListIterator;

/**
 *
 * @author Laimonas Beniušis
 */
public class LoopingList<T> extends LinkedList<T>{
    public int index=-1;
    public <T> LoopingList(){
        super();
        
    }
    public T next(){
        if(!this.isEmpty()){
            index++;
            index %= size();
            return this.get(index);
        }else{
            return null;
        }
    }
    public T prev(){
        if(!this.isEmpty()){
            index--;
            if(index<0){
                index = size()-1;
            }
            return this.get(index);
        }else{
            return null;
        }
    }
}
