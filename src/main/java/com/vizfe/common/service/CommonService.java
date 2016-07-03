package com.vizfe.common.service;

import com.vc.vizcore.entity.EntityManagerService;
import com.vc.vizcore.entity.local.AttributeUserLocal;
import com.vc.vizcore.entity.local.AttributeUserLocalProperties;
import com.vc.vizcore.entity.share.DataCategory;
import com.vc.vizcore.entity.share.DataSet;
import com.vc.vizcore.entity.share.DataSource;
import com.vc.vizcore.executor.TableauExecutorService;
import com.vc.vizcore.frontend.AttributeFilter;
import com.vc.vizcore.frontend.FunctionedAttributeId;
import com.vc.vizcore.frontend.VizGraphSupported;
import com.vc.vizcore.frontend.VizResult;
import com.vizfe.common.dao.CommonDao;

import java.util.Vector;

/**
 * Created by sonny on 2015/12/8.
 */
public class CommonService implements CommonDao {

    private EntityManagerService service = new EntityManagerService();
    private TableauExecutorService tservice = new TableauExecutorService();

    /**
     * getUserIdByUserName
     * @param userName
     * @return
     * @throws Exception
     */
    public String getUserIdByUserName(String userName) throws Exception {
        return service.getUserIdByUserName(userName);
    }

    /**
     * getDataSourcesByUser
     * @param userId
     * @return
     */
    public Vector<DataSource> getDataSourcesByUser(String userId) {
        return service.getDataSourcesByUser(userId);
    }

    /**
     * getDataSetsByUser
     * @param userId
     * @param dataSourceId
     * @return
     */
    public Vector<DataSet> getDataSetsByUser(String userId, String dataSourceId) {
        return service.getDataSetsByUser(userId,dataSourceId);
    }

    /**
     * getAttributeUserLocals4DataSet
     * @param userId
     * @param dataSourceId
     * @param dataSetId
     * @return
     */
    public Vector<AttributeUserLocal> getAttributeUserLocals4DataSet(String userId, String dataSourceId, String dataSetId) {
        return service.getAttributeUserLocals4DataSet(userId,dataSourceId,dataSetId);
    }

    /**
     * updateAttributeUserLocalByUser
     * @param userId
     * @param dataSourceId
     * @param dataSetId
     * @param attributeId
     * @param properties
     * @return
     */
    public boolean updateAttributeUserLocalByUser(String userId, String dataSourceId, String dataSetId, String attributeId, AttributeUserLocalProperties properties) {
        return service.updateAttributeUserLocalByUser(userId,dataSourceId,dataSetId,attributeId,properties);
    }

    /**
     * getVizGraphSupported
     * @param userId
     * @param dataSourceId
     * @param dataSetId
     * @param columnAttributeIds
     * @param rowAttributeIds
     * @return
     */
    public VizGraphSupported getVizGraphSupported(String userId, String dataSourceId, String dataSetId, Vector<FunctionedAttributeId> columnAttributeIds, Vector<FunctionedAttributeId> rowAttributeIds) {
        return tservice.getVizGraphSupported(userId,dataSourceId,dataSetId,columnAttributeIds,rowAttributeIds);
    }

    /**
     * execute
     * @param userId
     * @param dataSourceId
     * @param dataSetId
     * @param vizGraphType
     * @param columnAttributeIds
     * @param rowAttributeIds
     * @param filters
     * @return
     */
    public VizResult execute(String userId, String dataSourceId, String dataSetId, String vizGraphType, Vector<FunctionedAttributeId> columnAttributeIds, Vector<FunctionedAttributeId> rowAttributeIds, Vector<AttributeFilter> filters) {
        return tservice.execute(userId,dataSourceId,dataSetId,vizGraphType,columnAttributeIds,rowAttributeIds,filters);
    }

    /**
     * getDataCategories
     * @return
     * @throws Exception
     */
    public Vector<DataCategory> getDataCategories() throws Exception {
        return service.getDataCategories();
    }
}
