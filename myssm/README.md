### 前言
* [加快Maven项目构件速度:【Maven】将maven中央仓库设置为阿里云镜像](https://blog.csdn.net/sinse_/article/details/103329402)
# 一、创建Maven项目
1、选择File==>New==>Project... 
	点击左侧的Maven，把Create from archetype前的方框打上勾，选择下方的`org.apache.maven.archetupes:maven-archetype-webapp`。点击Next。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191130213335933.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbnNlXw==,size_16,color_FFFFFF,t_70)

在GroupId填写包名，在ArtifactId中填写项目名。点击Next。下一步继续点击Next，最后点击Finish。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191130214127584.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbnNlXw==,size_16,color_FFFFFF,t_70)
# 二、引入项目依赖的jar包：
* Spring
* Spring Mvc
* mybatis
* 数据库连接池（C3P0），数据库连接包
* 其他包
参见：[ssm整合依赖的包](https://blog.csdn.net/sinse_/article/details/103329856)
# 三、引入Bootstrap前端框架
帮助我们快速创建前段页面。
1.点击[这里](https://github-production-release-asset-2e65be.s3.amazonaws.com/2126244/9c5b6db6-5245-11e6-800b-b1e5008b1179?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20191201%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20191201T013051Z&X-Amz-Expires=300&X-Amz-Signature=616b6ef032282ab8c9c9f992b098006ba993d2cd6ee0b8a8120abe9421266e73&X-Amz-SignedHeaders=host&actor_id=25889707&response-content-disposition=attachment%3B%20filename%3Dbootstrap-3.3.7-dist.zip&response-content-type=application%2Foctet-stream)下载Bootstrap。在项目webapp目录下，创建一个`static`文件夹，用于存放静态资源。将解压后的bootstrap-3.3.7-dist文件夹复制到`static`目录下。
2.点击[这里](http://www.jq22.com/jquery/jquery-1.11.3.zip)下载jQuery文件。在static目录下新建自己的`js`文件夹并将解压后的jQuery文件复制到`webapp`下的`js`文件夹（即刚刚创建的js文件夹）。
2.在jsp的head中引入jQuery以及css样式：
```jsp
 <script type="text/javascript" src="static/js/jquery.min.js"></script>
 <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
```
# 三、编写ssm整合的关键配置文件
1、web.xml
创建完成后的web.xml应该是：
```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
</web-app>
```
如果不全请补全或点击[这里](https://blog.csdn.net/sinse_/article/details/103337org.springframework.web.context.ContextLoaderListener395)重新生成xml。
在web.xml中配置好Spring容器并设置启动时加载某一处Spring配置文件的位置。如下所示：
```xml
<context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:applicationContext.xml</param-value>
</context-param>
<listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
```
2.在resources文件夹下创建Spring配置文件applicationContext.xml，这个xml主要是配置和业务逻辑有关的代码。
3.在web.xml中配置SpringMVC的前端控制器，用于拦截所有请求。在location处填写SpringMVC配置文件的位置。
```xml
<servlet>
        <servlet-name>dispatcherServlet</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
       <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>location</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
</servlet>
<servlet-mapping>
        <servlet-name>dispatcherServlet</servlet-name>
        <url-pattern>/</url-pattern>
</servlet-mapping>
```
如果不指定springMVC文件的位置，必须在与web.xml同级的目录下创建一个spring配置文件，文件名为servlet名加*-servlet*，即：`dispatcherServlet-servlet`
```xml
 <servlet>
        <servlet-name>dispatcherServlet</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <load-on-startup>1</load-on-startup>
</servlet>
<servlet-mapping>
        <servlet-name>dispatcherServlet</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
```
4.在web.xml中配置字符编码过滤器。**注意：一定要将字符编码过滤器放在所有过滤器之前**
```xml
<filter>
    <filter-name>CharacterEncodingFilter</filter-name>
    <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
    <init-param>
      <param-name>encoding</param-name>
      <param-value>utf-8</param-value>
    </init-param>
    <init-param>
      <param-name>forceRequestEncoding</param-name>
      <param-value>true</param-value>
    </init-param>
    <init-param>
      <param-name>forceResponseEncoding</param-name>
      <param-value>true</param-value>
    </init-param>
 </filter>
 <filter-mapping>
    <filter-name>CharacterEncodingFilter</filter-name>
    <url-pattern>/*</url-pattern>
 </filter-mapping>
```
5.在web.xml中配置HiddenHttpMethodFilter过滤器，使用Rest风格的URI。**注意：拦截器有先后顺序**
```xml
<filter>
    <filter-name>HiddenHttpMethodFilter</filter-name>
    <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
</filter>
<filter-mapping>
    <filter-name>HiddenHttpMethodFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```
6.编写springMVC配置文件（dispatcherServlet-servlet.xml），包含网站跳转逻辑的控制。 设置成只扫描带`@Controller`注解的类。或者设置成只扫描Controller包
base-package：配置要扫描的包
use-default-filters：由于默认是扫描所有的包，将之设置为false，即：使用自己的过滤器。
注意：如果`<context:component-scan>`爆红，原因是头文件引入不全。
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans-4.2.xsd
    http://www.springframework.org/schema/mvc
    http://www.springframework.org/schema/mvc/spring-mvc-4.2.xsd
    http://www.springframework.org/schema/context
    http://www.springframework.org/schema/context/spring-context-4.2.xsd">
    <context:component-scan base-package="com.ssm" use-default-filters="false">
        <!--只扫描控制器-->
        <context:include-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
    </context:component-scan>
```
7.在WEB-INF中创建`views`文件夹，并在dispatcherServlet-servlet.xml中配置视图解析器：
```xml
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/views/"></property>
        <property name="suffix" value=".jsp"></property>
</bean>
```
8.两个标准配置：
```xml
<mvc:default-servlet-handler/>
<mvc:annotation-driven></mvc:annotation-driven>
```
*mvc:default-servlet-handler：将springmvc不能处理的请求交给tomcat，这样就能实现静态动态资源都能访问成功。
*mvc:annotation-driven：能支持springmvc更高级的一些功能。例：JSR303校验，快捷的ajax，映射动态请求。
# 四、编写spring配置文件
**applicationContext.xml**这个xml主要是配置和业务逻辑有关的代码，包括数据源，事务控制等。
0、
* 在resources下创建数据库配置文件**dbconfig.properties**，并编写数据库连接信息；
* 在resources下创建mybatis的全局配置文件：**mybatis-config.xml**；
* 在resources下创建mapper文件夹，用于存放mapper文件。
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019120120593851.png)
注：如果使用的是mysql8，请将驱动改为：`com.mysql.cj.jdbc.Driver`，并添加一行参数:`useSSL=false`。
1、引入数据库配置文件（C3P0），然后在bean中取值即可。
```xml
 <context:property-placeholder location="classpath:dbconfig.properties"/>
    <bean id="pooledDataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
        <property name="jdbcUrl" value="${jdbc.jdbcUrl}"></property>
        <property name="driverClass" value="${jdbc.driverClass}"></property>
        <property name="user" value="${jdbc.user}"></property>
        <property name="password" value="${jdbc.password}"></property>
</bean>
```
2、设置扫描除了控制器以外的其他业务逻辑组件。
```xml
<context:component-scan base-package="com.ssm">
        <context:exclude-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
</context:component-scan>
```
3、配置和mybatis的整合，使用sqlSessionFactoryBean创建sqlSessionFactory。在其中可以配置mybatis sqlSessionFactory创建所需要的东西。
```xml
 <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
        <property name="configLocation" value="classpath:mybatis-config.xml"></property>
        <property name="dataSource" ref="pooledDataSource"></property>
        <property name="mapperLocations" value="classpath:mapper/*.xml"></property>
    </bean>
```
4、配置扫描器，将mybatis接口的实现加入到IOC容器中。因为mybatis接口的实现是一个代理对象，所以需要加入到IOC容器中进行管理。并设置成将扫描到的所有dao接口的实现加入到IOC容器中。
```xml
<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer"> 
        <property name="basePackage" value="com.ssm.dao"></property>
</bean>
```
5、事务控制的配置：事务管理器要能管事务，就得控制数据源，数据源里边连接的开启关闭、回滚操作用事务管理器来做。
```xml
 <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <property name="dataSource" ref="pooledDataSource"></property>
</bean>
```
6、开启基于注解的事务，使用xml配置形式的事务（比较重要的都是使用配置式）。切入点表达式： 任意权限的com.ouc.service下的包括子包的任意参数的方法都可以进行事务管理。
expression的解释：
* 访问权限控制符可以不写；
* com.ssm.service下的所有类所有方法都要进行管理；
* `..`双点的意思是就算service下有子包也行；
* 括号内的`..`表示参数任意多也行。
```xml
    <aop:config>
        <aop:pointcut id="txPoint" expression="execution(* com.ssm.service..*(..))"/>
        <aop:advisor advice-ref="txAdvice" pointcut-ref="txPoint"></aop:advisor>
    </aop:config>
```
配置事务增强，事务如何切入： 
```xml
 <tx:advice id="txAdvice" transaction-manager="transactionManager">
        <tx:attributes>
            <!--代表 这个切入点切入的所有所有方法都是事务方法-->
            <tx:method name="*"></tx:method>
            <!--以get开始的所有方法-->
            <tx:method name="get*" read-only="true"></tx:method>
        </tx:attributes>
</tx:advice>
 ```
**小结：Spring配置文件的核心点：数据源、与mybatis的整合，事务控制**
# 五、编写mybatis的配置文件
1.在mybati-config.xml文件中添加表头：
```xml
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
```
2、编写 \<configuration>：将不好配的setting放在其中。
- 设置驼峰命名规则：
```xml
<settings>
        <setting name="mapUnderscoreToCamelCase" value="true"/>
    </settings>
    <typeAliases>
        <package name="com.ouc.bean"/>
    </typeAliases>
```
- 设置类型别名：
```xml
    <typeAliases>
        <package name="com.ssm.bean"/>
    </typeAliases>
```
# 六、编写数据库
创建tbl_dept表：
```sql
CREATE TABLE `tbl_dept` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(255) NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8
```
创建tbl_emp表：
```sql
CREATE TABLE `tbl_emp` (
  `emp_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `fk_emp_dept` (`d_id`),
  CONSTRAINT `fk_emp_dept` FOREIGN KEY (`d_id`) REFERENCES `tbl_dept` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4002 DEFAULT CHARSET=utf8
```
# 七、使用mybatis逆向工程生成代码
0、导入mybatis generator(`MBG`)所依赖的jar包：
```xml 
<dependency>
    <groupId>org.mybatis.generator</groupId>
    <artifactId>mybatis-generator-core</artifactId>
    <version>1.3.5</version>
</dependency>
```
1、在当前工程下创建一个配置文件：`mgb.xml`,将[官方指引](https://mybatis.org/generator/configreference/xmlconfig.html)中的内容复制到其中。
![复制到mbg.xml配置文件中](https://img-blog.csdnimg.cn/20191202105204263.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbnNlXw==,size_16,color_FFFFFF,t_70)
* 删除`  <classPathEntry location="/Program Files/IBM/SQLLIB/java/db2java.zip" />`这一行，使用自己的。
* 配置数据库链接信息：
```xml
<jdbcConnection driverClass="com.mysql.jdbc.Driver"
                        connectionURL="jdbc:mysql://localhost:3306/ssm"
                        userId="root"
                        password="1234">
</jdbcConnection>
```
* 指定javaBean生成的位置：
```xml
 <javaModelGenerator targetPackage="com.ssm.bean"
                            targetProject=".\src\main\java">
            <property name="enableSubPackages" value="true" />
            <property name="trimStrings" value="true" />
        </javaModelGenerator>
```
* 指定sql映射文件位置：
```xml
<sqlMapGenerator targetPackage="mapper"  targetProject=".\src\main\resources">
   		<property name="enableSubPackages" value="true" />
</sqlMapGenerator>
```
* 指定dao接口生成的位置
```xml
<javaClientGenerator type="XMLMAPPER" targetPackage="com.ssm.dao" targetProject=".\src\main\java">
        <property name="enableSubPackages" value="true" />
</javaClientGenerator>
```
* 指定每个表的生成策略
```xml
        <table tableName="tbl_emp" domainObjectName="Employee"/>
        <table tableName="tbl_dept" domainObjectName="Department"/>
```
* 由于mybatis默认的逆向工程生成的代码注释过多，所以在其中添加配置，设置成不生成注释。
```xml
<commentGenerator>
            <property name="suppressAllComments" value="true"/>
</commentGenerator>
```
2、编写java代码使用逆向工程
点击[这里](https://mybatis.org/generator/running/runningWithJava.html)复制java代码。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191202110644425.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbnNlXw==,size_16,color_FFFFFF,t_70)
在com.ssm.test包下创建一个java类文件，在类中创建main方法，将官方文档中的代码复制进main方法，修改其中配置文件的命名，并导入相应的包和抛出异常：
![com.ssm.test.MBGTest类](https://img-blog.csdnimg.cn/20191203155834663.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbnNlXw==,size_16,color_FFFFFF,t_70)
注意：Configuration∈ `org.mybatis.generator.config.Configuration`\
# 八、新增查询方法
![各个标签的作用](https://img-blog.csdnimg.cn/20191203165145558.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbnNlXw==,size_16,color_FFFFFF,t_70)
1.由于数据库中有两张表，一张员工表，一张部门表。如果想查带有部门名称的员工信息，按照以往的方法，需要发送两次SQL语句，比较影响效率。因此，我们可以新增两个sql联合查询的方法，使之返回带有部门名称的员工信息。
		在EmployeeMapper.java中添加两个方法：
```java
    List<Employee> selectByExampleWithDept(EmployeeExample example);
    Employee selectByPrimaryKeyWithDept(Integer empId);
```
2.在Employee.java中添加一条属性 `private Department department;`，并生成对应的getset方法。
3.将新增的方法添加到mapper文件中。
	0).新增一个resultMap标签，用于设置查询出的结果集：
```xml
  <resultMap id="WithDeptResultMap" type="com.ssm.bean.Employee">
    <id column="emp_id" jdbcType="INTEGER" property="empId" />
    <result column="emp_name" jdbcType="VARCHAR" property="empName" />
    <result column="gender" jdbcType="CHAR" property="gender" />
    <result column="email" jdbcType="VARCHAR" property="email" />
    <result column="d_id" jdbcType="INTEGER" property="dId" />
    <association javaType="com.ssm.bean.Department" property="department">
      <id column="dept_id" property="deptId"></id>
      <result column="dept_name" property="deptName"></result>
    </association>
  </resultMap>
```
	1).在mapper标签中新增一个\<select>标签。id为：`selectByExampleWithDept`(即新增的方法名)，并将`selectByExample`的内容复制过来，由于`refid`并不是`Base_Column_List`要求的那几列，还有新的列，因此需要新增一个sql标签，标签内容为：
```xml
  <sql id="WithDept_Column_List">
    emp_id, emp_name, gender, email, d_id,dept_id,dept_name
  </sql>
```
2).使用 联合查询进行查询带有部门名称的sql语句为：
```sql
SELECT e.emp_id,e.emp_name,e.gender,e.email,e.d_id,d.dept_id,d.dept_name
 FROM tbl_emp e
 LEFT JOIN tbl_dept d ON  e.d_id = d.dept_id
```
修改select标签中的内容，将其改为：
```xml
  <select id="selectByExampleWithDept" resultMap="WithDeptResultMap">
    select
    <if test="distinct">
      distinct
    </if>
    <include refid="WithDept_Column_List" />
    FROM tbl_emp e
    LEFT JOIN tbl_dept d ON  e.d_id = d.dept_id
    <if test="_parameter != null">
      <include refid="Example_Where_Clause" />
    </if>
    <if test="orderByClause != null">
      order by ${orderByClause}
    </if>
  </select>
```
3).由于我们给表增加了别名，所以也会在sql标签中反映出来，修改sql标签为：
```xml
  <sql id="WithDept_Column_List">
    emp_id, emp_name, gender, email, d_id,dept_id,dept_name
  </sql>
```
同样的增加` Employee selectByPrimaryKeyWithDept(Integer empId);`方法
将`dept_name`列添加到结果集中，所以其标签为result。此处注意resultMap和refid的修改。
```xml
 <select id="selectByPrimaryKeyWithDept" resultMap="WithDeptResultMap">
    select
    <include refid="WithDept_Column_List" />
    FROM tbl_emp e
    LEFT JOIN tbl_dept d ON  e.d_id = d.dept_id
    where emp_id = #{empId,jdbcType=INTEGER}
  </select>
```
# 九、测试
在com.ssm.test包下新建MapperTest类。按照[**这个方法**](https://blog.csdn.net/sinse_/article/details/103284440)进行测试。
