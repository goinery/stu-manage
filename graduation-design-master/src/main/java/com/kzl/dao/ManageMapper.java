package com.kzl.dao;

import com.alibaba.fastjson.JSONArray;
import com.kzl.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ManageMapper {

    List<Menu> selectFirstMenuByRoleId(@Param("roleId") String roleId, @Param("parentId") String parentId);

    Information selectInformationByRoleId(String roleId);

    List<Information> selectInformationListByRoleId(String roleId);

    JSONArray selectMenuList();

    boolean insertMenu(Menu menu);

    boolean updateMenu(Menu menu);

    boolean updateCollege(College college);

    boolean insertCollege(College college);

    JSONArray selectCollegeList();

    JSONArray selectInformationList();

    Information selectInformationById(String id);

    boolean updateInformation(Information information);

    boolean addInformation(Information information);

    List<Teacher> selectTeacherList(Teacher teacher);

    boolean updateTeacher(Teacher teacher);

    List<Student> selectStudentList(Student student);

    boolean updateStudent(Student student);

    //查询选课阶段列表
    List<SelectionStage> selectSelectionStageList();

    //更新选课阶段（状态与三类选课开关）
    boolean updateSelectionStage(SelectionStage selectionStage);

    List<Menu> selectMenuByRoleId(String roleId);

    List<Menu> selectAllMenuList();

    List<Role> selectRoleList();

    boolean updateRole(Role role);

    int addRoleMenuRel(RoleMenuRel roleMenuRel);

    int deleteRoleMenuRelByRoleId(String roleId);

    boolean insertRole(Role role);

    //根据ID查询管理员信息
    ManageUser selectManageUserById(String id);

    //修改管理员基本信息
    boolean updateManageUserProfile(ManageUser manageUser);

    //验证管理员密码
    ManageUser verifyManageUserPassword(ManageUser manageUser);

    //修改管理员密码
    boolean updateManageUserPassword(@Param("id") String id, @Param("newPassword") String newPassword);

    //删除资讯信息
    boolean deleteInformation(String id);

    Map selectManageStatisticOverview();

    List<Map> selectManageStudentCountByCollege();

    List<Map> selectManageSelectionCountByCollege();

    List<Map> selectManageCourseSelectionTop();

    List<Map> selectManageSelectionCountByType();

    List<Map> selectManageScoreStatusCount();
}
