package com.javakc.ssm.attachment.controller;

import com.javakc.ssm.attachment.entity.Attachment;
import com.javakc.ssm.attachment.service.AttachmentService;
import com.javakc.ssm.logger.annotation.LoggerAdvice;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * @Author:lishuaiming
 * @Description:
 * @Date:Create in 20:57 2021/1/12
 * @Modified by:
 */
@Controller
@RequestMapping("attachment")
@LoggerAdvice(operations ="附件管理")
public class AttachmentController {

    //动态的存储路径
    @Value("#{properties.path}")
    private String path;
    //基于存储路径的实现，日期目录
    private String datePath;
    @Autowired
    AttachmentService attachmentService;
    public AttachmentController(@Value("#{properties.path}") String path) {
        this.path = path;
        task();
    }
     @RequestMapping("query")
     @LoggerAdvice(operations = "附件查询")
    public String query(ModelMap model)
    {
     model.put("list",attachmentService.queryAll());
      return "attachment/list";
    }

    @RequestMapping(value = "insert",method= RequestMethod.POST)
    @LoggerAdvice(operations = "附加上传")
    public String insert(@RequestParam MultipartFile loadFile) throws IOException {
        /*System.out.println("用户上传的文件名称为:"+loadFile.getOriginalFilename());
           开发环境为windows
           生产环境为 Linux
        */
       // System.out.println(path);
       // name为了防止用户上传同名文件
         //用户上传文件名称
        String name=loadFile.getOriginalFilename();
        //loadFile.transferTo(Path.of(path+loadFile.getOriginalFilename()));
        //服务器存储文件名称  产生一个36位不重复字符串
        String realName= UUID.randomUUID().toString();
        //讲附件按路径+name写入服务器
        loadFile.transferTo(Path.of(datePath+ File.separator +realName));

        Attachment entity=new Attachment();
        entity.setName(name);
        entity.setRealName(realName);
        entity.setFilePath(datePath+ File.separator +realName);
        entity.setSizes(loadFile.getSize());
        entity.setCreateTime(new Date());
        assert  name!=null;//验证
        entity.setType(name.substring(name.lastIndexOf(".")+1) );
        attachmentService.insert(entity);

        return "redirect:query.do";
    }

   //定时器
    @Scheduled(cron = "0 0 0 * * ?")
     public void task()
     {
         SimpleDateFormat format=new SimpleDateFormat("yyyy/MM/dd");//SimpleDateFormat 转换格式
         String date=format.format(new Date()); //将日期转换为字符串

         //path:
         //date
          //文件本身信息
         datePath=path+date;
         File dateFile=new File(datePath);
         /*if(!dateFile.exists()){
             dateFile.mkdirs();//建立目录
         }*/
         dateFile.mkdirs();//建立目录
     }

     //下载
    @RequestMapping("download/{id}")
    @LoggerAdvice(operations = "附件下载")
    public void download(@PathVariable int id, HttpServletResponse response) throws IOException {
        //1.根据主键查询要下载的附件
       Attachment attachment=attachmentService.queryById(id);
        //2.根据查询到的附件信息下载附件
        String name=attachment.getName();
        File file=new File(attachment.getFilePath());
        //判断文件是否存在
        if(file.exists()){
           //3.以流的方式执行返回相应流
            response.reset();
            response.setContentType("application/octet-stream; charset=utf-8");
            response.setHeader("Content-Disposition", "attachment; filename="+new String(name.getBytes(StandardCharsets.UTF_8),"ISO8859-1"));
            //new String(name.getBytes(StandardCharsets.UTF_8),charsetName:"ISO8859-1")
            OutputStream out = response.getOutputStream();
            out.write(FileUtils.readFileToByteArray(file));
            out.flush();
            out.close();

        }
    }
    //删除附件
    @RequestMapping("delete/{id}")
    @LoggerAdvice(operations = "附件删除")
    public String delete(@PathVariable int id)
    {
        attachmentService.delete(id);
        return "redirect:/attachment/query.do";
    }

}
