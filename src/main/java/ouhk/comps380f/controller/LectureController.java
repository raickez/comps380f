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
import ouhk.comps380f.exception.CommentNotFound;
import ouhk.comps380f.exception.LectureNotFound;
import ouhk.comps380f.model.Attachment;
import ouhk.comps380f.model.Lecture;
import ouhk.comps380f.service.AttachmentService;
import ouhk.comps380f.service.LectureService;
import ouhk.comps380f.service.CommentService;
import ouhk.comps380f.service.PollService;
import ouhk.comps380f.view.DownloadingView;

@Controller
@RequestMapping("lecture")
public class LectureController {

    @Autowired
    private LectureService lectureService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private AttachmentService attachmentService;

    @Autowired
    private PollService pollService;

    @RequestMapping(value = {"", "list"}, method = RequestMethod.GET)
    public String list(ModelMap model) {
        model.addAttribute("lectureDatabase", lectureService.getLectures());
        model.addAttribute("pollDatabase", pollService.getPolls());
        return "list";
    }

    @RequestMapping(value = "create", method = RequestMethod.GET)
    public ModelAndView create() {
        return new ModelAndView("add", "lectureForm", new Form());
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
        long lectureId = lectureService.createLecture(principal.getName(),
                form.getSubject(), form.getBody(), form.getAttachments());
        return "redirect:/lecture/view/" + lectureId;
    }

    @RequestMapping(value = "view/{lectureId}", method = RequestMethod.GET)
    public String view(@PathVariable("lectureId") long lectureId,
            ModelMap model) {
        Lecture lecture = lectureService.getLecture(lectureId);
        if (lecture == null) {
            return "redirect:/lecture/list";
        }
        model.addAttribute("lecture", lecture);
        //modifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodified
        model.addAttribute("commentDatabase", commentService.getComment(lectureId));
        return "view";
    }

    @RequestMapping(
            value = "/{lectureId}/attachment/{attachment:.+}",
            method = RequestMethod.GET
    )
    public View download(@PathVariable("lectureId") long lectureId,
            @PathVariable("attachment") String name) {
        Attachment attachment = attachmentService.getAttachment(lectureId, name);
        if (attachment != null) {
            return new DownloadingView(attachment.getName(),
                    attachment.getMimeContentType(), attachment.getContents());
        }
        return new RedirectView("/lecture/list", true);
    }

    @RequestMapping(value = "delete/{lectureId}", method = RequestMethod.GET)
    public String deleteLecture(@PathVariable("lectureId") long lectureId)
            throws LectureNotFound, CommentNotFound {
        commentService.delAllComment(lectureId);
        lectureService.delete(lectureId);
        return "redirect:/lecture/list";
    }

    @RequestMapping(value = "edit/{lectureId}", method = RequestMethod.GET)
    public ModelAndView showEdit(@PathVariable("lectureId") long lectureId,
            Principal principal, HttpServletRequest request) {
        Lecture lecture = lectureService.getLecture(lectureId);
        if (lecture == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(lecture.getCustomerName()))) {
            return new ModelAndView(new RedirectView("/lecture/list", true));
        }

        ModelAndView modelAndView = new ModelAndView("edit");
        modelAndView.addObject("lecture", lecture);

        Form lectureForm = new Form();
        lectureForm.setSubject(lecture.getSubject());
        lectureForm.setBody(lecture.getBody());
        modelAndView.addObject("lectureForm", lectureForm);

