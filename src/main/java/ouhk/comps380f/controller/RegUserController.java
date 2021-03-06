package ouhk.comps380f.controller;

import java.io.IOException;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import ouhk.comps380f.model.LectureUser;
import ouhk.comps380f.dao.LectureUserRepository;
import ouhk.comps380f.service.LectureUserService;

@Controller
@RequestMapping("register")
public class RegUserController {
     
    @Autowired
    private LectureUserService lectureUserService;
    
    @Resource
    LectureUserRepository lectureUserRepo;

    public static class Form {

        private String username;
        private String password;
        private String[] roles;

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public String[] getRoles() {
            return roles;
        }

        public void setRoles(String[] roles) {
            this.roles = roles;
        }
    }

    @RequestMapping(value = "create", method = RequestMethod.GET)
    public ModelAndView create() {
        return new ModelAndView("regUser", "lectureUser", new Form());
    }

    @RequestMapping(value = "create", method = RequestMethod.POST)
    public View create(Form form) throws IOException {
        LectureUser user = new LectureUser(form.getUsername(),
                form.getPassword(), form.getRoles()
        );
        if (lectureUserRepo.findOne(form.getUsername()) != null){
            return new RedirectView("create?error");
        }else {
            lectureUserRepo.save(user);
            return new RedirectView("/login", true);
        }
    }
}