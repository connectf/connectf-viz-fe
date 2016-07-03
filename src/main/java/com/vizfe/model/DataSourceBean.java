package com.vizfe.model;

/**
 * Created by sonny on 2015/12/28.
 */
public class DataSourceBean {

    private String dataSourceId;

    private String dataSourceName;

    private String dataSourceDesc;

    public DataSourceBean(){}

    public String getDataSourceDesc() {
        return dataSourceDesc;
    }

    public void setDataSourceDesc(String dataSourceDesc) {
        this.dataSourceDesc = dataSourceDesc;
    }

    public String getDataSourceId() {
        return dataSourceId;
    }

    public void setDataSourceId(String dataSourceId) {
        this.dataSourceId = dataSourceId;
    }

    public String getDataSourceName() {
        return dataSourceName;
    }

    public void setDataSourceName(String dataSourceName) {
        this.dataSourceName = dataSourceName;
    }

}
