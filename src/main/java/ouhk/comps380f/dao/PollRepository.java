package ouhk.comps380f.dao;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import ouhk.comps380f.model.Poll;

public interface PollRepository extends JpaRepository<Poll, Long> {
    //public List<Poll> findAllBypoll_Id(long poll_Id);
}
