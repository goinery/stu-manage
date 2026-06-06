package com.kzl.controller;

import com.kzl.entity.*;
import com.kzl.service.StudentService;
import com.kzl.service.TeacherService;
import com.kzl.util.Result;
import com.kzl.entity.SelectionStage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("student")
public class StudentController {

    @Autowired
    private StudentService studentService;

    //登录获取数据
    @RequestMapping("getLoginData")
    public ModelAndView getLoginData(String id, String loginName, String username, String roleId, String roleName,String collegeId, HttpServletRequest request){
        Student user = new Student(id,loginName,username,roleId,roleName,collegeId);
        List<Menu> menuList = studentService.queryUserRoleMenu(user.getRoleId());
        Information information = studentService.queryInformation(user.getRoleId());
        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addObject("information",information);
        modelAndView.addObject("userType","3");
        //查询选课统计数据
        try {
            List<Course> courses = studentService.selectCourseList(user.getId());
            double creditsCount = 0;
            for(Course course:courses){
                creditsCount += course.getCredits();
            }
            modelAndView.addObject("courseCount", courses.size());
            modelAndView.addObject("creditsCount", creditsCount);
            CourseAcademicYear courseAcademicYear = studentService.getCourseAcademicYear();
            if(courseAcademicYear != null){
                modelAndView.addObject("academicYear", courseAcademicYear.getAcademicYearName());
            }
        } catch (Exception e) {
            modelAndView.addObject("courseCount", 0);
            modelAndView.addObject("creditsCount", 0);
        }
        request.getSession().setAttribute("user",user);
        request.getSession().setAttribute("menuList",menuList);
        request.getSession().setAttribute("userType","3");
        return modelAndView;
    }

//    //跳转首页
//    @RequestMapping("index")
//    public String index(HttpServletRequest request){
//        boolean state = judgeUserLoginState(request);
//        return state?"../index":"redirect:/";
//    }

    //跳转选课中心
    @RequestMapping("courseCase")
    public ModelAndView forwardCourseCase(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName(state?"student/courseCase":"redirect:/");
        return modelAndView;
    }

    //学生选课
    @ResponseBody
    @RequestMapping("courseSelection")
    public Result courseSelection(@RequestBody StudentCourseRel studentCourseRel, HttpServletRequest request){
        //校验选课阶段
        SelectionStage stage = studentService.queryActiveSelectionStage();
        if(stage == null){
            return Result.createFail("当前不在选课时间段内，无法选课");
        }
        //校验选课类型是否被当前阶段允许
        String selectionType = studentCourseRel.getSelectionType();
        if(selectionType == null) selectionType = "recommend";
        if("recommend".equals(selectionType) && !"1".equals(stage.getAllowRecommend())){
            return Result.createFail("当前阶段不允许推荐选课");
        }
        if("plan".equals(selectionType) && !"1".equals(stage.getAllowPlan())){
            return Result.createFail("当前阶段不允许方案内选课（第三、四阶段开放）");
        }
        if("outside".equals(selectionType) && !"1".equals(stage.getAllowOutside())){
            return Result.createFail("当前阶段不允许方案外选课（第三、四阶段开放）");
        }

        //校验上课时间冲突
        Student user = (Student) request.getSession().getAttribute("user");
        Course course = studentService.queryCourseById(studentCourseRel.getCourseId());
        if(course != null && course.getClassDate() != null){
            boolean conflict = studentService.checkTimeConflict(user.getId(), course.getClassDate());
            if(conflict){
                return Result.createFail("上课时间冲突，无法选择该课程");
            }
        }

        studentCourseRel.setSelectionType(selectionType);
        boolean b = studentService.updateStudentCourseRel(studentCourseRel);
        if(!b){
            return Result.createFail("当前课程无法选择，选修时间已过或可选人数不足");
        }
        return Result.createSuccess("选课成功");
    }

    @ResponseBody
    @RequestMapping("courseList")
    public Result courseList(HttpServletRequest request){
        Student user = (Student) request.getSession().getAttribute("user");
        List<Course> courses = studentService.queryCourseList(user.getCollegeId(),user.getId());
        return Result.create(0,"",courses);
    }

