## 本地运行

项目当前适配 MySQL 8。可使用文档中提供的 Docker 容器启动数据库：

```powershell
docker run --name goi_mysql -e MYSQL_ROOT_PASSWORD=123456 -p 3306:3306 -d mysql
Get-Content -Raw -Encoding UTF8 sql/init.sql | docker exec -i goi_mysql mysql -uroot -p123456 --default-character-set=utf8mb4
```

初始化数据后，从嵌套的 Maven 项目目录启动应用：

```powershell
cd graduation-design-master
mvn spring-boot:run
```

应用地址为 <http://localhost:8088/>，数据库连接配置位于 `src/main/resources/application.properties`。

# stu-manage

#### 介绍
学生选课系统

#### 软件架构
软件架构说明


#### 安装教程

1.  xxxx
2.  xxxx
3.  xxxx

#### 使用说明

1.  xxxx
2.  xxxx
3.  xxxx

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
