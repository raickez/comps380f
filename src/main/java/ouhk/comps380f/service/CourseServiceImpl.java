package ouhk.comps380f.service;

import java.io.IOException;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import ouhk.comps380f.dao.AttachmentRepository;
import ouhk.comps380f.dao.CourseRepository;
import ouhk.comps380f.exception.AttachmentNotFound;
import ouhk.comps380f.exception.CourseNotFound;
import ouhk.comps380f.model.Attachment;
import ouhk.comps380f.model.Course;

@Service
public class CourseServiceImpl implements CourseService {

    @Resource
    private CourseRepository courseRepo;

    @Resource
    private AttachmentRepository attachmentRepo;

    @Override
    @Transactional
    public List<Course> getCourses() {
        return courseRepo.findAll();
    }

    @Override
    @Transactional
    public Course getCourse(long id) {
        return courseRepo.findOne(id);
    }

    @Override
    @Transactional(rollbackFor = CourseNotFound.class)
    public void delete(long id) throws CourseNotFound {
        Course deletedCourse = courseRepo.findOne(id);
        if (deletedCourse == null) {
            throw new CourseNotFound();
        }
        courseRepo.delete(deletedCourse);
    }

    @Override
    @Transactional(rollbackFor = AttachmentNotFound.class)
    public void deleteAttachment(long courseId, String name) throws AttachmentNotFound {
        Course course = courseRepo.findOne(courseId);
        for (Attachment attachment : course.getAttachments()) {
            if (attachment.getName().equals(name)) {
                course.deleteAttachment(attachment);
                courseRepo.save(course);
                return;
            }
        }
        throw new AttachmentNotFound();
    }

    @Override
    @Transactional
    public long createCourse(String lecturerName, String subject,
            String body, List<MultipartFile> attachments) throws IOException {
        Course course = new Course();
        course.setLecturerName(lecturerName);
        course.setSubject(subject);
        course.setBody(body);

        for (MultipartFile filePart : attachments) {
            Attachment attachment = new Attachment();
            attachment.setName(filePart.getOriginalFilename());
            attachment.setMimeContentType(filePart.getContentType());
            attachment.setContents(filePart.getBytes());
            attachment.setCourse(course);
            if (attachment.getName() != null && attachment.getName().length() > 0
                    && attachment.getContents() != null
                    && attachment.getContents().length > 0) {
                course.getAttachments().add(attachment);
            }
        }
        Course savedCourse = courseRepo.save(course);
        return savedCourse.getId();
    }

    @Override
    @Transactional(rollbackFor = CourseNotFound.class)
    public void updateCourse(long id, String subject,
            String body, List<MultipartFile> attachments)
            throws IOException, CourseNotFound {
        Course updatedCourse = courseRepo.findOne(id);
        if (updatedCourse == null) {
            throw new CourseNotFound();
        }

        updatedCourse.setSubject(subject);
        updatedCourse.setBody(body);

        for (MultipartFile filePart : attachments) {
            Attachment attachment = new Attachment();
            attachment.setName(filePart.getOriginalFilename());
            attachment.setMimeContentType(filePart.getContentType());
            attachment.setContents(filePart.getBytes());
            attachment.setCourse(updatedCourse);
            if (attachment.getName() != null && attachment.getName().length() > 0
                    && attachment.getContents() != null
                    && attachment.getContents().length > 0) {
                updatedCourse.getAttachments().add(attachment);
            }
        }
        courseRepo.save(updatedCourse);
    }
}
