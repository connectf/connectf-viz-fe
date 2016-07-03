package com.vizfe.controller;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.vc.vizcore.common.AttributeDMType;
import com.vc.vizcore.entity.local.AttributeUserLocal;
import com.vc.vizcore.entity.local.AttributeUserLocalProperties;
import com.vc.vizcore.entity.share.DataCategory;
import com.vc.vizcore.entity.share.DataSet;
import com.vc.vizcore.entity.share.DataSource;
import com.vc.vizcore.frontend.AttributeFilter;
import com.vc.vizcore.frontend.FunctionedAttributeId;
import com.vc.vizcore.frontend.VizGraphSupported;
import com.vc.vizcore.frontend.VizResult;
import com.viz.protocol.*;
import com.vizfe.common.controller.CommonController;
import com.vizfe.model.*;
import com.vizfe.net.ConnectionService;
import com.vizfe.util.Constant;
import org.apache.log4j.Logger;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.util.Vector;

/**
 * Created by sonny on 2015/12/14.
 */
@Controller
public class MainController {

    private ConnectionService service = new ConnectionService();
    private Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
    private JsonObject jsonObject = null;

    //登录页面
    @RequestMapping(value = {"/","/?error"}, method = RequestMethod.GET)
    public ModelAndView login(@RequestParam(value = "error", required = false) String error,
                              @RequestParam(value = "logout", required = false) String logout,
                              HttpSession session) {
        ModelAndView model = new ModelAndView();

        if (error != null) {
            model.addObject("error", "用户名或者密码不正确，请重新输入！");
        }

        if (logout != null) {
            model.addObject("msg", "你已经注销成功！");
        }
        model.setViewName("login");
        return model;
    }

    /**
     * 系统登陆后主界面
     * @param model
     * @return
     */
    @RequestMapping(value = "/blank", method = RequestMethod.GET)
    public String blank(ModelMap model) {
        return "blank";
    }

    /**
     *视频教程列表
     * @param model
     * @return
     */
    @RequestMapping(value = "/blank11", method = RequestMethod.GET)
    public String blank11(ModelMap model) {
        return "blank11";
    }

    /**
     * 数据源选择界面
     * @param model
     * @return
     */
    @RequestMapping(value = "/form", method = RequestMethod.GET)
    public String form1(ModelMap model) {
        return "form1";
    }

    /**
     * 数据集选择界面
     * @param model
     * @return
     */
    @RequestMapping(value = "/form2", method = RequestMethod.GET)
    public String form2(ModelMap model) {
        return "form2";
    }

    /**
     * 维度、度量设定界面
     * @param model
     * @return
     */
    @RequestMapping(value = "/form3", method = RequestMethod.GET)
    public String form3(ModelMap model) {
        return "form3";
    }

    /**
     * 数据可视化分析界面
     * @param model
     * @return
     */
    @RequestMapping(value = "/chart", method = RequestMethod.GET)
    public String chart(ModelMap model) {
        return "chart";
    }

    /**
     * get dataSource list from viz_backend
     * @return
     */
    @RequestMapping(value = "/getAllDataSource", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Vector<DataSourceBean> getAllDataSourceName(HttpSession session) throws IOException {
        Vector<DataSource> dataSourcelist = null;
        Vector<DataSourceBean> dataSourceBeanslist = new Vector<DataSourceBean>();
        DataSourceBean bean = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)){
            UserDetails userDetails = (UserDetails)auth.getPrincipal();
            String userName = userDetails.getUsername();

            String userId = (String) session.getAttribute(Constant.param_Session_userId);
            if(userId == null)
            {
                GetUserIdByUserNameReq getUserIdByUserNameReq = new GetUserIdByUserNameReq(userName);
                CommonController commonController = new CommonController();
                GetUesrIdByUserNameResp resp = (GetUesrIdByUserNameResp) commonController.getUserIdByUserName(getUserIdByUserNameReq);
                userId = resp.getUserId();
                session.setAttribute(Constant.param_Session_userId,userId);
            }

            GetDataSourcesByUserReq getDataSourcesByUserReq = new GetDataSourcesByUserReq(userId);
            CommonController commonController = new CommonController();
            GetDataSourcesByUserResp getDataSourcesByUserResp = (GetDataSourcesByUserResp) commonController.getDataSourcesByUserId(getDataSourcesByUserReq);
            dataSourcelist = getDataSourcesByUserResp.getDataSources();
        }

