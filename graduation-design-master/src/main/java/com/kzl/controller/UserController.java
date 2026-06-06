package com.kzl.controller;

import com.kzl.entity.*;
import com.kzl.service.ManageService;
import com.kzl.service.StudentService;
import com.kzl.service.TeacherService;
import com.kzl.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private StudentService studentService;
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private com.kzl.service.ManageService manageService;

    // ===================== 学生基本信息 =====================

    //跳转学生基本信息页面
    @RequestMapping("studentProfile")
    public ModelAndView studentProfile(HttpServletRequest request){
        boolean state = judgeStudentLoginState(request);
        ModelAndView modelAndView = new ModelAndView();
        if(!state){
            modelAndView.setViewName("redirect:/");
            return modelAndView;
        }
        Student sessionUser = (Student) request.getSession().getAttribute("user");
        Student student = studentService.queryStudentById(sessionUser.getId());
        modelAndView.setViewName("student/profile");
        modelAndView.addObject("student", student);
        return modelAndView;
    }

    //修改学生基本信息
    @ResponseBody
    @RequestMapping("updateStudentProfile")
    public Result updateStudentProfile(@RequestBody Student student, HttpServletRequest request){
        boolean state = judgeStudentLoginState(request);
        if(!state){
            return Result.createFail("请先登录");
        }
        Student sessionUser = (Student) request.getSession().getAttribute("user");
        student.setId(sessionUser.getId());
        boolean b = studentService.updateStudentProfile(student);
        if(b){
            //更新session中的信息
            Student updatedStudent = studentService.queryStudentById(sessionUser.getId());
            request.getSession().setAttribute("user", updatedStudent);
            return Result.createSuccess("修改成功");
        }
        return Result.createFail("修改失败");
    }

    //跳转学生修改密码页面
    @RequestMapping("studentChangePassword")
    public String studentChangePassword(HttpServletRequest request){
        boolean state = judgeStudentLoginState(request);
        return state ? "student/changePassword" : "redirect:/";
    }

    //学生修改密码
    @ResponseBody
    @RequestMapping("changeStudentPassword")
    public Result changeStudentPassword(@RequestBody PasswordChange passwordChange, HttpServletRequest request){
        boolean state = judgeStudentLoginState(request);
        if(!state){
            return Result.createFail("请先登录");
        }
        Student sessionUser = (Student) request.getSession().getAttribute("user");
        //验证旧密码
        Student checkUser = new Student();
        checkUser.setStudentNumber(sessionUser.getStudentNumber());
        checkUser.setPassword(passwordChange.getOldPassword());
        Student verified = studentService.verifyStudentPassword(checkUser);
        if(verified == null){
            return Result.createFail("当前密码输入错误");
        }
        //修改密码
        boolean b = studentService.updateStudentPassword(sessionUser.getId(), passwordChange.getNewPassword());
        return b ? Result.createSuccess("密码修改成功") : Result.createFail("密码修改失败");
    }

    // ===================== 教师基本信息 =====================

    //跳转教师基本信息页面
    @RequestMapping("teacherProfile")
    public ModelAndView teacherProfile(HttpServletRequest request){
        boolean state = judgeTeacherLoginState(request);
        ModelAndView modelAndView = new ModelAndView();
        if(!state){
            modelAndView.setViewName("redirect:/");
            return modelAndView;
        }
        Teacher sessionUser = (Teacher) request.getSession().getAttribute("user");
        Teacher teacher = teacherService.queryTeacherById(sessionUser.getId());
        modelAndView.setViewName("teacher/profile");
        modelAndView.addObject("teacher", teacher);
        return modelAndView;
    }

    //修改教师基本信息
    @ResponseBody
    @RequestMapping("updateTeacherProfile")
    public Result updateTeacherProfile(@RequestBody Teacher teacher, HttpServletRequest request){
        boolean state = judgeTeacherLoginState(request);
        if(!state){
            return Result.createFail("请先登录");
        }
        Teacher sessionUser = (Teacher) request.getSession().getAttribute("user");
        teacher.setId(sessionUser.getId());
        boolean b = teacherService.updateTeacherProfile(teacher);
        if(b){
            Teacher updatedTeacher = teacherService.queryTeacherById(sessionUser.getId());
            request.getSession().setAttribute("user", updatedTeacher);
            return Result.createSuccess("修改成功");
        }
        return Result.createFail("修改失败");
    }

    //跳转教师修改密码页面
    @RequestMapping("teacherChangePassword")
    public String teacherChangePassword(HttpServletRequest request){
        boolean state = judgeTeacherLoginState(request);
        return state ? "teacher/changePassword" : "redirect:/";
    }

    //教师修改密码
    @ResponseBody
    @RequestMapping("changeTeacherPassword")
    public Result changeTeacherPassword(@RequestBody PasswordChange passwordChange, HttpServletRequest request){
        boolean state = judgeTeacherLoginState(request);
        if(!state){
            return Result.createFail("请先登录");
        }
        Teacher sessionUser = (Teacher) request.getSession().getAttribute("user");
        //验证旧密码
        Teacher checkUser = new Teacher();
        checkUser.setLoginName(sessionUser.getLoginName());
        checkUser.setPassword(passwordChange.getOldPassword());
        Teacher verified = teacherService.verifyTeacherPassword(checkUser);
        if(verified == null){
            return Result.createFail("当前密码输入错误");
        }
        //修改密码
        boolean b = teacherService.updateTeacherPassword(sessionUser.getId(), passwordChange.getNewPassword());
        return b ? Result.createSuccess("密码修改成功") : Result.createFail("密码修改失败");
    }

    // ===================== 管理员基本信息 =====================

    //跳转管理员基本信息页面
    @RequestMapping("manageProfile")
    public ModelAndView manageProfile(HttpServletRequest request){
        boolean state = judgeManageLoginState(request);
        ModelAndView modelAndView = new ModelAndView();
        if(!state){
            modelAndView.setViewName("redirect:/");
            return modelAndView;
        }
        ManageUser sessionUser = (ManageUser) request.getSession().getAttribute("user");
        ManageUser manageUser = manageService.queryManageUserById(sessionUser.getId());
        modelAndView.setViewName("manage/profile");
        modelAndView.addObject("manageUser", manageUser);
        return modelAndView;
    }

    //修改管理员基本信息
    @ResponseBody
    @RequestMapping("updateManageProfile")
    public Result updateManageProfile(@RequestBody ManageUser manageUser, HttpServletRequest request){
        boolean state = judgeManageLoginState(request);
        if(!state){
            return Result.createFail("请先登录");
        }
        ManageUser sessionUser = (ManageUser) request.getSession().getAttribute("user");
        manageUser.setId(sessionUser.getId());
        boolean b = manageService.updateManageUserProfile(manageUser);
        if(b){
            ManageUser updatedUser = manageService.queryManageUserById(sessionUser.getId());
            updatedUser.setRoleName(sessionUser.getRoleName());
            request.getSession().setAttribute("user", updatedUser);
            return Result.createSuccess("修改成功");
        }
        return Result.createFail("修改失败");
    }

    //跳转管理员修改密码页面
    @RequestMapping("manageChangePassword")
    public String manageChangePassword(HttpServletRequest request){
        boolean state = judgeManageLoginState(request);
        return state ? "manage/changePassword" : "redirect:/";
    }

    //管理员修改密码
    @ResponseBody
    @RequestMapping("changeManagePassword")
    public Result changeManagePassword(@RequestBody PasswordChange passwordChange, HttpServletRequest request){
        boolean state = judgeManageLoginState(request);
        if(!state){
            return Result.createFail("请先登录");
        }
        ManageUser sessionUser = (ManageUser) request.getSession().getAttribute("user");
        //验证旧密码
        ManageUser checkUser = new ManageUser();
        checkUser.setLoginName(sessionUser.getLoginName());
        checkUser.setPassword(passwordChange.getOldPassword());
        ManageUser verified = manageService.verifyManageUserPassword(checkUser);
        if(verified == null){
            return Result.createFail("当前密码输入错误");
        }
        //修改密码
        boolean b = manageService.updateManageUserPassword(sessionUser.getId(), passwordChange.getNewPassword());
        return b ? Result.createSuccess("密码修改成功") : Result.createFail("密码修改失败");
    }

    // ===================== 数据库连接检测 =====================

    @ResponseBody
    @RequestMapping("checkConnection")
    public Result checkConnection(){
        try {
            boolean connected = studentService.checkDatabaseConnection();
            if(connected){
                return Result.createSuccess("数据库连接正常");
            }
            return Result.createFail("数据库连接异常");
        } catch (Exception e){
            return Result.createFail("数据库连接失败：" + e.getMessage());
        }
    }

    // ===================== 登录状态判断 =====================

    private boolean judgeStudentLoginState(HttpServletRequest request){
        Student user = (Student) request.getSession().getAttribute("user");
        List<Menu> menus = (List) request.getSession().getAttribute("menuList");
        return user != null && menus != null && menus.size() > 0;
    }

    private boolean judgeTeacherLoginState(HttpServletRequest request){
        Teacher teacher = (Teacher) request.getSession().getAttribute("user");
        List<Menu> menus = (List) request.getSession().getAttribute("menuList");
        return teacher != null && menus != null && menus.size() > 0;
    }

    private boolean judgeManageLoginState(HttpServletRequest request){
        ManageUser user = (ManageUser) request.getSession().getAttribute("user");
        List<Menu> menus = (List) request.getSession().getAttribute("menuList");
        return user != null && menus != null && menus.size() > 0;
    }
}