    //推荐选课列表
    @ResponseBody
    @RequestMapping("recommendCourseList")
    public Result recommendCourseList(HttpServletRequest request){
        Student user = (Student) request.getSession().getAttribute("user");
        List<Course> courses = studentService.queryRecommendCourseList(user.getCollegeId(), user.getId());
        return Result.create(0,"",courses);
    }

    //方案内选课列表
    @ResponseBody
    @RequestMapping("planCourseList")
    public Result planCourseList(HttpServletRequest request){
        Student user = (Student) request.getSession().getAttribute("user");
        List<Course> courses = studentService.queryPlanCourseList(user.getCollegeId(), user.getId());
        return Result.create(0,"",courses);
    }

    //方案外选课列表
    @ResponseBody
    @RequestMapping("outsideCourseList")
    public Result outsideCourseList(HttpServletRequest request){
        Student user = (Student) request.getSession().getAttribute("user");
        List<Course> courses = studentService.queryOutsideCourseList(user.getCollegeId(), user.getId());
        return Result.create(0,"",courses);
    }

    //查询当前选课阶段信息
    @ResponseBody
    @RequestMapping("selectionStage")
    public Result selectionStage(){
        SelectionStage stage = studentService.queryActiveSelectionStage();
        if(stage == null){
            return Result.createFail("当前不在选课时间段内");
        }
        return Result.createSuccess(stage);
    }

    //跳转已选课程
    @RequestMapping("selectedCourse")
    public ModelAndView selectedCourse(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);
        ModelAndView modelAndView = new ModelAndView();
        if(!state){
            modelAndView.setViewName("redirect:/");
            return modelAndView;
        }
        Student user = (Student) request.getSession().getAttribute("user");
        List<Course> courses = studentService.selectCourseList(user.getId());
        CourseAcademicYear courseAcademicYear = studentService.getCourseAcademicYear();
        double creditsCount = 0;
        for(Course course:courses){
            creditsCount += course.getCredits();
        }
        modelAndView.addObject("courses",courses);
        modelAndView.addObject("academicYear",courseAcademicYear.getAcademicYearName());
        modelAndView.addObject("creditsCount",creditsCount);
        modelAndView.addObject("courseCount",courses.size());
        modelAndView.setViewName("student/selectedCourse");
        return modelAndView;
    }


    //跳转选课统计
    @RequestMapping("statistical")
    public ModelAndView courseStatistics(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);
        ModelAndView modelAndView = new ModelAndView();
        if(!state){
            modelAndView.setViewName("redirect:/");
            return modelAndView;
        }
        Student user = (Student) request.getSession().getAttribute("user");
        Map map = studentService.queryCourseSeletedCount(user);
        modelAndView.addObject("complete",map.get("complete"));
        modelAndView.addObject("unfinished",map.get("unfinished"));
        modelAndView.addObject("selected",map.get("selected"));
        modelAndView.setViewName("student/statistical");
        return modelAndView;
    }

    //选课统计数据接口（JSON）
    @ResponseBody
    @RequestMapping("statisticalData")
    public Result statisticalData(HttpServletRequest request){
        Student user = (Student) request.getSession().getAttribute("user");
        Map<String, Object> data = new HashMap<>();
        data.put("byType", studentService.queryCourseCountByType(user.getId()));
        data.put("byCollege", studentService.queryCourseCountByCollege(user.getId()));
        data.put("timeConflicts", studentService.queryTimeConflictStats(user.getId()));
        data.put("overview", studentService.querySelectionOverview(user.getId()));
        return Result.createSuccess(data);
    }

    private boolean judgeUserLoginState(HttpServletRequest request){
        Student user = (Student) request.getSession().getAttribute("user");
        List<Menu> menus = (List) request.getSession().getAttribute("menuList");
        if(user == null || menus == null || menus.size() == 0){
            return false;
        }
        return true;
    }
}
