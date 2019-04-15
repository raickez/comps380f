package ouhk.comps380f.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import ouhk.comps380f.exception.PollCommentNotFound;
import ouhk.comps380f.exception.PollNotFound;
import ouhk.comps380f.service.PollService;

@Controller
@RequestMapping("lecture")
public class PollController {

    @Autowired
    private PollService pollService;

    public static class addPollForm {

        private long poll_id;
        private String question;
        private String response1, response2, response3, response4;

        public long getPoll_id() {
            return poll_id;
        }

        public void setPoll_id(long poll_id) {
            this.poll_id = poll_id;
        }

        public String getQuestion() {
            return question;
        }

        public void setQuestion(String question) {
            this.question = question;
        }

        public String getResponse1() {
            return response1;
        }

        public void setResponse1(String response1) {
            this.response1 = response1;
        }

        public String getResponse2() {
            return response2;
        }

        public void setResponse2(String response2) {
            this.response2 = response2;
        }

        public String getResponse3() {
            return response3;
        }

        public void setResponse3(String response3) {
            this.response3 = response3;
        }

        public String getResponse4() {
            return response4;
        }

        public void setResponse4(String response4) {
            this.response4 = response4;
        }

    }

    public static class ansPollForm {

        private long poll_id;
        private String username;
        private String response;

        public long getPoll_id() {
            return poll_id;
        }

        public void setPoll_id(long poll_id) {
            this.poll_id = poll_id;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getResponse() {
            return response;
        }

        public void setResponse(String response) {
            this.response = response;
        }

    }

    public static class cmForm {

        private long id;
        private String username;
        private String comment;
        private long poll_id;

        public long getId() {
            return id;
        }

        public void setId(long id) {
            this.id = id;
        }

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

        public long getPoll_id() {
            return poll_id;
        }

        public void setPoll_id(long poll_id) {
            this.poll_id = poll_id;
        }

    }

    @RequestMapping(value = "poll/list", method = RequestMethod.GET)
    public String listPoll(ModelMap model) {
        model.addAttribute("pollDatabase", pollService.getPolls());
        return "poll";
    }

    @RequestMapping(value = "poll/list/addPoll", method = RequestMethod.GET)
    public ModelAndView createForm() {
        return new ModelAndView("addPoll", "pollForm", new addPollForm());
    }

    @RequestMapping(value = "poll/list/addPoll", method = RequestMethod.POST)
    public String addPollFrom(addPollForm form,
            ModelMap model, HttpServletRequest request) throws Exception {
        pollService.createPoll(form.getQuestion(), form.getResponse1(), form.getResponse2(), form.getResponse3(), form.getResponse4());
        return "redirect:/lecture";
    }

    @RequestMapping(value = {"poll/{poll_id}", "lecture/poll/{poll_id}"}, method = RequestMethod.GET)
    public ModelAndView createAnsForm(@PathVariable("poll_id") long poll_id, ModelMap model, HttpServletRequest request) {
        model.addAttribute("pollDatabase", pollService.getPoll(poll_id));
        model.addAttribute("pollAllCount", pollService.countAllByPollId(poll_id));
        model.addAttribute("pollCount1", pollService.countAllByPollIdAndResponse(poll_id, pollService.getPoll(poll_id).getResponse1()));
        model.addAttribute("pollCount2", pollService.countAllByPollIdAndResponse(poll_id, pollService.getPoll(poll_id).getResponse2()));
        model.addAttribute("pollCount3", pollService.countAllByPollIdAndResponse(poll_id, pollService.getPoll(poll_id).getResponse3()));
        model.addAttribute("pollCount4", pollService.countAllByPollIdAndResponse(poll_id, pollService.getPoll(poll_id).getResponse4()));
        model.addAttribute("Ivote", pollService.findResponseByPollIdAndUsername(poll_id, request.getUserPrincipal().getName()));
        model.addAttribute("poll_id", poll_id);
        model.addAttribute("pollCommentDatabase", pollService.getComment(poll_id));
        return new ModelAndView("viewPoll", "ansPollForm", new ansPollForm());
    }

    @RequestMapping(value = {"poll/{poll_id}", "lecture/poll/{poll_id}"}, method = RequestMethod.POST)
    public String ansPoll(@PathVariable("poll_id") long poll_id, ansPollForm form,
            ModelMap model, HttpServletRequest request) throws Exception {
        pollService.ansPoll(poll_id, request.getUserPrincipal().getName(), form.getResponse());
        return "redirect:/lecture/poll/{poll_id}";
    }

    @RequestMapping(value = "/poll/delete/{poll_id}", method = RequestMethod.GET)
    public String delPoll(@PathVariable("poll_id") long poll_id) throws Exception, PollCommentNotFound, PollNotFound {
        pollService.delAllComment(poll_id);
        pollService.delPoll(poll_id);
        return "redirect:/lecture/list";
    }

    @RequestMapping(value = "{pollId}/pollcomment", method = RequestMethod.GET)
    public ModelAndView createForm(@PathVariable("pollId") long pollId, ModelMap model) {
        return new ModelAndView("pollcomment", "pollCommentForm", new cmForm());
    }

