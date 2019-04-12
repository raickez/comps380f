package ouhk.comps380f.service;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ouhk.comps380f.dao.PollRepository;
import ouhk.comps380f.model.Poll;

@Service
public class PollServiceImpl implements PollService {

    @Resource
    private PollRepository pollRepo;

    @Override
    @Transactional
    public List<Poll> getPolls() {
        return pollRepo.findAll();
    }

    /*@Override
    @Transactional
    public List<Poll> getPoll(long poll_id) {
        return pollRepo.findAllByPollId(poll_id);
    }*/

    /*@Override
    @Transactional(rollbackFor = CommentNotFound.class)
    public void delComment(long id) throws CommentNotFound {
        Comment deletedComment = commentRepo.findOne(id);
        if (deletedComment == null) {
            throw new CommentNotFound();
        }
        commentRepo.delete(deletedComment);
    }*/

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
    public long createPoll(String question, String response1, String response2,
            String response3, String response4) throws Exception {
        Poll poll = new Poll();

        poll.setQuestion(question);
        poll.setResponse1(response1);
        poll.setResponse2(response2);
        poll.setResponse3(response3);
        poll.setResponse4(response4);

        Poll savedPoll = pollRepo.save(poll);
        return savedPoll.getPoll_id();
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
