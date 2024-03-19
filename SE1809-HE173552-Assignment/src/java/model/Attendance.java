/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class Attendance {
    private int atid;
    private Session session;
    private Student student;
    private Date dateTime;
    private String status, description;
    private int numOfAbsent, totalSession;

    public Session getSession() {
        return session;
    }

    public void setSession(Session session) {
        this.session = session;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Date getDateTime() {
        return dateTime;
    }

    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getAtid() {
        return atid;
    }

    public void setAtid(int atid) {
        this.atid = atid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Attendance{" + "atid=" + atid + ", session=" + session + ", student=" + student + ", dateTime=" + dateTime + ", status=" + status + ", description=" + description + '}';
    }

    public int getNumOfAbsent() {
        return numOfAbsent;
    }

    public void setNumOfAbsent(int numOfAbsent) {
        this.numOfAbsent = numOfAbsent;
    }

    public int getTotalSession() {
        return totalSession;
    }

    public void setTotalSession(int totalSession) {
        this.totalSession = totalSession;
    }
    
    
    
    
}
