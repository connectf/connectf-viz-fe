package com.vizfe.common.controller;

import com.google.gson.Gson;
import com.vc.vizcore.entity.SystemEntityManager;
import com.vc.vizcore.entity.local.AttributeUserLocal;
import com.vc.vizcore.entity.share.DataCategory;
import com.vc.vizcore.entity.share.DataSet;
import com.vc.vizcore.entity.share.DataSource;
import com.vc.vizcore.frontend.VizGraphSupported;
import com.vc.vizcore.frontend.VizResult;
import com.viz.protocol.*;
import com.vizfe.common.dao.CommonDao;
import com.vizfe.common.service.CommonService;
import org.apache.log4j.Logger;
import org.springframework.http.MediaType;
import org.springframework.http.StreamingHttpOutputMessage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Vector;

/**
 * Created by sonny on 2015/12/8.
 */

public class CommonController {

    private static final Logger logger = Logger.getLogger(CommonController.class);
    private CommonDao commonDao = new CommonService();
    private Gson gson = new Gson();

    /**
     * get user info by user name
     * @return
     * @throws IOException
     */

    public Response getUserIdByUserName( GetUserIdByUserNameReq getUserIdByUserNameReq) throws IOException {

        GetUesrIdByUserNameResp getUesrIdByUserNameResp = null;

        String userName = getUserIdByUserNameReq.getUserName();
        String userId = "";
        try {
            userId = commonDao.getUserIdByUserName(userName);
            getUesrIdByUserNameResp = new GetUesrIdByUserNameResp(userName,userId);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("error in CommonController::getUserIdByUserName", e);
            getUesrIdByUserNameResp = new GetUesrIdByUserNameResp(-1, e.getMessage());
        }

        return getUesrIdByUserNameResp;
    }
    /**
     * getDataSourcesByUserId
     * @return
     */

    public Response getDataSourcesByUserId(GetDataSourcesByUserReq getDataSourcesByUserReq){

        GetDataSourcesByUserResp getDataSourcesByUserResp = null;

        Vector<DataSource> dataSources = null;
        try {
            dataSources = commonDao.getDataSourcesByUser(getDataSourcesByUserReq.getUserId());
            getDataSourcesByUserResp = new GetDataSourcesByUserResp(dataSources);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("error in CommonController::getDataSourcesByUserId", e);
            getDataSourcesByUserResp = new GetDataSourcesByUserResp(-1,e.getMessage());
        }
        return getDataSourcesByUserResp;
    }

    /**
     * getDataSetsById
     * @return
     */

    public Response getDataSetsById(GetDataSetsByUserReq getDataSetsByUserReq){
        GetDataSetsByUserResp getDataSetsByUserResp = null;
        Vector<DataSet> dataSets = null;
        try {
            dataSets = commonDao.getDataSetsByUser(getDataSetsByUserReq.getUserId(),getDataSetsByUserReq.getDataSourceId());
            getDataSetsByUserResp = new GetDataSetsByUserResp(dataSets);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("error in CommonController::getDataSetsById", e);
            getDataSetsByUserResp = new GetDataSetsByUserResp(-1,e.getMessage());
        }
        return getDataSetsByUserResp;
    }

    /**
     * getAttributeUserLocals4DataSet
     * @return
     */

    public Response getAttributeUserLocals4DataSet(GetAttributeUserLocals4DataSetReq getAttributeUserLocals4DataSetReq){
        GetAttributeUserLocals4DataSetResp getAttributeUserLocals4DataSetResp = null;
        Vector<AttributeUserLocal> attributeUserLocals = null;
        try {
            attributeUserLocals = commonDao.getAttributeUserLocals4DataSet(getAttributeUserLocals4DataSetReq.getUserId(),getAttributeUserLocals4DataSetReq.getDataSourceId(),getAttributeUserLocals4DataSetReq.getDataSetId());
            getAttributeUserLocals4DataSetResp = new GetAttributeUserLocals4DataSetResp(attributeUserLocals);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("error in CommonController::getAttributeUserLocals4DataSet", e);
            getAttributeUserLocals4DataSetResp = new GetAttributeUserLocals4DataSetResp(-1,e.getMessage());
        }

        return getAttributeUserLocals4DataSetResp;
    }

    /**
     * updateAttributeUserLocalByUser
     * @return
     * @throws UnsupportedEncodingException
     */

    public Response updateAttributeUserLocalByUser(UpdateAttributeUserLocalByUserReq updateAttributeUserLocalByUserReq) throws UnsupportedEncodingException {
        UpdateAttributeUserLocalByUserResp updateAttributeUserLocalByUserResp = null;
        Boolean result = true;
        try {

            result = commonDao.updateAttributeUserLocalByUser(updateAttributeUserLocalByUserReq.getUserId(),
                    updateAttributeUserLocalByUserReq.getDataSourceId(),
                    updateAttributeUserLocalByUserReq.getDataSetId(),
                    updateAttributeUserLocalByUserReq.getAttributeId(),
                    updateAttributeUserLocalByUserReq.getProperties());
            updateAttributeUserLocalByUserResp = new UpdateAttributeUserLocalByUserResp();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("error in CommonController::updateAttributeUserLocalByUser", e);
            updateAttributeUserLocalByUserResp = new UpdateAttributeUserLocalByUserResp(-1,e.getMessage());
        }
        return updateAttributeUserLocalByUserResp;
    }

    /**
     * getDataCategories
     * @return
     */
    public Response getDataCategories(GetDataCategoryReq getDataCategoryReq) {
        GetDataCategoryResp getDataCategoryResp = null;
        Vector<DataCategory> lists = null;
        try{
            lists = commonDao.getDataCategories();
            getDataCategoryResp = new GetDataCategoryResp(lists);
        }catch (Exception e){
            e.printStackTrace();
            logger.error("error in CommonController::getDataCategories", e);
            getDataCategoryResp = new GetDataCategoryResp(-1,e.getMessage());
        }

        return getDataCategoryResp;
    }


    /**
     * getVizGraphSupported
     * @return
     */
    public Response getVizGraphSupported(GetVizGraphSupportedReq getVizGraphSupportedReq){
        GetVizGraphSupportedResp getVizGraphSupportedResp = null;
        VizGraphSupported vizGraphSupported = null;
        try {
            vizGraphSupported = commonDao.getVizGraphSupported(getVizGraphSupportedReq.getUserId(),
                    getVizGraphSupportedReq.getDataSourceId(),
                    getVizGraphSupportedReq.getDataSetId(),
                    getVizGraphSupportedReq.getColumnAttributeIds(),
                    getVizGraphSupportedReq.getRowAttributeIds());
            getVizGraphSupportedResp = new GetVizGraphSupportedResp(vizGraphSupported);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("error in CommonController::getVizGraphSupported", e);
            getVizGraphSupportedResp = new GetVizGraphSupportedResp(-1,e.getMessage());
        }

        return getVizGraphSupportedResp;
    }

    /**
     * execute
     * @return
     */
    public Response execute(ExecuteReq executeReq){
        ExecuteResp executeResp = null;
        VizResult result = null;
        try {
            result = commonDao.execute(executeReq.getUserId(),
                    executeReq.getDataSourceId(),
                    executeReq.getDataSetId(),
                    executeReq.getVizGraphType(),
                    executeReq.getColumnAttributeIds(),
                    executeReq.getRowAttributeIds(),
                    executeReq.getFilters());
            // if error

            // else success
            executeResp = new ExecuteResp(result);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("error in CommonController::execute", e);
            executeResp = new ExecuteResp(-1,e.getMessage());
        }

        return executeResp;
    }
}