    @RequestMapping(value = "{pollId}/pollcomment", method = RequestMethod.POST)
    public String addComment(@PathVariable("pollId") long pollId, cmForm form,
            ModelMap model, HttpServletRequest request) throws Exception {
        pollService.createComment(request.getUserPrincipal().getName(), form.getComment(), pollId);
        return "redirect:/lecture/lecture/poll/" + pollId;
    }

    @RequestMapping(value = {"/lecture/poll/deleteComment/{pollId}/{Id}", "poll/deleteComment/{pollId}/{Id}"}, method = RequestMethod.GET)
    public View delComment(@PathVariable("Id") long Id, @PathVariable("pollId") long poll_id)
            throws PollCommentNotFound {
        pollService.delComment(Id);
        return new RedirectView("/lecture/poll/" + poll_id, true);
    }

    //中文
    @RequestMapping(value = "poll/zh/list", method = RequestMethod.GET)
    public String zh_listPoll(ModelMap model) {
        model.addAttribute("pollDatabase", pollService.getPolls());
        return "zh_poll";
    }

    @RequestMapping(value = {"zh/poll/{poll_id}", "lecture/zh/poll/{poll_id}"}, method = RequestMethod.GET)
    public ModelAndView zh_createAnsForm(@PathVariable("poll_id") long poll_id, ModelMap model, HttpServletRequest request) {
        model.addAttribute("pollDatabase", pollService.getPoll(poll_id));
        model.addAttribute("pollAllCount", pollService.countAllByPollId(poll_id));
        model.addAttribute("pollCount1", pollService.countAllByPollIdAndResponse(poll_id, pollService.getPoll(poll_id).getResponse1()));
        model.addAttribute("pollCount2", pollService.countAllByPollIdAndResponse(poll_id, pollService.getPoll(poll_id).getResponse2()));
        model.addAttribute("pollCount3", pollService.countAllByPollIdAndResponse(poll_id, pollService.getPoll(poll_id).getResponse3()));
        model.addAttribute("pollCount4", pollService.countAllByPollIdAndResponse(poll_id, pollService.getPoll(poll_id).getResponse4()));
        model.addAttribute("Ivote", pollService.findResponseByPollIdAndUsername(poll_id, request.getUserPrincipal().getName()));
        model.addAttribute("pollCommentDatabase", pollService.getComment(poll_id));
        return new ModelAndView("zh_viewPoll", "ansPollForm", new ansPollForm());
    }

    @RequestMapping(value = {"zh/poll/{poll_id}", "lecture/zh/poll/{poll_id}"}, method = RequestMethod.POST)
    public String zh_ansPoll(@PathVariable("poll_id") long poll_id, ansPollForm form,
            ModelMap model, HttpServletRequest request) throws Exception {
        pollService.ansPoll(poll_id, request.getUserPrincipal().getName(), form.getResponse());
        return "redirect:/lecture/zh/poll/" + poll_id;
    }

    @RequestMapping(value = "poll/zh/list/addPoll", method = RequestMethod.GET)
    public ModelAndView zh_createForm() {
        return new ModelAndView("zh_addPoll", "pollForm", new addPollForm());
    }

    @RequestMapping(value = "poll/zh/list/addPoll", method = RequestMethod.POST)
    public String zh_addPollFrom(addPollForm form,
            ModelMap model, HttpServletRequest request) throws Exception {
        pollService.createPoll(form.getQuestion(), form.getResponse1(), form.getResponse2(), form.getResponse3(), form.getResponse4());
        return "redirect:/lecture/zh/list";
    }

    @RequestMapping(value = "zh/poll/delete/{poll_id}", method = RequestMethod.GET)
    public String zh_delPoll(@PathVariable("poll_id") long poll_id) throws Exception, PollCommentNotFound, PollNotFound {
        pollService.delAllComment(poll_id);
        pollService.delPoll(poll_id);
        return "redirect:/lecture/zh/list";
    }
    
    @RequestMapping(value = "zh/{pollId}/pollcomment", method = RequestMethod.GET)
    public ModelAndView zh_createForm(@PathVariable("pollId") long pollId, ModelMap model) {
        return new ModelAndView("zh_pollcomment", "pollCommentForm", new cmForm());
    }

    @RequestMapping(value = "zh/{pollId}/pollcomment", method = RequestMethod.POST)
    public String zh_addComment(@PathVariable("pollId") long pollId, cmForm form,
            ModelMap model, HttpServletRequest request) throws Exception {
        pollService.createComment(request.getUserPrincipal().getName(), form.getComment(), pollId);
        return "redirect:/lecture/lecture/zh/poll/" + pollId;
    }

    @RequestMapping(value = {"/lecture/zh/poll/deleteComment/{pollId}/{Id}", "zh/poll/deleteComment/{pollId}/{Id}"}, method = RequestMethod.GET)
    public View zh_delComment(@PathVariable("Id") long Id, @PathVariable("pollId") long poll_id)
            throws PollCommentNotFound {
        pollService.delComment(Id);
        return new RedirectView("/lecture/zh/poll/" + poll_id, true);
    }
}
