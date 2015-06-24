package com.wonders.stpt.bid.service.impl;

import com.wonders.stpt.bid.dao.AttachmentDao;
import com.wonders.stpt.bid.domain.Attachment;
import com.wonders.stpt.bid.service.IAttachmentService;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageBounds;
import com.wonders.stpt.bid.utils.paginator.mybatis.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2014/8/29.
 */
@Service
public class AttachmentServiceImpl implements IAttachmentService {

    @Autowired
    private AttachmentDao attachmentDao;

    @Override
    public PageList<Attachment> getAttachments(Attachment attachment, Integer pageIndex, Integer pageSize) throws Exception {
            return attachmentDao.select(attachment,pageIndex, pageSize);
    }

    @Override
    public PageList<Attachment> getAttachments(Attachment attachment) throws Exception {
        return getAttachments(attachment,null,null);
    }

    @Override
    public Attachment getAttachment(String attachmentId) throws Exception {
    	Attachment a = attachmentDao.selectById(attachmentId);
        /*Attachment attachment = new Attachment();
        attachment.setRemoved("0");
        attachment.setAttachmentId(attachmentId);
        PageList<Attachment> attachments =getAttachments(attachment);

        if(attachments != null && attachments.size() == 1){
            return attachments.get(0);
        }*/
        return a;
    }

    @Override
    public int delete(List<String> attachmentIds) throws Exception {
        int i = 0;
        for (String attachmentId : attachmentIds) {
            Attachment attachment = new Attachment();
            attachment.setAttachmentId(attachmentId);
            attachment.setRemoved("2");
            update(attachment,false);
            i++;
        }
        return i;
    }

    @Override
    public int delete(String attachmentId) throws Exception {
        ArrayList<String> attachmentIds = new ArrayList<String>();
        attachmentIds.add(attachmentId);
        return delete(attachmentIds);
    }

    @Override
    public void save(Attachment attachment, String[] excludes) throws Exception {
            attachmentDao.insert(attachment);
    }

    @Override
    public void update(Attachment attachment, boolean isDynamic) throws Exception {
        attachmentDao.update(attachment,isDynamic);
    }
}
