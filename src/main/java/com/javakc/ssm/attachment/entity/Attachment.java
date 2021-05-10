package com.javakc.ssm.attachment.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

/**
 * @Author:lishuaiming
 * @Description:
 * @Date:Create in 18:20 2021/1/12
 * @Modified by:
 */
@Getter
@Setter
@ToString
public class Attachment {
     private int id;
     private  String name;
     private String realName;
     private String filePath;
     private String type;
     private long sizes;
     private Date createTime;
     private int downNumber;
     private int state;
}
