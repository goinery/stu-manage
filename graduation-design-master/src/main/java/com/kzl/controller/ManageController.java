package com.kzl.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.kzl.entity.*;
import com.kzl.service.ManageService;
import com.kzl.service.RegisterService;
import com.kzl.service.StudentService;
import com.kzl.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("manage")
public class ManageController {

    @Autowired
    private ManageService manageService;
    @Autowired
    private RegisterService service;
    @Autowired
    private StudentService studentService;

    @RequestMapping("getLoginData")
    public ModelAndView getLoginData(String id,String loginName,String username,String roleId,String roleName,HttpServletRequest request){
        ManageUser user = new ManageUser(id,loginName,username,null,roleId,null,null,roleName);
        List<Menu> menuList = manageService.queryUserRoleMenu(user.getRoleId());
        Information information = manageService.queryInformation(user.getRoleId());
        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addObject("information",information);
        modelAndView.addObject("userType","1");
        request.getSession().setAttribute("user",user);
        request.getSession().setAttribute("menuList",menuList);
        request.getSession().setAttribute("userType","1");
        return modelAndView;
    }

    @RequestMapping("index")
    public ModelAndView index(HttpServletRequest request){
        Object user = request.getSession().getAttribute("user");
        List<Menu> menus = (List) request.getSession().getAttribute("menuList");
        String userType = (String) request.getSession().getAttribute("userType");
        if(user == null || menus == null || menus.size() == 0){
            return new ModelAndView("redirect:/");
        }
        //首页菜单(m01)对所有角色都指向本接口，需按角色重新装载公告与统计卡片，
        //否则点击“首页”后会丢失登录时由 getLoginData 设置的数据。userType 与 roleId 一致(1管理员/2教师/3学生)。
        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addObject("userType", userType);
        if(userType != null){
            modelAndView.addObject("information", manageService.queryInformation(userType));
        }
        //当前学年（学生/教师卡片共用）
        try {
            CourseAcademicYear courseAcademicYear = studentService.getCourseAcademicYear();
            if(courseAcademicYear != null){
                modelAndView.addObject("academicYear", courseAcademicYear.getAcademicYearName());
            }
        } catch (Exception e){
            //无有效学年时模板自行兜底
        }
        //学生：已选课程数 + 已获学分
        if("3".equals(userType) && user instanceof Student){
            try {
                List<Course> courses = studentService.selectCourseList(((Student) user).getId());
                double creditsCount = 0;
                for(Course course : courses){
                    creditsCount += course.getCredits() == null ? 0 : course.getCredits();
                }
                modelAndView.addObject("courseCount", courses.size());
                modelAndView.addObject("creditsCount", creditsCount);
            } catch (Exception e){
                modelAndView.addObject("courseCount", 0);
                modelAndView.addObject("creditsCount", 0);
            }
        }
        //教师：所属学院
        if("2".equals(userType) && user instanceof Teacher){
            modelAndView.addObject("collegeName", ((Teacher) user).getCollegeName());
        }
        return modelAndView;
    }