        return modelAndView;
    }

    @RequestMapping(value = "edit/{lectureId}", method = RequestMethod.POST)
    public View edit(@PathVariable("lectureId") long lectureId, Form form,
            Principal principal, HttpServletRequest request)
            throws IOException, LectureNotFound {
        Lecture lecture = lectureService.getLecture(lectureId);
        if (lecture == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(lecture.getCustomerName()))) {
            return new RedirectView("/lecture/list", true);
        }

        lectureService.updateLecture(lectureId, form.getSubject(),
                form.getBody(), form.getAttachments());
        return new RedirectView("/lecture/view/" + lectureId, true);
    }

    @RequestMapping(
            value = "/{lectureId}/delete/{attachment:.+}",
            method = RequestMethod.GET
    )
    public String deleteAttachment(@PathVariable("lectureId") long lectureId,
            @PathVariable("attachment") String name) throws AttachmentNotFound {
        lectureService.deleteAttachment(lectureId, name);
        return "redirect:/lecture/edit/" + lectureId;
    }

    //中文
    @RequestMapping(value = "zh/list", method = RequestMethod.GET)
    public String zh_list(ModelMap model) {
        model.addAttribute("lectureDatabase", lectureService.getLectures());
        model.addAttribute("pollDatabase", pollService.getPolls());
        return "zh_list";
    }

    @RequestMapping(value = "zh/view/{lectureId}", method = RequestMethod.GET)
    public String zh_view(@PathVariable("lectureId") long lectureId,
            ModelMap model) {
        Lecture lecture = lectureService.getLecture(lectureId);
        if (lecture == null) {
            return "redirect:/lecture/list";
        }
        model.addAttribute("lecture", lecture);
        //modifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodifiedmodified
        model.addAttribute("commentDatabase", commentService.getComment(lectureId));
        return "zh_view";
    }

    @RequestMapping(value = "zh/edit/{lectureId}", method = RequestMethod.GET)
    public ModelAndView zh_showEdit(@PathVariable("lectureId") long lectureId,
            Principal principal, HttpServletRequest request) {
        Lecture lecture = lectureService.getLecture(lectureId);
        if (lecture == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(lecture.getCustomerName()))) {
            return new ModelAndView(new RedirectView("/lecture/zh/list", true));
        }

        ModelAndView modelAndView = new ModelAndView("zh_edit");
        modelAndView.addObject("lecture", lecture);

        Form lectureForm = new Form();
        lectureForm.setSubject(lecture.getSubject());
        lectureForm.setBody(lecture.getBody());
        modelAndView.addObject("lectureForm", lectureForm);

        return modelAndView;
    }

    @RequestMapping(value = "zh/edit/{lectureId}", method = RequestMethod.POST)
    public View zh_edit(@PathVariable("lectureId") long lectureId, Form form,
            Principal principal, HttpServletRequest request)
            throws IOException, LectureNotFound {
        Lecture lecture = lectureService.getLecture(lectureId);
        if (lecture == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(lecture.getCustomerName()))) {
            return new RedirectView("/lecture/zh/list", true);
        }

        lectureService.updateLecture(lectureId, form.getSubject(),
                form.getBody(), form.getAttachments());
        return new RedirectView("/lecture/zh/view/" + lectureId, true);
    }

    @RequestMapping(
            value = "/{lectureId}/zh/delete/{attachment:.+}",
            method = RequestMethod.GET
    )
    public String zh_deleteAttachment(@PathVariable("lectureId") long lectureId,
            @PathVariable("attachment") String name) throws AttachmentNotFound {
        lectureService.deleteAttachment(lectureId, name);
        return "redirect:/lecture/zh/edit/" + lectureId;
    }

    @RequestMapping(value = "zh/delete/{lectureId}", method = RequestMethod.GET)
    public String zh_deleteLecture(@PathVariable("lectureId") long lectureId)
            throws LectureNotFound, CommentNotFound {
        commentService.delAllComment(lectureId);
        lectureService.delete(lectureId);
        return "redirect:/lecture/zh/list";
    }

    @RequestMapping(value = "zh/create", method = RequestMethod.GET)
    public ModelAndView zh_create() {
        return new ModelAndView("zh_add", "lectureForm", new Form());
    }

    @RequestMapping(value = "zh/create", method = RequestMethod.POST)
    public String zh_create(Form form, Principal principal) throws IOException {
        long lectureId = lectureService.createLecture(principal.getName(),
                form.getSubject(), form.getBody(), form.getAttachments());
        return "redirect:/lecture/zh/view/" + lectureId;
    }
}
