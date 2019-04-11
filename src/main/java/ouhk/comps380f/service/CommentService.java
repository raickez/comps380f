package ouhk.comps380f.service;

import java.io.IOException;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import ouhk.comps380f.exception.AttachmentNotFound;
import ouhk.comps380f.exception.CommentNotFound;
import ouhk.comps380f.model.Comment;

public interface CommentService {

    public long createComment(String username, String cm,
            long lecture_id) throws Exception;

    /*public List<Lecture> getLectures();

    public Lecture getLecture(long id);

    public void updateLecture(long id, String subject,
            String body, List<MultipartFile> attachments)
            throws IOException, LectureNotFound;

    public void delete(long id) throws LectureNotFound;

    public void deleteAttachment(long lectureId, String name)
            throws AttachmentNotFound;*/
}
