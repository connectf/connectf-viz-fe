package com.vizfe.model;

import com.google.gson.Gson;

import java.util.Vector;

/**
 * Created by kzkaizhao on 2016/1/14.


 var treeJsonDataArray = [{
 "id":1,
 "text":"数据集名字",
 "children":[{
 "id":11,
 "text":"Dimension",
 "children":[{
 "id":111,
 "text":"<div id='friend' name='friend' class='item'>friend</div>"
 },{
 "id":112,
 "text":"<div id='wife' name='wife' class='item'>wife</div>"
 },{
 "id":113,
 "text":"<div id='company' name='company' class='item'>company</div>"
 }]
 },
 {
 "id":21,
 "text":"Measurement",
 "children":[{
 "id":211,
 "text":"<div id='friend' name='friend' class='item'>friend</div>"
 },{
 "id":212,
 "text":"<div id='wife' name='wife' class='item'>wife</div>"
 },{
 "id":213,
 "text":"<div id='company' name='company' class='item'>company</div>"
 }]
 }]
 }];


 *
 */
public class TreeEntry {

    private String id;
    private String text;
    private Vector<Children> children = new Vector<Children>();

    public TreeEntry(String id, String text, Vector<Children> children) {
        this.id = id;
        this.text = text;
        this.children = children;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Vector<Children> getChildren() {
        return children;
    }

    public void setChildren(Vector<Children> children) {
        this.children = children;
    }

    public static void main(String[] args)
    {
        ChildrenEntry childrenEntry1 = new ChildrenEntry("211","friend");
        ChildrenEntry childrenEntry2 = new ChildrenEntry("212","wife");
        ChildrenEntry childrenEntry3 = new ChildrenEntry("213","company");

        Vector<ChildrenEntry> children = new Vector<ChildrenEntry>();
        children.add(childrenEntry1);
        children.add(childrenEntry2);
        children.add(childrenEntry3);


        Children childrenx = new Children("21","Dimension",children);
        Children childreny = new Children("22","Measurement",children);


        Vector<Children> childrenz = new Vector<Children>();
        childrenz.add(childrenx);
        childrenz.add(childreny);


        TreeEntry treeEntry = new TreeEntry("1","数据集名称",childrenz);

        // the final result
        Vector<TreeEntry> v = new Vector<TreeEntry>();

        v.add(treeEntry);
        Gson gson = new Gson();

        System.out.println(gson.toJson(v));

    }

}
