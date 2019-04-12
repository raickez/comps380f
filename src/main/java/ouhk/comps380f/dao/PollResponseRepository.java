package ouhk.comps380f.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import ouhk.comps380f.model.PollResponse;

public interface PollResponseRepository extends JpaRepository<PollResponse, Long> {

    @Query("SELECT p FROM PollResponse p WHERE p.poll_id = ?1 AND p.username = ?2")
    public PollResponse findByPollIdAndUsername(long poll_id, String username);
    
    @Query("Select count(p) From PollResponse p WHERE p.poll_id=?1")
    public long countAllByPollId(long poll_id);
    
    @Query("Select count(p) From PollResponse p Where p.poll_id=?1 And p.response = ?2")
    public long countAllByPollIdAndResponse(long poll_id,String response);
    
    @Query("Select response From PollResponse p Where p.poll_id = ?1 And p.username=?2")
    public String findResponseByPollIdAndUsername(long poll_id,String username);
}
