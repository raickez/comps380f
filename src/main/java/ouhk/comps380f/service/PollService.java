package ouhk.comps380f.service;

import java.io.IOException;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import ouhk.comps380f.exception.AttachmentNotFound;
import ouhk.comps380f.exception.PollNotFound;
import ouhk.comps380f.exception.PollResponseNotFound;
import ouhk.comps380f.model.Poll;

public interface PollService {

    public long createPoll(String question, String response1,String response2,String response3,String response4) throws Exception;
    
    public List<Poll> getPolls();
    
    public Poll getPoll(long poll_id);
    
    public void ansPoll(long poll_id,String username,String response) throws Exception;
    
    public void delPollAns(long id,String username) throws Exception;

    /*public List<Lecture> getLectures();

    public void updateLecture(long id, String subject,
            String body, List<MultipartFile> attachments)
            throws IOException, LectureNotFound;

    public void deleteAttachment(long lectureId, String name)
            throws AttachmentNotFound;*/
}
