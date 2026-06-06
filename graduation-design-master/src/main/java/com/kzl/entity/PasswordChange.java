package com.kzl.entity;

import lombok.Data;

//密码修改传输对象
@Data
public class PasswordChange {
    private String oldPassword;
    private String newPassword;
}
