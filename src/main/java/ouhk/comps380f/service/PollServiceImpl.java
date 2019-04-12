package ouhk.comps380f.service;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ouhk.comps380f.dao.PollRepository;
import ouhk.comps380f.dao.PollResponseRepository;
import ouhk.comps380f.model.Poll;
import ouhk.comps380f.model.PollResponse;
import ouhk.comps380f.exception.PollResponseNotFound;

@Service
public class PollServiceImpl implements PollService {

    @Resource
    private PollRepository pollRepo;

    @Resource
    private PollResponseRepository pollResponseRepo;

    @Override
    @Transactional
    public List<Poll> getPolls() {
        return pollRepo.findAll();
    }

    @Override
    @Transactional
    public Poll getPoll(long poll_id) {
        return pollRepo.findOne(poll_id);
    }

    /*@Override
    @Transactional(rollbackFor = CommentNotFound.class)
    public void delComment(long id) throws CommentNotFound {
        Comment deletedComment = commentRepo.findOne(id);
        if (deletedComment == null) {
            throw new CommentNotFound();
        }
        commentRepo.delete(deletedComment);
    }*/
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

    @Override
    @Transactional
    public void ansPoll(long poll_id, String username, String response) throws Exception, PollResponseNotFound {
        PollResponse pollResponse = new PollResponse();

        pollResponse.setPoll_id(poll_id);
        pollResponse.setUsername(username);
        pollResponse.setResponse(response);
        //delPollAns(poll_id,username);
        PollResponse deletedPollAns = pollResponseRepo.findByPollIdAndUsername(poll_id, username);
        if (deletedPollAns == null) {
            PollResponse savedPollResponse = pollResponseRepo.save(pollResponse);
        }else{
        pollResponseRepo.delete(deletedPollAns);
        PollResponse savedPollResponse = pollResponseRepo.save(pollResponse);}

        
    }

    @Override
    @Transactional(rollbackFor = PollResponseNotFound.class)
    public void delPollAns(long poll_id, String username) throws Exception {
        PollResponse deletedPollAns = pollResponseRepo.findByPollIdAndUsername(poll_id, username);
        if (deletedPollAns == null) {
            throw new Exception();
        }
        pollResponseRepo.delete(deletedPollAns);
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
