/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Feedback {
    private int feedbackId, customerId, serviceId, starRating;
    private String content, responseFeedback;

    public Feedback() {
    }

    public Feedback(int feedbackId, int customerId, int serviceId, int starRating, String content, String responseFeedback) {
        this.feedbackId = feedbackId;
        this.customerId = customerId;
        this.serviceId = serviceId;
        this.starRating = starRating;
        this.content = content;
        this.responseFeedback = responseFeedback;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public int getStarRating() {
        return starRating;
    }

    public void setStarRating(int starRating) {
        this.starRating = starRating;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getResponseFeedback() {
        return responseFeedback;
    }

    public void setResponseFeedback(String responseFeedback) {
        this.responseFeedback = responseFeedback;
    }
    
}
