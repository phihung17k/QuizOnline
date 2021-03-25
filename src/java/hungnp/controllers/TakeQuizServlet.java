/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.a
 */
package hungnp.controllers;

import hungnp.dao.QuestionDAO;
import hungnp.dao.QuizDAO;
import hungnp.dao.QuizDetailDAO;
import hungnp.dao.SubjectDAO;
import hungnp.dto.QuestionDTO;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
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
@WebServlet(name = "TakeQuizServlet", urlPatterns = {"/TakeQuizServlet"})
public class TakeQuizServlet extends HttpServlet {

    private static final String QUIZ_PAGE = "/WEB-INF/view/quiz.jsp";
    private static final String SUBJECT_PAGE_CONTROLLER = "/SubjectPageServlet";
    private static final String OPENED_EXAM_PAGE = "/WEB-INF/view/openedExam.jsp";
    private static final String FINISH_EXAM_CONTROLLER="/FinishQuizServlet";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private String getQuizIdFromAmount(int amountQuiz) {
        if (amountQuiz >= 0 && amountQuiz <= 9) {
            return "QZ00000" + amountQuiz;
        } else if (amountQuiz >= 10 && amountQuiz <= 99) {
            return "QZ0000" + amountQuiz;
        } else if (amountQuiz >= 100 && amountQuiz <= 999) {
            return "QZ000" + amountQuiz;
        } else if (amountQuiz >= 1000 && amountQuiz <= 9999) {
            return "QZ00" + amountQuiz;
        } else if (amountQuiz >= 10000 && amountQuiz <= 99999) {
            return "QZ0" + amountQuiz;
        }
        return "QZ" + amountQuiz;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = QUIZ_PAGE;
        try {
            HttpSession session = request.getSession();
            session.removeAttribute("notEnough");
            session.removeAttribute("notFoundQuestion");

            String subjectId = request.getParameter("subjectId");
            String subjectName = request.getParameter("subjectName");

            if (session.getAttribute("openedExam") != null) {
                if(!subjectName.equals(session.getAttribute("subjectName"))){
                    url = OPENED_EXAM_PAGE;
                }else{
                    Timestamp expectEndTime = (Timestamp) session.getAttribute("expectEndTime");
                    Date now = new Date();
                    Timestamp currentTime = new Timestamp(now.getTime());
                    
                    if(currentTime.compareTo(expectEndTime)>=0){
                        url = FINISH_EXAM_CONTROLLER;
                    }else{
//                        System.out.println("e:"+expectEndTime+"; "+currentTime);
                        int totalTimeQuiz = (int) (expectEndTime.getTime() - currentTime.getTime())/1000;
//                        System.out.println("timeout:"+totalTimeQuiz);
                        session.setAttribute("totalTimeQuiz", totalTimeQuiz);
                        url = QUIZ_PAGE;
                    }
                }
            } else {
                SubjectDAO subjectDAO = new SubjectDAO();
                int totalQuestion = subjectDAO.getTotalQuestionByID(subjectId);
                QuestionDAO questionDAO = new QuestionDAO();
                List<String> listRandomQuestionId = questionDAO.getRandomQuestionIdForQuiz(subjectId, totalQuestion);
                if (listRandomQuestionId != null && totalQuestion > -1) {
                    if (listRandomQuestionId.size() < totalQuestion) {
                        session.setAttribute("notEnough", subjectName + " is not enough question to take quiz");
                        url = SUBJECT_PAGE_CONTROLLER;
                    } else {
                        List<QuestionDTO> listQuestion = new ArrayList<>();
                        for (String questionId : listRandomQuestionId) {
                            QuestionDTO question = questionDAO.getFullQuestionFromID(questionId);
                            listQuestion.add(question);
                        }

                        String accountId = (String) session.getAttribute("accountEmail");
                        QuizDAO quizDAO = new QuizDAO();
                        int amountQuiz = quizDAO.countQuiz();
                        if (amountQuiz > -1) {
                            String quizId = getQuizIdFromAmount(amountQuiz);
                            Date timeToStart = new Date();
                            Timestamp startTime = new Timestamp(timeToStart.getTime());
                            int totalTimeQuiz= subjectDAO.getTotalTimeQuizByID(subjectId);//minutes
                            //create quiz
                            quizDAO.createQuiz(quizId, accountId, subjectId, startTime, totalTimeQuiz);
                            Timestamp expectEndTime = quizDAO.getEndTime(quizId);
                            session.setAttribute("startTime", startTime);
                            session.setAttribute("expectEndTime", expectEndTime);
                            
                            QuizDetailDAO quizDetailDAO = new QuizDetailDAO();
                            for (String questionId : listRandomQuestionId) {
                                quizDetailDAO.createQuizDetail(quizId, questionId);
                            }

                            session.setAttribute("totalTimeQuiz", totalTimeQuiz*60);
                            session.setAttribute("totalQuestion", totalQuestion);
                            session.setAttribute("quizId", quizId);
                        }

                        session.setAttribute("listQuestion", listQuestion);
                        session.setAttribute("subjectName", subjectName);
                        session.setAttribute("questionQuiz", listQuestion.get(0));
                        session.setAttribute("questionNum", 0);
                        session.setAttribute("openedExam", "You are taking the exam "+subjectName+". Do you want to exit the quiz?");
                    }
                } else {
                    session.setAttribute("notFoundQuestion", subjectName + " doesn't have any question");
                    url = SUBJECT_PAGE_CONTROLLER;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            log("TakeQuizServlet_processRequest:" + e.getMessage());
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


















































































