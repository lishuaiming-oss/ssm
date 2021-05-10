package com.javakc.ssm.attachment.service.impl;

import com.javakc.ssm.attachment.dao.AttachmentDao;
import com.javakc.ssm.attachment.entity.Attachment;
import com.javakc.ssm.attachment.service.AttachmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * @Author:lishuaiming
 * @Description:
 * @Date:Create in 20:54 2021/1/12
 * @Modified by:
 */
@Service
public class AttachmentServiceImpl implements AttachmentService {

    @Autowired
   private AttachmentDao attachmentDao;
    @Override
    public int insert(Attachment entity) {

        return attachmentDao.insert(entity);
    }

    @Override
    public int update(Attachment entity) {
        return 0;
    }

    @Override
    public int delete(int id) {
        Attachment entity=attachmentDao.queryById(id);
        int result=attachmentDao.delete(id);
         //判断文件是否存在  判断先删除数据库 在删除文件
        if (result==1){

            File file=new File(entity.getFilePath());
            file.delete();
        }
        return result;
    }

    @Override
    public List<Attachment> queryAll() {
        return attachmentDao.queryAll();
    }

    @Override
    public List<Attachment> queryByPage(Map<String, Object> params) {
        return null;
    }

    @Override
    public long queryByCount(Map<String, Object> params) {
        return 0;
    }

    @Override
    public Attachment queryById(int id) {

        return attachmentDao.queryById(id);
    }
}