        for(int i =0;i<dataSourcelist.size();i++){
            bean = new DataSourceBean();
            bean.setDataSourceId(dataSourcelist.get(i).getId());
            bean.setDataSourceName(dataSourcelist.get(i).getName());
            bean.setDataSourceDesc(dataSourcelist.get(i).getDataSourceDescription());
            dataSourceBeanslist.add(bean);
        }
        return dataSourceBeanslist;
    }

    /**
     * setdataSourceId
     * @param dataSourceId
     * @return
     */
    @RequestMapping(value = "/setDataSourceId", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Boolean setDataSourceId(@RequestParam("dataSourceId")String dataSourceId,HttpSession session){
        if (dataSourceId != null){
            session.setAttribute(Constant.param_Session_dataSourceId,dataSourceId);
            return true;
        }
        return false;
    }


    /**
     * getAllDataSetName
     * @param session
     * @return
     */
    @RequestMapping(value = "/getAllDataSetName", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Vector<DataSetBean> getAllDataSetName(HttpSession session) {
        Vector<DataSet> dataSets = null;
        Vector<DataSetBean> dataSetBeans = new Vector<DataSetBean>();
        DataSetBean bean = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetails = (UserDetails) auth.getPrincipal();
            String userName = userDetails.getUsername();

            String userId = (String) session.getAttribute(Constant.param_Session_userId);
            String dataSourceId = (String) session.getAttribute(Constant.param_Session_dataSourceId);

            GetDataSetsByUserReq getDataSetsByUserReq = new GetDataSetsByUserReq(userId,dataSourceId);
            CommonController commonController = new CommonController();

            GetDataSetsByUserResp getDataSetsByUserResp = (GetDataSetsByUserResp) commonController.getDataSetsById(getDataSetsByUserReq);
            dataSets = getDataSetsByUserResp.getDataSets();
        }

        for(int i =0;i<dataSets.size();i++){
            bean = new DataSetBean();
            bean.setDataSetId(dataSets.get(i).getId());
            bean.setDataSetName(dataSets.get(i).getName());
            bean.setDataSourceName(dataSets.get(i).getDataSourceName());
            bean.setDataSetDesc(dataSets.get(i).getDataSetDescription());
            dataSetBeans.add(bean);
        }
        return dataSetBeans;
    }

    /**
     * setDataSetId
     * @param dataSetId
     * @param session
     * @return
     */
    @RequestMapping(value = "/setDataSetId", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Boolean setDataSetId(@RequestParam("dataSetId")String dataSetId,HttpSession session){
        if (dataSetId != null){
            session.setAttribute(Constant.param_Session_dataSetId,dataSetId);
            return true;
        }
        return false;
    }

    @RequestMapping(value = "/getAttributeUserLocals4DataSet4Tree", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Vector<TreeEntry> getAttributeUserLocals4DataSet4Tree(HttpSession session){
        Vector<AttributeUserLocal> attributeUserLocals = null;
        Vector<AttributeBean> attributeBeans = new Vector<AttributeBean>();
        AttributeBean bean = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetails = (UserDetails) auth.getPrincipal();
            String userName = userDetails.getUsername();

            String userId = (String) session.getAttribute(Constant.param_Session_userId);
            String dataSourceId = (String) session.getAttribute(Constant.param_Session_dataSourceId);
            String dataSetId = (String) session.getAttribute(Constant.param_Session_dataSetId);

            GetAttributeUserLocals4DataSetReq getAttributeUserLocals4DataSetReq =
                    new GetAttributeUserLocals4DataSetReq(userId,dataSourceId,dataSetId);

            CommonController commonController = new CommonController();

            GetAttributeUserLocals4DataSetResp getAttributeUserLocals4DataSetResp = (GetAttributeUserLocals4DataSetResp) commonController.getAttributeUserLocals4DataSet(getAttributeUserLocals4DataSetReq);
            attributeUserLocals = getAttributeUserLocals4DataSetResp.getAttributeUserLocals();
        }

        int id = 1;

        Vector<ChildrenEntry> dimensionEntries = new Vector<ChildrenEntry>();
        Vector<ChildrenEntry> measurementEntries = new Vector<ChildrenEntry>();

        Children dimensionChildren = new Children("dimension", "维度", dimensionEntries);
        Children mesurementChildren = new Children("measurement", "度量", measurementEntries);

        Vector<Children> childrenz = new Vector<Children>();
        childrenz.add(dimensionChildren);
        childrenz.add(mesurementChildren);

        TreeEntry treeEntry = new TreeEntry("id_"+id++,attributeUserLocals.get(0).getDataSetName(),childrenz);
        Vector<TreeEntry> v = new Vector<TreeEntry>();
        v.add(treeEntry);

        for (int i=0;i<attributeUserLocals.size();i++){

            String attributeId = attributeUserLocals.get(i).getId();
            String attributeName = attributeUserLocals.get(i).getAttributeName();
            ChildrenEntry e = new ChildrenEntry(attributeId,attributeName);
            if(attributeUserLocals.get(i).getProperties().getAttributeDMType().equalsIgnoreCase(AttributeDMType.Dimension))
            {
                dimensionEntries.add(e);
            }
            else
            {
                measurementEntries.add(e);
            }
        }

        return v;
    }

    @RequestMapping(value = "/getAttributeUserLocals4DataSet", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Vector<AttributeBean> getAttributeUserLocals4DataSet(HttpSession session){
        Vector<AttributeUserLocal> attributeUserLocals = null;
        Vector<AttributeBean> attributeBeans = new Vector<AttributeBean>();
        AttributeBean bean = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetails = (UserDetails) auth.getPrincipal();
            String userName = userDetails.getUsername();

            String userId = (String) session.getAttribute(Constant.param_Session_userId);
            String dataSourceId = (String) session.getAttribute(Constant.param_Session_dataSourceId);
            String dataSetId = (String) session.getAttribute(Constant.param_Session_dataSetId);

            GetAttributeUserLocals4DataSetReq getAttributeUserLocals4DataSetReq =
                    new GetAttributeUserLocals4DataSetReq(userId,dataSourceId,dataSetId);
            CommonController commonController = new CommonController();
            GetAttributeUserLocals4DataSetResp getAttributeUserLocals4DataSetResp = (GetAttributeUserLocals4DataSetResp) commonController.getAttributeUserLocals4DataSet(getAttributeUserLocals4DataSetReq);
            attributeUserLocals = getAttributeUserLocals4DataSetResp.getAttributeUserLocals();
        }

        for (int i=0;i<attributeUserLocals.size();i++){
            bean = new AttributeBean();
            bean.setAttributeDataType(attributeUserLocals.get(i).getAttribute().getAttributeDataType());
            bean.setAttributeDMType(attributeUserLocals.get(i).getProperties().getAttributeDMType());
            bean.setAttributeCategory(attributeUserLocals.get(i).getProperties().getAttributeCategory());
            bean.setAttibuteName(attributeUserLocals.get(i).getAttributeName());
            bean.setAttributeId(attributeUserLocals.get(i).getAttributeId());

            System.out.println("attributeUserLocals.get(i).getDataSetName()=" + attributeUserLocals.get(i).getDataSetName());
            bean.setDataSetName(attributeUserLocals.get(i).getDataSetName());
            attributeBeans.add(bean);
        }

        return attributeBeans;
    }


    /**
     * getDataCategories
     * @return
     */
    @RequestMapping(value = "/getDataCategories", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Vector<DataCategoryBean> getDataCategories(){
        DataCategoryBean bean = null;
        Vector<DataCategory> DataCategorys = null;
        Vector<DataCategoryBean> dataCategoryBeans = new Vector<DataCategoryBean>();
        GetDataCategoryReq getDataCategoryReq = new GetDataCategoryReq();
        CommonController commonController = new CommonController();

        GetDataCategoryResp getDataCategoryResp = (GetDataCategoryResp) commonController.getDataCategories(getDataCategoryReq);
        DataCategorys = getDataCategoryResp.getDataCategories();

        for (int i=0;i<DataCategorys.size();i++){
            bean = new DataCategoryBean();
            bean.setId(DataCategorys.get(i).getId());
            bean.setName(DataCategorys.get(i).getName());
            bean.setFormat(DataCategorys.get(i).getFormat());
            bean.setFormat(DataCategorys.get(i).getExample());
            dataCategoryBeans.add(bean);
        }

        return dataCategoryBeans;
    }

    @RequestMapping(value = "/updateAttributeUserLocalByUser", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Boolean updateAttributeUserLocalByUser(HttpSession session,
                                                  @RequestParam("attributeId")String attributeId,
                                                  @RequestParam("attributeDMType")String attributeDMType,
                                                  @RequestParam("attributeCategory")String attributeCategory) throws UnsupportedEncodingException {
        AttributeUserLocalProperties properties = new AttributeUserLocalProperties(attributeDMType,attributeCategory);
        UpdateAttributeUserLocalByUserResp updateAttributeUserLocalByUserResp = null;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetails = (UserDetails) auth.getPrincipal();
            String userName = userDetails.getUsername();

            String userId = (String) session.getAttribute(Constant.param_Session_userId);

            String dataSourceId = (String) session.getAttribute(Constant.param_Session_dataSourceId);
            String dataSetId = (String) session.getAttribute(Constant.param_Session_dataSetId);

            UpdateAttributeUserLocalByUserReq updateAttributeUserLocalByUserReq =
                    new UpdateAttributeUserLocalByUserReq(userId,dataSourceId,dataSetId,attributeId,properties);
            CommonController commonController = new CommonController();
            updateAttributeUserLocalByUserResp = (UpdateAttributeUserLocalByUserResp) commonController.updateAttributeUserLocalByUser(updateAttributeUserLocalByUserReq);
        }

        if(updateAttributeUserLocalByUserResp.getbSuccess() == -1){
            return false;
        }else {
            return true;
        }
    }

    @RequestMapping(value = "/getVizGraphSupported", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public VizGraphSupported getVizGraphSupported(HttpSession session,
                                                  @RequestParam("columnAttributeIds")String columnAttributeIdsStr,
                                                  @RequestParam("rowAttributeIds")String rowAttributeIdsStr) {

        String userId = (String) session.getAttribute(Constant.param_Session_userId);
        String dataSourceId = (String) session.getAttribute(Constant.param_Session_dataSourceId);
        String dataSetId = (String) session.getAttribute(Constant.param_Session_dataSetId);

        Type type = new TypeToken<Vector<FunctionedAttributeId>>() {}.getType();
        Vector<FunctionedAttributeId> columnAttributeIds = gson.fromJson(columnAttributeIdsStr,type);
        Vector<FunctionedAttributeId> rowAttributeIds = gson.fromJson(rowAttributeIdsStr,type);

        GetVizGraphSupportedReq getVizGraphSupportedReq = new GetVizGraphSupportedReq(userId,dataSourceId,dataSetId,columnAttributeIds,rowAttributeIds);

        // get the viz graphs we would like to support

        CommonController commonController = new CommonController();

        GetVizGraphSupportedResp getVizGraphSupportedResp = (GetVizGraphSupportedResp) commonController.getVizGraphSupported(getVizGraphSupportedReq);

        return getVizGraphSupportedResp.getVizGraphSupported();
    }

    @RequestMapping(value = "/execute", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public VizResult execute(HttpSession session,
                                               @RequestParam("vizGraphType")String vizGraphType,
                                               @RequestParam("columnAttributeIds")String columnAttributeIdsStr,
                                               @RequestParam("rowAttributeIds")String rowAttributeIdsStr,
                                               @RequestParam("attributeFilters")String attributeFiltersStr
                                               ) {
        String userId = (String) session.getAttribute(Constant.param_Session_userId);
        String dataSourceId = (String) session.getAttribute(Constant.param_Session_dataSourceId);
        String dataSetId = (String) session.getAttribute(Constant.param_Session_dataSetId);

        Type type = new TypeToken<Vector<FunctionedAttributeId>>() {}.getType();
        Vector<FunctionedAttributeId> columnAttributeIds = gson.fromJson(columnAttributeIdsStr,type);
        Vector<FunctionedAttributeId> rowAttributeIds = gson.fromJson(rowAttributeIdsStr,type);

        Type type2 = new TypeToken<Vector<AttributeFilter>>() {}.getType();
        Vector<AttributeFilter> filters = gson.fromJson(attributeFiltersStr,type2);

        // execute and the get the viz result
        ExecuteReq executeReq = new ExecuteReq(userId,dataSourceId,dataSetId,vizGraphType,columnAttributeIds,rowAttributeIds,filters);
        CommonController commonController = new CommonController();
        ExecuteResp executeResp = (ExecuteResp) commonController.execute(executeReq);

        return executeResp.getVizResult();
    }
}
