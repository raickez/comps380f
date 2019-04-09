package ouhk.comps380f.controller;

import java.io.IOException;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import ouhk.comps380f.model.Attachment;
import ouhk.comps380f.model.Comment;
import ouhk.comps380f.view.DownloadingView;

@Controller
@RequestMapping("lecture")
public class CommentController {

    private Map<Integer, Comment> commentDatabase = new Hashtable<>();

    @RequestMapping(value = "view/{lecture_id}", method = RequestMethod.GET)
    public String view(@PathVariable("lecture_id") int lecture_id,
            ModelMap model) {
        Comment comment = this.commentDatabase.get(lecture_id);
        if (comment == null) {
            return "redirect:/lecture/list";
        }
        model.addAttribute("lecture_id", Integer.toString(lecture_id));
        model.addAttribute("comment", comment);
        return "view";
    }

    @RequestMapping(value = "addcomment", method = RequestMethod.GET)
    public ModelAndView create() {
        return new ModelAndView("view", "commentForm", new Form());
    }

    public static class Form {

        private String username;
        private String comment;
        private int lecture_id;

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getComment() {
            return comment;
        }

        public void setComment(String comment) {
            this.comment = comment;
        }

        public int getLecture_id() {
            return lecture_id;
        }

        public void setLecture_id(int lecture_id) {
            this.lecture_id = lecture_id;
        }
    }

    @RequestMapping(value = "addcomment", method = RequestMethod.POST)
    public View create(Form form) throws IOException {
        Comment comment = new Comment();
        comment.setLecture_id(form.getLecture_id());
        comment.setComment(form.getComment());
        comment.setUsername(form.getUsername());
        
        this.commentDatabase.put(comment.getLecture_id(), comment);
        return new RedirectView("/course/view/" + comment.getLecture_id(), true);
    }

}
