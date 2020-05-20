package mypkg;
 
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
 
public class HelloServlet extends HttpServlet {
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
               throws IOException, ServletException {
      
      // Set the response message's MIME type

      response.setContentType("text/html;charset=UTF-8");

      // Allocate a output writer to write the response message into the network socket

      PrintWriter out = response.getWriter();
      
      // Write the response message, in an HTML page

      try {
        String envar_val = System.getenv("ENVAR");
        String configmap_val = System.getenv("CONFIGMAPVAR");
        String secret_val = System.getenv("SECRETVAR");

        out.println("<!DOCTYPE html>");
        out.println("<html><head>");
        out.println("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
        out.println("<title>Hello, World!</title></head>");
        out.println("<body>");
        out.println("<h1>Hello from OpenShift!</h1>");  // says Hello
        // Echo client's request information
        out.println("<p>Request URI: " + request.getRequestURI() + "</p>");
        out.println("<p>Protocol: " + request.getProtocol() + "</p>");
        out.println("<p>PathInfo: " + request.getPathInfo() + "</p>");
        out.println("<p>Remote Address: " + request.getRemoteAddr() + "</p>");
        // Generate a random number upon each request
        out.println("<p>A Random Number: <strong>" + Math.random() + "</strong></p>");

        // Check for environment variables and display if set

        if (envar_val != null && !envar_val.isEmpty()) {
          out.println("<p>Environment variable: " + envar_val + "</p>");
        }

        if (configmap_val != null && !configmap_val.isEmpty()) {
          out.println("<p>Config Map Environment variable: " + configmap_val + "</p>");
        }

        if (secret_val != null && !secret_val.isEmpty()) {
          out.println("<p>Secret Environment variable: " + secret_val + "</p>");
        }

        out.println("</body>");
        out.println("</html>");
      } finally {
        out.close();  // Always close the output writer
      }
   }
}
