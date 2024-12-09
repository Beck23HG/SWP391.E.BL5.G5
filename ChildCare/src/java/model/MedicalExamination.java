/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author admin
 */
public class MedicalExamination {

    private int meId, reservationId, staffId, customerId;
    private String symptoms, diagnosis, notes;
    private Date examinationDate;
    private float examinationFee;
    private Person customer;
    private Service service; // Dịch vụ được sử dụng
    private Medicine medicine; 

    public Medicine getMedicine() {
        return medicine;
    }

    public void setMedicine(Medicine medicine) {
        this.medicine = medicine;
    }

    // Getter và Setter cho service
    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public Person getCustomer() {
        return customer;
    }

    public void setCustomer(Person customer) {
        this.customer = customer;
    }

    public MedicalExamination() {
    }

    public MedicalExamination(int meId, int reservationId, int staffId, int customerId, String symptoms, String diagnosis, String notes, Date examinationDate, float examinationFee) {
        this.meId = meId;
        this.reservationId = reservationId;
        this.staffId = staffId;
        this.customerId = customerId;
        this.symptoms = symptoms;
        this.diagnosis = diagnosis;
        this.notes = notes;
        this.examinationDate = examinationDate;
        this.examinationFee = examinationFee;
    }

    public int getMeId() {
        return meId;
    }

    public void setMeId(int meId) {
        this.meId = meId;
    }

    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Date getExaminationDate() {
        return examinationDate;
    }

    public void setExaminationDate(Date examinationDate) {
        this.examinationDate = examinationDate;
    }

    public float getExaminationFee() {
        return examinationFee;
    }

    public void setExaminationFee(float examinationFee) {
        this.examinationFee = examinationFee;
    }

}
