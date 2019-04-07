package ouhk.comps380f.service;

import java.io.IOException;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import ouhk.comps380f.exception.AttachmentNotFound;
import ouhk.comps380f.exception.CourseNotFound;
import ouhk.comps380f.model.Course;

public interface CourseService {

    public long createCourse(String customerName, String subject,
            String body, List<MultipartFile> attachments) throws IOException;

    public List<Course> getCourses();

    public Course getCourse(long id);

    public void updateCourse(long id, String subject,
            String body, List<MultipartFile> attachments)
            throws IOException, CourseNotFound;

    public void delete(long id) throws CourseNotFound;

    public void deleteAttachment(long courseId, String name)
            throws AttachmentNotFound;
}
