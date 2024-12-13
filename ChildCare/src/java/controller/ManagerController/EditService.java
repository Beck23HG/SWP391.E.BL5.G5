/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ManagerController;

import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.stream.Collectors;
import model.Person;
import model.Service;

/**
 *
 * @author Admin
 */
public class EditService extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ServiceDAO sdao = new ServiceDAO();
        Service service = sdao.getServiceByID(id);
        request.setAttribute("service", service);
        List<Person> allStaffs = sdao.getAllStaffActive();
        request.setAttribute("allStaffs", allStaffs);
        List<Person> staffs = sdao.getStaffByServiceID(id);
        List<Integer> staffIds = staffs.stream()
                .map(Person::getPersonId)
                .collect(Collectors.toList());
        request.setAttribute("staffIds", staffIds);
        request.getRequestDispatcher("/Manager/Dashboard/EditService.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServiceDAO sdao = new ServiceDAO();
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("serviceName");
        float price = Float.parseFloat(request.getParameter("price"));
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String duration = request.getParameter("duration");
        String detail = request.getParameter("detail");
        String[] staffStrings = request.getParameterValues("staffs");
        int[] selectedStaffs = null;
        if (staffStrings != null) {
            selectedStaffs = new int[staffStrings.length];
            for (int i = 0; i < staffStrings.length; i++) {
                selectedStaffs[i] = Integer.parseInt(staffStrings[i]);
            }
        }
        sdao.updateService(name, price, description, status, duration, detail, id);
        sdao.removeAllStaffFromService(id);
        for (int i = 0; i < selectedStaffs.length; i++) {
            sdao.assignStaffForService(selectedStaffs[i], id);
        }
        request.setAttribute("ms", "Update service succesful!");
        request.getRequestDispatcher("/Manager/Dashboard/EditService.jsp").forward(request, response);
    }

}
