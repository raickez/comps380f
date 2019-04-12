package ouhk.comps380f.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import ouhk.comps380f.model.Poll;

public interface PollRepository extends JpaRepository<Poll, Long> {
    @Query("Select p From Poll p Where p.poll_id = ?1")
    public Poll findPollByPollId(long poll_id);
}
