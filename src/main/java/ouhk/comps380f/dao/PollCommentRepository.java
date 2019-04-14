package ouhk.comps380f.dao;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import ouhk.comps380f.model.PollComment;

public interface PollCommentRepository extends JpaRepository<PollComment, Long> {

    @Query("Select p From PollComment p Where p.poll_id = ?1")
    public List<PollComment> findAllPollCommentByPollId(long poll_id);
}
