/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hungnp.controllers;

import hungnp.dao.QuizDAO;
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
@WebServlet(name = "UploadQuestionQuizServlet", urlPatterns = {"/UploadQuestionQuizServlet"})
public class UploadQuestionQuizServlet extends HttpServlet {

    private static final String QUIZ_PAGE = "/WEB-INF/view/quiz.jsp";
    private static final String FILE_NOT_FOUND = "/WEB-INF/view/fileNotFound.jsp";
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
        String url = FILE_NOT_FOUND;
        try {
            HttpSession session = request.getSession();
            String stringQuestionNum = request.getParameter("questionNum");
            //next-previous
            if (stringQuestionNum == null) {
//                System.out.println("next_pre");
                int numQues = (int) session.getAttribute("questionNum")+1;
                stringQuestionNum = String.valueOf(numQues);
            }
//            System.out.println("client_num:" + stringQuestionNum);
            if (stringQuestionNum != null) {
                QuizDAO quizDAO = new QuizDAO();
                String quizId = (String) session.getAttribute("quizId");
                Timestamp endTime = quizDAO.getEndTime(quizId);
                Date now = new Date();
                if (endTime.compareTo(now) > -1) {
                    if (stringQuestionNum.matches("^\\d+$")) {
                        int questionNum = Integer.parseInt(stringQuestionNum) - 1;
//                        System.out.println("numInList:"+questionNum);
                        //next - previous
                        String btnValue = request.getParameter("btnValue");
//                        System.out.println("b:"+btnValue);
                        if (btnValue != null) {
                            if (btnValue.equals("Previous")) {
                                if (questionNum == 0) {
                                    questionNum= (int) session.getAttribute("totalQuestion")-1;
                                }else{
                                    questionNum--;
                                }
//                                System.out.println("pre_question:"+questionNum);
                            } else if (btnValue.equals("Next")) {
                                if (questionNum == (int)session.getAttribute("totalQuestion")-1) {
                                    questionNum = 0;
                                } else {
                                    questionNum++;
                                }
//                                System.out.println("qN:"+questionNum);
                            }
                        }
                        //
//                        System.out.println("server:" + questionNum);
                        int totalQuestion = (int) session.getAttribute("totalQuestion");
                        if (questionNum >= 0 && questionNum < totalQuestion) {
                            List<QuestionDTO> listQuestion = (List<QuestionDTO>) session.getAttribute("listQuestion");
                            session.setAttribute("questionQuiz", listQuestion.get(questionNum));
                            //save follow list, not client
                            session.setAttribute("questionNum", questionNum);
                            // check timeout
                            Timestamp expectEndTime = (Timestamp) session.getAttribute("expectEndTime");
                            Timestamp currentTime = new Timestamp(now.getTime());
                            if (currentTime.compareTo(expectEndTime) >= 0) {
                                url = FINISH_QUIZ_CONTROLLER;
                            } else {
                                int totalTimeQuiz = (int) (expectEndTime.getTime() - currentTime.getTime()) / 1000;
                                session.setAttribute("totalTimeQuiz", totalTimeQuiz);
                                url = QUIZ_PAGE;
                            }
                        }
                    }
                } else {
                    session.setAttribute("timeout", endTime);
                    url = FINISH_QUIZ_CONTROLLER;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            log("UploadQuestionQuizServlet_processRequest:" + e.getMessage());
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
































