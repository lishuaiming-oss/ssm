package com.javakc.ssm.attachment.dao;

import com.javakc.ssm.attachment.entity.Attachment;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @Author:lishuaiming
 * @Description:
 * @Date:Create in 18:53 2021/1/12
 * @Modified by:
 */
@Repository
public interface AttachmentDao {
  int insert(Attachment entity);
  int update(Attachment entity);
  int delete(int id);
  List<Attachment> queryAll();
  List<Attachment> queryByPage(Map<String,Object> params);
  long queryByCount(Map<String,Object> params);
  Attachment queryById(int id);
 // 去扫描spring-mybatis 代理类 org.mybatis.spring.mapper.MapperScannerConfigurer
}
