/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.controllers;

import hungnp.dao.QuizDAO;
import hungnp.dao.QuizDetailDAO;
import hungnp.dto.QuestionDTO;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Win 10
 */
@WebServlet(name = "SaveAnswerServlet", urlPatterns = {"/SaveAnswerServlet"})
public class SaveAnswerServlet extends HttpServlet {

    private static final String FILE_NOT_FOUND_PAGE = "/WEB-INF/view/fileNotFound.jsp";
    private static final String QUIZ_PAGE = "/WEB-INF/view/quiz.jsp";
    private static final String FINISH_QUIZ_CONTROLLER = "/FinishQuizServlet";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FILE_NOT_FOUND_PAGE;
        try {
            HttpSession session = request.getSession();

            if (session.getAttribute("questionNum") != null) {
                QuizDAO quizDAO = new QuizDAO();
                String quizId = (String) session.getAttribute("quizId");
                List<QuestionDTO> listQuestion = (List<QuestionDTO>) session.getAttribute("listQuestion");
                int questionNum = (int) session.getAttribute("questionNum");
                String questionId = request.getParameter("questionId");
                String selectedAnswerId = request.getParameter("answerId");
                if (selectedAnswerId != null) {
                    QuizDetailDAO quizDetailDAO = new QuizDetailDAO();
                    quizDetailDAO.updateSelectedAnswer(questionId, selectedAnswerId);
                    QuestionDTO selectedQuestion = listQuestion.get(questionNum);
//                    System.out.println("se:"+questionNum);
                    selectedQuestion.setSelectedAnswerId(selectedAnswerId);
                    listQuestion.set(questionNum, selectedQuestion);
                    session.setAttribute("listQuestion", listQuestion);

                }
                if (questionNum == (int) session.getAttribute("totalQuestion")-1) {
                    session.setAttribute("questionNum", 0);
                    session.setAttribute("questionQuiz", listQuestion.get(0));
                } else {
                    session.setAttribute("questionNum", questionNum + 1);
                    session.setAttribute("questionQuiz", listQuestion.get(questionNum + 1));
                }
                Timestamp expectEndTime = (Timestamp) session.getAttribute("expectEndTime");
                Date now = new Date();
                Timestamp currentTime = new Timestamp(now.getTime());

                if (currentTime.compareTo(expectEndTime) >= 0) {
                    url = FINISH_QUIZ_CONTROLLER;
                } else {
//                    System.out.println("e:" + expectEndTime + "; " + currentTime);
                    int totalTimeQuiz = (int) (expectEndTime.getTime() - currentTime.getTime()) / 1000;
//                    System.out.println("timeout:" + totalTimeQuiz);
                    session.setAttribute("totalTimeQuiz", totalTimeQuiz);
                    url = QUIZ_PAGE;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            log("SaveAnswerServlet_processRequest:" + e.getMessage());
        } finally {
            this.getServletContext().getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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








