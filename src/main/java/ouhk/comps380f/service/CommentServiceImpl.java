package ouhk.comps380f.service;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ouhk.comps380f.dao.CommentRepository;
import ouhk.comps380f.model.Comment;
import ouhk.comps380f.model.Lecture;
import ouhk.comps380f.exception.CommentNotFound;

@Service
public class CommentServiceImpl implements CommentService {

    @Resource
    private CommentRepository commentRepo;

    @Override
    @Transactional
    public List<Comment> getComment(long lectureId) {
        return commentRepo.findAllByLectureId(lectureId);
    }

    @Override
    @Transactional(rollbackFor = CommentNotFound.class)
    public void delComment(long id) throws CommentNotFound {
        Comment deletedComment = commentRepo.findOne(id);
        if (deletedComment == null) {
            throw new CommentNotFound();
        }
        commentRepo.delete(deletedComment);
    }

    /*
    @Override
    @Transactional
    public List<Comment> getLectures() {
        return commentRepo.findAll();
    }

    @Override
    @Transactional(rollbackFor = AttachmentNotFound.class)
    public void deleteAttachment(long lectureId, String name) throws AttachmentNotFound {
        Lecture lecture = lectureRepo.findOne(lectureId);
        for (Attachment attachment : lecture.getAttachments()) {
            if (attachment.getName().equals(name)) {
                lecture.deleteAttachment(attachment);
                lectureRepo.save(lecture);
                return;
            }
        }
        throw new AttachmentNotFound();
    }
     */
    @Override
    @Transactional
    public long createComment(String username, String cm,
            long lecture_id) throws Exception {
        Comment comment = new Comment();
        Lecture lecture = new Lecture();

        comment.setUsername(username);
        comment.setComment(cm);
        lecture.setId(lecture_id);
        comment.setLecture_id(lecture_id);
        comment.setLecture(lecture);

        Comment savedComment = commentRepo.save(comment);
        return savedComment.getId();
    }

    /*(@Override
    @Transactional(rollbackFor = LectureNotFound.class)
    public void updateLecture(long id, String subject,
            String body, List<MultipartFile> attachments)
            throws IOException, LectureNotFound {
        Lecture updatedLecture = lectureRepo.findOne(id);
        if (updatedLecture == null) {
            throw new LectureNotFound();
        }

        updatedLecture.setSubject(subject);
        updatedLecture.setBody(body);

        for (MultipartFile filePart : attachments) {
            Attachment attachment = new Attachment();
            attachment.setName(filePart.getOriginalFilename());
            attachment.setMimeContentType(filePart.getContentType());
            attachment.setContents(filePart.getBytes());
            attachment.setLecture(updatedLecture);
            if (attachment.getName() != null && attachment.getName().length() > 0
                    && attachment.getContents() != null
                    && attachment.getContents().length > 0) {
                updatedLecture.getAttachments().add(attachment);
            }
        }
        lectureRepo.save(updatedLecture);
    }*/
}
