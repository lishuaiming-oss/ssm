package com.javakc.ssm.attachment.service;

import com.javakc.ssm.attachment.entity.Attachment;

import java.util.List;
import java.util.Map;

/**
 * @Author:lishuaiming
 * @Description:
 * @Date:Create in 20:52 2021/1/12
 * @Modified by:
 */
public interface AttachmentService {
    int insert(Attachment entity);
    int update(Attachment entity);
    int delete(int id);
    List<Attachment> queryAll();
    List<Attachment> queryByPage(Map<String,Object> params);
    long queryByCount(Map<String,Object> params);
    Attachment queryById(int id);
}
