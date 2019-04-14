package ouhk.comps380f.service;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ouhk.comps380f.dao.PollCommentRepository;
import ouhk.comps380f.dao.PollRepository;
import ouhk.comps380f.dao.PollResponseRepository;
import ouhk.comps380f.exception.PollCommentNotFound;
import ouhk.comps380f.model.Poll;
import ouhk.comps380f.model.PollComment;
import ouhk.comps380f.model.PollResponse;
import ouhk.comps380f.exception.PollResponseNotFound;

@Service
public class PollServiceImpl implements PollService {

    @Resource
    private PollRepository pollRepo;

    @Resource
    private PollCommentRepository pollCommentRepo;

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

    @Override
    @Transactional
    public long countAllByPollId(long poll_id) {
        return pollResponseRepo.countAllByPollId(poll_id);
    }

    @Override
    @Transactional
    public long countAllByPollIdAndResponse(long poll_id, String response) {
        return pollResponseRepo.countAllByPollIdAndResponse(poll_id, response);
    }

    @Override
    @Transactional
    public String findResponseByPollIdAndUsername(long poll_id, String username) {
        return pollResponseRepo.findResponseByPollIdAndUsername(poll_id, username);
    }

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
        } else {
            pollResponseRepo.delete(deletedPollAns);
            PollResponse savedPollResponse = pollResponseRepo.save(pollResponse);
        }

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

    @Override
    @Transactional(rollbackFor = PollResponseNotFound.class)
    public void delPoll(long poll_id) throws Exception {
        Poll deletedPoll = pollRepo.findPollByPollId(poll_id);
        List<PollResponse> deletedPollAns = pollResponseRepo.findAnsPollByPollId(poll_id);
        if (deletedPollAns == null) {
            throw new Exception();
        }
        pollResponseRepo.delete(deletedPollAns);
        pollRepo.delete(deletedPoll);
    }

    @Override
    @Transactional
    public long createComment(String username, String cm,
            long poll_id) throws Exception {
        PollComment comment = new PollComment();
        Poll poll = new Poll();

        comment.setUsername(username);
        comment.setComment(cm);
        poll.setPoll_id(poll_id);
        comment.setPoll_id(poll_id);
        comment.setPoll(poll);

        PollComment savedComment = pollCommentRepo.save(comment);
        return savedComment.getId();
    }

    @Override
    @Transactional
    public List<PollComment> getComment(long poll_id) {
        return pollCommentRepo.findAllPollCommentByPollId(poll_id);
    }

    @Override
    @Transactional(rollbackFor = PollCommentNotFound.class)
    public void delComment(long id) throws PollCommentNotFound {
        PollComment deletedComment = pollCommentRepo.findOne(id);
        if (deletedComment == null) {
            throw new PollCommentNotFound();
        }
        pollCommentRepo.delete(deletedComment);
    }

    @Override
    @Transactional(rollbackFor = PollCommentNotFound.class)
    public void delAllComment(long pollId) throws PollCommentNotFound {
        List<PollComment> deletedAllComment = pollCommentRepo.findAllPollCommentByPollId(pollId);
        if (deletedAllComment == null) {
            throw new PollCommentNotFound();
        }
        pollCommentRepo.delete(deletedAllComment);
    }
}
