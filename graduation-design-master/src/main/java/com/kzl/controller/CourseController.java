package com.kzl.controller;

import com.kzl.dao.ManageMapper;
import com.kzl.entity.*;
import com.kzl.service.CourseService;
import com.kzl.service.RegisterService;
import com.kzl.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("course")
public class CourseController {

    @Autowired
    private CourseService courseService;
    @Autowired
    private RegisterService service;

    //跳转课程列表页面
    @RequestMapping("list")
    public ModelAndView course(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        boolean state = judgeManageLoginState(request);
        if(!state){
            modelAndView.setViewName("redirect:/");
            return modelAndView;
        }
        List<Map> colleges = service.selectCollegeList();
        modelAndView.setViewName("manage/course");
        modelAndView.addObject("collegeList",colleges);
        modelAndView.addObject("currentAcademicYear", getCurrentAcademicYearName());
        return modelAndView;
    }

    //查询课程列表
    @ResponseBody
    @RequestMapping("courseList")
    public Result courseList(HttpServletRequest request){
        Course course = new Course();
        course.setCourseName(buildLikeParam(request.getParameter("courseName")));
        course.setCollegeId(cleanSelectParam(request.getParameter("collegeId")));
        List<Course> courses = courseService.queryCourseList(course);
        return Result.create(0,"",courses);
    }

    //课程修改
    @ResponseBody
    @RequestMapping("updateCourse")
    public Result updateCourse(@RequestBody Course course, HttpServletRequest request){
        if(!judgeManageLoginState(request)){
            return Result.createFail("请先登录");
        }
        //判断课程是否结束
        if("0".equals(course.getState())){
            boolean status = courseService.queryCourseEndDate(course);
            if(status){
                return Result.createFail("当前课程还没有结束，无法删除");
            }
        }
        boolean b = courseService.updateCourseList(course);
        return b?Result.createSuccess("修改课程数据成功"):Result.createFail("修改课程数据失败");
    }

    @RequestMapping("forwardAdd")
    public ModelAndView forwardAdd(HttpServletRequest request){
        boolean state = judgeManageLoginState(request);
        ModelAndView modelAndView = new ModelAndView();
        List<Map> colleges = service.selectCollegeList();
        List<Map> teacherList = courseService.selectTeacherList();
        modelAndView.setViewName(state?"manage/addCourse":"redirect:/");
        modelAndView.addObject("teacherList",teacherList);
        modelAndView.addObject("collegeList",colleges);
        return modelAndView;


    }

    @ResponseBody
    @RequestMapping("addCourse")
    public Result addCourse(@RequestBody Course course, HttpServletRequest request){
        if(!judgeManageLoginState(request)){
            return Result.createFail("请先登录");
        }
        boolean b = courseService.addCourseList(course);
        return b?Result.createSuccess("添加课程数据成功"):Result.createFail("添加课程数据失败，请检查必填项、学分、人数和当前学年");
    }

    //跳转学年管理
    @RequestMapping("courseAcademicYear")
    public ModelAndView courseAcademicYear(HttpServletRequest request){
        boolean state = judgeManageLoginState(request);
        ModelAndView modelAndView = new ModelAndView();
        if(!state){
            modelAndView.setViewName("redirect:/");
            return modelAndView;
        }
        //查询学年数据
        List<CourseAcademicYear> courseAcademicYears = courseService.queryCourseAcademicYearList();
        modelAndView.addObject("courseAcademicYears",courseAcademicYears);
        modelAndView.setViewName("manage/courseAcademicYear");
        return modelAndView;
    }

    //修改学年
    @ResponseBody
    @RequestMapping("updateAcademicYears")
    public Result updateAcademicYears(@RequestBody CourseAcademicYear courseAcademicYear, HttpServletRequest request){
        if(!judgeManageLoginState(request)){
            return Result.createFail("请先登录");
        }
        boolean b = courseService.updateAcademicYears(courseAcademicYear);
        return b?Result.createSuccess("修改学年数据成功"):Result.createFail("修改学年数据失败");
    }

    //添加学年
    @ResponseBody
    @RequestMapping("addAcademicYears")
    public Result addAcademicYears(@RequestBody CourseAcademicYear courseAcademicYear, HttpServletRequest request){
        if(!judgeManageLoginState(request)){
            return Result.createFail("请先登录");
        }
        boolean b = courseService.addAcademicYears(courseAcademicYear);
        return b?Result.createSuccess("添加学年数据成功"):Result.createFail("添加学年数据失败");
    }


    private boolean judgeManageLoginState(HttpServletRequest request){
        Object user = request.getSession().getAttribute("user");
        String userType = (String) request.getSession().getAttribute("userType");
        List<Menu> menus = (List) request.getSession().getAttribute("menuList");
        return user != null && "1".equals(userType) && menus != null && menus.size() > 0;
    }

    private String getCurrentAcademicYearName(){
        List<CourseAcademicYear> courseAcademicYears = courseService.queryCourseAcademicYearList();
        if(courseAcademicYears == null){
            return null;
        }
        for(CourseAcademicYear courseAcademicYear : courseAcademicYears){
            if("1".equals(courseAcademicYear.getState())){
                return courseAcademicYear.getAcademicYear();
            }
        }
        return null;
    }

    private static String cleanTextParam(String value){
        if(value == null){
            return null;
        }
        String text = value.trim();
        return text.isEmpty() ? null : text;
    }

    private static String cleanSelectParam(String value){
        String text = cleanTextParam(value);
        if(text == null || "0".equals(text)){
            return null;
        }
        return text;
    }

    private static String buildLikeParam(String value){
        String text = cleanTextParam(value);
        return text == null ? null : "%" + text + "%";
    }

}
