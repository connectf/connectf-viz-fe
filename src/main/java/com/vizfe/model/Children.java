package com.vizfe.model;

import java.util.Vector;

/**
 * Created by kzkaizhao on 2016/1/14.
 */
public class Children
{
    private String id;
    private String text;
    private Vector<ChildrenEntry> children;

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

    public Vector<ChildrenEntry> getChildren() {
        return children;
    }

    public void setChildren(Vector<ChildrenEntry> children) {
        this.children = children;
    }

    public Children(String id, String text, Vector<ChildrenEntry> children) {
        this.id = id;
        this.text = text;
        this.children = children;
    }
}