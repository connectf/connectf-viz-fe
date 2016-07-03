package com.vizfe.common.dao;

import com.vc.vizcore.entity.local.AttributeUserLocal;
import com.vc.vizcore.entity.local.AttributeUserLocalProperties;
import com.vc.vizcore.entity.share.DataCategory;
import com.vc.vizcore.entity.share.DataSet;
import com.vc.vizcore.entity.share.DataSource;
import com.vc.vizcore.entity.share.User;
import com.vc.vizcore.frontend.*;

import java.util.Vector;

/**
 * Created by sonny on 2015/12/8.
 */
public interface CommonDao {

    public String getUserIdByUserName(String userName) throws Exception;

    /*the following step 1~5 are encapsulated inside of EntityManagerService*/
    /**
     * step 1: given a userid, return the datasources accessed by this user
     * @param userId
     * @return
     */
    public Vector<DataSource> getDataSourcesByUser(String userId) throws Exception;


    /**
     * step 2: given the userid + datasoruceid, return the data set accessed by this user under this data source
     * @param userId
     * @param dataSourceId
     * @return
     */
    public Vector<DataSet> getDataSetsByUser(String userId, String dataSourceId)throws Exception;


    /**
     * step 3: list the attributes for certain dataset of the userid+datasourceid+datasetid
     * @param userId
     * @param dataSourceId
     * @param dataSetId
     * @return
     */
    public Vector<AttributeUserLocal> getAttributeUserLocals4DataSet(String userId, String dataSourceId, String dataSetId)throws Exception;


    /**
     * step 4: user can modify(pushdown) the properties of the attribute(select dimension/measurement, or ,set the attribute's category)
     * call this inteface to update the modifications.
     * @param userId
     * @param dataSourceId
     * @param dataSetId
     * @param attributeId
     * @param properties
     * @return
     */
    public boolean updateAttributeUserLocalByUser(String userId,String dataSourceId, String dataSetId, String attributeId, AttributeUserLocalProperties properties)throws Exception;

    /**
     * step 5:  in tableau, for the left tree, call the getAttributeUserLocals4DataSet(the same as step 3) again, to display the tree of the attributes accroding to the dimension or mesurement.
     */


    /*Now, wre are going to the tableau processing, by calling TableauExecutorService*/

    /**
     * step 6: give the row and column selected by user, return the graphs(list) supported by the combination of row and column.
     * @return
     */
    public VizGraphSupported getVizGraphSupported(String userId,
                                               String dataSourceId,
                                               String dataSetId,
                                               Vector<FunctionedAttributeId> columnAttributeIds,
                                               Vector<FunctionedAttributeId> rowAttributeIds)throws Exception;

    /**
     * step 7: now, user wants to get the visualization of  [row, column, filter, graphtype), and return the graphs.
     * @return
     */
    public VizResult execute(String userId,
                             String dataSourceId,
                             String dataSetId,
                             String vizGraphType,
                             Vector<FunctionedAttributeId> columnAttributeIds,
                             Vector<FunctionedAttributeId> rowAttributeIds,
                             Vector<AttributeFilter> filters)throws Exception;

    public Vector<DataCategory> getDataCategories() throws Exception;
}
