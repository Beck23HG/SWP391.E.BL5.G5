package controller.admin;

import EmailService.EmailUtil;
import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.security.SecureRandom;

/**
 *
 * @author fpt
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class AddUserServlet extends HttpServlet {
    
//    private static final String UPLOAD_DIRECTORY = "uploads";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddUserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddUserServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Admin/new-user.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Đường dẫn lưu file upload
//         + File.separator + UPLOAD_DIRECTORY
        String uploadPath = getServletContext().getRealPath("");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String role = request.getParameter("role");
            String status = request.getParameter("status");
            String address = request.getParameter("address");

            // Xử lý file upload
            String avatarPath = "";
            Part filePart = (Part) request.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//                UPLOAD_DIRECTORY + File.separator +
                avatarPath =  fileName; // Đường dẫn lưu file
//                uploadPath + File.separator + 
                filePart.write(fileName);   // Lưu file vào server
            }

            // Validate email
            AccountDAO accountDAO = new AccountDAO();
            if (accountDAO.checkExistedEmail(email)) {
                request.setAttribute("errorMessage", "Email already exists!");
                request.getRequestDispatcher("/Admin/new-user.jsp").forward(request, response);
                return;
            }

            String password = generateRandomPassword();

            int roleId = Integer.parseInt(role);
            int userStatus = Integer.parseInt(status);

            accountDAO.createAccountStaff(email, password, roleId, userStatus, fullName,
                    java.sql.Date.valueOf(dob), gender.equals("1"), mobile, address, avatarPath);

            EmailUtil.sendEmail(email, "Your New Account", "Hello " + fullName
                    + ",\n\nYour account has been successfully created.\nYour temporary password is: " + password);

            response.sendRedirect("userlist");

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + ex.getMessage());
            request.getRequestDispatcher("/Admin/new-user.jsp").forward(request, response);
        }
    }

    private String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            int index = random.nextInt(chars.length());
            password.append(chars.charAt(index));
        }
        return password.toString();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
