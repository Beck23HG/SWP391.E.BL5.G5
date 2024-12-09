/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Service {
    private int serviceId, status, staffId, managerId;
    private String serviceName, description, image;
    private float price;

    public Service() {
    }

    public Service(int serviceId, int status, int staffId, int managerId, String serviceName, String description, String image, float price) {
        this.serviceId = serviceId;
        this.status = status;
        this.staffId = staffId;
        this.managerId = managerId;
        this.serviceName = serviceName;
        this.description = description;
        this.image = image;
        this.price = price;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Service{" + "serviceId=" + serviceId + ", status=" + status + ", staffId=" + staffId + ", managerId=" + managerId + ", serviceName=" + serviceName + ", description=" + description + ", image=" + image + ", price=" + price + '}';
    }
    
    
    
}
