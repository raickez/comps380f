package ouhk.comps380f.service;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ouhk.comps380f.dao.LectureUserRepository;
import ouhk.comps380f.model.LectureUser;
import ouhk.comps380f.model.UserRole;

@Service
public class LectureUserService implements UserDetailsService {

    @Resource
    LectureUserRepository lectureUserRepo;

    @Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {
        LectureUser lectureUser = lectureUserRepo.findOne(username);
        if (lectureUser == null) {
            throw new UsernameNotFoundException("User '" + username + "' not found.");
        }
        List<GrantedAuthority> authorities = new ArrayList<>();
        for (UserRole role : lectureUser.getRoles()) {
            authorities.add(new SimpleGrantedAuthority(role.getRole()));
        }
        return new User(lectureUser.getUsername(), lectureUser.getPassword(), authorities);
    }
}
