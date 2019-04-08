package ouhk.comps380f.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import ouhk.comps380f.exception.AttachmentNotFound;
import ouhk.comps380f.exception.CourseNotFound;
import ouhk.comps380f.model.Attachment;
import ouhk.comps380f.model.Course;
import ouhk.comps380f.service.AttachmentService;
import ouhk.comps380f.service.CourseService;
import ouhk.comps380f.view.DownloadingView;

@Controller
@RequestMapping("course")
public class CourseController {

    @Autowired
    private CourseService courseService;

    @Autowired
    private AttachmentService attachmentService;

    @RequestMapping(value = {"", "list"}, method = RequestMethod.GET)
    public String list(ModelMap model) {
        model.addAttribute("courseDatabase", courseService.getCourses());
        return "list";
    }

    @RequestMapping(value = "create", method = RequestMethod.GET)
    public ModelAndView create() {
        return new ModelAndView("add", "courseForm", new Form());
    }

    public static class Form {

        private String subject;
        private String body;
        private List<MultipartFile> attachments;

        public String getSubject() {
            return subject;
        }

        public void setSubject(String subject) {
            this.subject = subject;
        }

        public String getBody() {
            return body;
        }

        public void setBody(String body) {
            this.body = body;
        }

        public List<MultipartFile> getAttachments() {
            return attachments;
        }

        public void setAttachments(List<MultipartFile> attachments) {
            this.attachments = attachments;
        }

    }

    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String create(Form form, Principal principal) throws IOException {
        long courseId = courseService.createCourse(principal.getName(),
                form.getSubject(), form.getBody(), form.getAttachments());
        return "redirect:/course/view/" + courseId;
    }

    @RequestMapping(value = "view/{courseId}", method = RequestMethod.GET)
    public String view(@PathVariable("courseId") long courseId,
            ModelMap model) {
        Course course = courseService.getCourse(courseId);
        if (course == null) {
            return "redirect:/course/list";
        }
        model.addAttribute("course", course);
        return "view";
    }

    @RequestMapping(
            value = "/{courseId}/attachment/{attachment:.+}",
            method = RequestMethod.GET
    )
    public View download(@PathVariable("courseId") long courseId,
            @PathVariable("attachment") String name) {
        Attachment attachment = attachmentService.getAttachment(courseId, name);
        if (attachment != null) {
            return new DownloadingView(attachment.getName(),
                    attachment.getMimeContentType(), attachment.getContents());
        }
        return new RedirectView("/course/list", true);
    }

    @RequestMapping(value = "delete/{courseId}", method = RequestMethod.GET)
    public String deleteCourse(@PathVariable("courseId") long courseId)
            throws CourseNotFound {
        courseService.delete(courseId);
        return "redirect:/course/list";
    }

    @RequestMapping(value = "edit/{courseId}", method = RequestMethod.GET)
    public ModelAndView showEdit(@PathVariable("courseId") long courseId,
            Principal principal, HttpServletRequest request) {
        Course course = courseService.getCourse(courseId);
        if (course == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(course.getLecturerName()))) {
            return new ModelAndView(new RedirectView("/course/list", true));
        }

        ModelAndView modelAndView = new ModelAndView("edit");
        modelAndView.addObject("course", course);

        Form courseForm = new Form();
        courseForm.setSubject(course.getSubject());
        courseForm.setBody(course.getBody());
        modelAndView.addObject("courseForm", courseForm);

        return modelAndView;
    }

    @RequestMapping(value = "edit/{courseId}", method = RequestMethod.POST)
    public View edit(@PathVariable("courseId") long courseId, Form form,
            Principal principal, HttpServletRequest request)
            throws IOException, CourseNotFound {
        Course course = courseService.getCourse(courseId);
        if (course == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(course.getLecturerName()))) {
            return new RedirectView("/course/list", true);
        }

        courseService.updateCourse(courseId, form.getSubject(),
                form.getBody(), form.getAttachments());
        return new RedirectView("/course/view/" + courseId, true);
    }

    @RequestMapping(
            value = "/{courseId}/delete/{attachment:.+}",
            method = RequestMethod.GET
    )
    public String deleteAttachment(@PathVariable("courseId") long courseId,
            @PathVariable("attachment") String name) throws AttachmentNotFound {
        courseService.deleteAttachment(courseId, name);
        return "redirect:/course/edit/" + courseId;
    }
}