    @RequestMapping("menu")
    public ModelAndView menu(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);
        ModelAndView modelAndView = new ModelAndView();
        if(!state){
            modelAndView.setViewName("redirect:/");
            return modelAndView;
        }
        modelAndView.setViewName("manage/menu");
        return modelAndView;
    }

    //查询菜单列表数据
    @RequestMapping("menuList")
    @ResponseBody
    public JSONObject menuList(){
        JSONArray menuList = manageService.queryMenuList();
        JSONObject data = new JSONObject();
        data.put("code",0);
        data.put("data",menuList);
        return data;
    }

    //添加菜单
    @ResponseBody
    @RequestMapping("addMenu")
    public Result addMenu(@RequestBody Menu menu){
        boolean state = manageService.addMenu(menu);
        return state?Result.createSuccess("添加菜单成功"):Result.createFail("添加菜单出错");
    }

    @ResponseBody
    @RequestMapping("updateMenu")
    public Result updatedMenu(@RequestBody Menu menu){
        if(!"".equals(menu.getState()) && menu.getState()!=null){
            menu.setState(menu.getState().equals("1")?"0":"1");
        }
        boolean b = manageService.updateMenu(menu);
        return b?Result.createSuccess("修改菜单成功"):Result.createFail("修改菜单出错");
    }


    @RequestMapping("college")
    public String college(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);
        return state?"manage/college":"redirect:/";
    }

    //查询学院列表数据
    @RequestMapping("collegeList")
    @ResponseBody
    public JSONObject collegeList(){
        JSONArray collegeList = manageService.queryCollegeList();
        JSONObject data = new JSONObject();
        data.put("code",0);
        data.put("data",collegeList);
        return data;
    }

    //修改学院
    @ResponseBody
    @RequestMapping("updateCollege")
    public Result updateCollege(@RequestBody College college){
        if(college.getState()!=null && !"".equals(college.getState())){
            college.setState(college.getState().equals("1")?"0":"1");
        }
        boolean b = manageService.updateCollege(college);
        return b?Result.createSuccess("修改学院信息成功"):Result.createFail("修改学院信息出错");
    }

    //添加学院
    @ResponseBody
    @RequestMapping("addCollege")
    public Result addCollege(@RequestBody College college){
        boolean b = manageService.addCollege(college);
        return b?Result.createSuccess("添加学院信息成功"):Result.createFail("添加学院信息出错");
    }

    //资讯列表页面
    @RequestMapping("information")
    public String information(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);
        return state?"manage/informationList":"redirect:/";
    }

    //资讯列表数据
    @RequestMapping("informationList")
    @ResponseBody
    public JSONObject informationList(){
        JSONArray informationList = manageService.queryInformationList();
        JSONObject data = new JSONObject();
        data.put("code",0);
        data.put("data",informationList);
        return data;
    }

    //资讯详情
    @RequestMapping("informationDetail")
    public ModelAndView addInformation(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);
        ModelAndView modelAndView = new ModelAndView();
        if(!state){
            modelAndView.setViewName("redirect:/");
            return modelAndView;
        }
        //通过id查询出具体的数据
        String id = request.getParameter("id");
        modelAndView.setViewName("manage/informationDetail");
        Information information = null;
        if(id != null){
            information= manageService.queryInformationById(id);
        }
        modelAndView.addObject("information",information);
        return modelAndView;
    }

    //修改首页资讯数据
    @ResponseBody
    @RequestMapping("updateInformation")
    public Result updateInformation(@RequestBody Information information){
        boolean b = manageService.updateInformation(information);
        return b?Result.createSuccess("修改资讯信息成功"):Result.createFail("修改资讯信息失败");
    }

    //添加资讯信息
    @ResponseBody
    @RequestMapping("addInformation")
    public Result addInformation(@RequestBody Information information){
        boolean b = manageService.addInformation(information);
        return b?Result.createSuccess("添加资讯信息成功"):Result.createFail("添加资讯信息失败");
    }

    //删除资讯信息
    @ResponseBody
    @RequestMapping("deleteInformation")
    public Result deleteInformation(@RequestBody Information information){
        boolean b = manageService.deleteInformation(information.getId());
        return b?Result.createSuccess("删除资讯信息成功"):Result.createFail("删除资讯信息失败");
    }

    //教师管理页面
    @RequestMapping("teacher")
    public ModelAndView teacher(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);
