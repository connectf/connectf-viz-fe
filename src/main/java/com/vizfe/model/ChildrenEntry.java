package com.vizfe.model;

/**
 * Created by kzkaizhao on 2016/1/14.
 */
public class ChildrenEntry
{
    String id;
    String text = "";

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

    public ChildrenEntry(String id, String name) {
        this.id = id;
        this.text += "<div id='"+id+"' name='"+name+"' class='item'>"+name+"</div>";
    }
}