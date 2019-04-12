package ouhk.comps380f.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import ouhk.comps380f.model.PollResponse;

public interface PollResponseRepository extends JpaRepository<PollResponse, Long> {

    @Query("SELECT p FROM PollResponse p WHERE p.poll_id = ?1 AND p.username = ?2")
    public PollResponse findByPollIdAndUsername(long poll_id, String username);
}
