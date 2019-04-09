package ouhk.comps380f.model;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.Table;


@Table(name = "comment")
public class Comment{
    
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
