package ouhk.comps380f.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import ouhk.comps380f.model.CourseUser;

public interface CourseUserRepository extends JpaRepository<CourseUser, String> {
}
