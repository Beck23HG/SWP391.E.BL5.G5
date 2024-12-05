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
public class Reservation {

    private int reservationId, customerId, staffId, status;
    private String note;
    private Date created_Date, reservationDate;
    private Person customer; // Thêm đối tượng Person
    private Service service; // Thêm đối tượng Service

    public Reservation() {
    }

    public Reservation(int reservationId, int customerId, int staffId, int status, String note, Date created_Date, Date reservationDate, Person customer, Service servic) {
        this.reservationId = reservationId;
        this.customerId = customerId;
        this.staffId = staffId;
        this.status = status;
        this.note = note;
        this.created_Date = created_Date;
        this.reservationDate = reservationDate;
        this.customer = customer; // Gán đối tượng Person
        this.service = service;   // Gán đối tượng Service
    }

    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getCreated_Date() {
        return created_Date;
    }

    public void setCreated_Date(Date created_Date) {
        this.created_Date = created_Date;
    }

    public Date getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(Date reservationDate) {
        this.reservationDate = reservationDate;
    }

    public Person getCustomer() {
        return customer;
    }

    public void setCustomer(Person customer) {
        this.customer = customer;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

}
