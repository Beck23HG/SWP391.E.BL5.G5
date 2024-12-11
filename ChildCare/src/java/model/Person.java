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
public class Person {
    private int personId, staffStatus;
    private String personName, phone, email, address, image;
    private Date dateOfBirth;
    private boolean gender;
    private Role role;
    private Account account;

    public Person() {
    }

    public Person(int personId, int staffStatus, String personName, String phone, String email, String address, String image, Date dateOfBirth, boolean gender) {
        this.personId = personId;
        this.staffStatus = staffStatus;
        this.personName = personName;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.image = image;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
    }

    public int getPersonId() {
        return personId;
    }

    public void setPersonId(int personId) {
        this.personId = personId;
    }

    public int getStaffStatus() {
        return staffStatus;
    }

    public void setStaffStatus(int staffStatus) {
        this.staffStatus = staffStatus;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }
    
    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    @Override
    public String toString() {
        return "Person{" + "personId=" + personId + ", staffStatus=" + staffStatus + ", personName=" + personName + ", phone=" + phone + ", email=" + email + ", address=" + address + ", image=" + image + ", dateOfBirth=" + dateOfBirth + ", gender=" + gender + ", role=" + role + ", account=" + account + '}';
    }
    
}
