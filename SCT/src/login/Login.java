package login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import relazioni.*;


public class Login extends HttpServlet {

	private static String RESPAUTO = "Responsabile Auto";

	//Risponde alla richiesta http
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {

		try {
			Dipendente dip = Dipendente.getDipendente(request.getParameter("matricola"));

			if (dip != null && dip.getPassword().equals(request.getParameter("password"))) {
				HttpSession session = request.getSession(true);
				session.setAttribute("utenteAttivo", dip.getMatricola());
				//session.setAttribute("ruoloUtenteAttivo", dip.getRuolo());

				if (dip.getRuolo().equals(RESPAUTO))
					response.sendRedirect("respAutoHome.jsp");
				else
					response.sendRedirect("adminHome.jsp");

			} else
				response.sendRedirect("loginError.jsp");
		}
		catch (Throwable theException) {
			System.out.println(theException);
		}
	}
}
