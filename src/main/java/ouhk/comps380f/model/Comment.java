package ouhk.comps380f.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "comment")
public class Comment implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "commentid")
    private long id;
    
    private String username;

    private String comment;

    @ManyToOne
    @JoinColumn(name = "lecture_id")
    private Lecture lecture;
    
    @Column(name = "lecture_id", insertable=false, updatable=false)
    private long lecture_id;

    /*public Comment() {
    }

    public Comment(String username, String comment, int lecture_id) {
        this.username = username;
        this.comment = comment;
        this.lecture_id = lecture_id;
    }*/

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

    public Lecture getLecture() {
        return lecture;
    }

    public void setLecture(Lecture lecture) {
        this.lecture = lecture;
    }

    public long getLecture_id() {
        return lecture_id;
    }

    public void setLecture_id(long lecture_id) {
        this.lecture_id = lecture_id;
    }

}