//        return state?"/manage/teacher":"redirect:/";

        ModelAndView modelAndView = new ModelAndView();
        List<Map> colleges = service.selectCollegeList();
        modelAndView.setViewName(state?"manage/teacher":"redirect:/");
        modelAndView.addObject("collegeList",colleges);
        return modelAndView;
    }

    //查询教师列表
    @ResponseBody
    @RequestMapping("teacherList")
    public Result teacherList(HttpServletRequest request){
        Teacher teacher = new Teacher();
        teacher.setUsername(request.getParameter("username"));
        teacher.setCollegeId(request.getParameter("collegeId"));
        List<Teacher> teachers = manageService.queryTeacherList(teacher);
        return Result.create(0,"",teachers);
    }

    //修改教师信息
    @ResponseBody
    @RequestMapping("updateTeacher")
    public Result updateTeacher(@RequestBody Teacher teacher){
        boolean b = manageService.updateTeacherList(teacher);
        return b?Result.createSuccess("修改教师数据成功"):Result.createFail("修改教师数据失败");
    }


    //跳转学生管理页面
    @RequestMapping("student")
    public ModelAndView student(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);

        ModelAndView modelAndView = new ModelAndView();
        List<Map> colleges = service.selectCollegeList();
        modelAndView.setViewName(state?"manage/student":"redirect:/");
        modelAndView.addObject("collegeList",colleges);
        return modelAndView;
    }


    //查询学生列表
    @ResponseBody
    @RequestMapping("studentList")
    public Result studentList(HttpServletRequest request){
        Student student = new Student();
        student.setUsername(request.getParameter("username"));
        student.setCollegeId(request.getParameter("collegeId"));
        List<Student> teachers = manageService.queryStudentList(student);
        return Result.create(0,"",teachers);
    }

    //修改学生数据
    @ResponseBody
    @RequestMapping("updateStudent")
    public Result updateStudent(@RequestBody Student student){
        boolean b = manageService.updateStudentList(student);
        return b?Result.createSuccess("修改学生数据成功"):Result.createFail("修改学生数据失败");
    }

    //跳转角色管理
    @RequestMapping("role")
    public String role(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);
        return state?"manage/role":"redirect:/";
    }

    //跳转选课阶段管理页面
    @RequestMapping("selectionStage")
    public String selectionStage(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);
        return state?"manage/selectionStage":"redirect:/";
    }

    //查询选课阶段列表
    @ResponseBody
    @RequestMapping("selectionStageList")
    public Result selectionStageList(HttpServletRequest request){
        List<SelectionStage> stages = manageService.querySelectionStageList();
        return Result.create(0,"",stages);
    }

    //修改选课阶段（状态/三类选课开关）
    @ResponseBody
    @RequestMapping("updateSelectionStage")
    public Result updateSelectionStage(@RequestBody SelectionStage selectionStage){
        boolean b = manageService.updateSelectionStage(selectionStage);
        return b?Result.createSuccess("选课阶段更新成功"):Result.createFail("选课阶段更新失败");
    }

    //查询菜单列表
    @ResponseBody
    @RequestMapping("getMenuList")
    public Result getRoleMenuRelList(HttpServletRequest request){
        String id = request.getParameter("id");
        JSONArray menuList = manageService.queryMenuList2(id);
        return Result.createSuccess(menuList);
    }

    //角色列表
    @ResponseBody
    @RequestMapping("roleList")
    public Result roleList(HttpServletRequest request){
        List<Role> roles = manageService.queryRoleList();
        return Result.create(0,"",roles);
    }

    //修改角色
    @ResponseBody
    @RequestMapping("updateRole")
    public Result updateRole(@RequestBody Role role){
        boolean b = manageService.updateRole(role);
        return b?Result.createSuccess("修改角色数据成功"):Result.createFail("修改角色数据失败");
    }

    //添加角色
    @ResponseBody
    @RequestMapping("addRole")
    public Result addRole(@RequestBody Role role){
        boolean b = manageService.addRole(role);
        return b?Result.createSuccess("添加角色数据成功"):Result.createFail("添加角色数据失败");
    }


    public static boolean judgeUserLoginState(HttpServletRequest request){
        Object user = request.getSession().getAttribute("user");
        String userType = (String) request.getSession().getAttribute("userType");
        List<Menu> menus = (List) request.getSession().getAttribute("menuList");
        if(user == null || !"1".equals(userType) || menus == null || menus.size() == 0){
            return false;
        }
        return true;
    }

}
