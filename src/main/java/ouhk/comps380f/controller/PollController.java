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
import ouhk.comps380f.model.Poll;
import ouhk.comps380f.service.PollService;
import ouhk.comps380f.exception.PollNotFound;

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
    
    public static class ansPollForm{
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
        return "redirect:/lecture/poll/list";
    }

    @RequestMapping(value = "/poll/{poll_id}", method = RequestMethod.GET)
    public ModelAndView createAnsForm(@PathVariable("poll_id") long poll_id,ModelMap model) {
        //model.addAttribute("pollDatabase", pollService.getPoll(poll_id));
        return new ModelAndView("viewPoll", "ansPollForm", new ansPollForm());
    }

}
