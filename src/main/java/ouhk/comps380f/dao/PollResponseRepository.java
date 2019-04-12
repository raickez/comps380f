package ouhk.comps380f.dao;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import ouhk.comps380f.model.PollResponse;

public interface PollResponseRepository extends JpaRepository<PollResponse, Long> {
}
