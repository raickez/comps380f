<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>Poll Page</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Question #${pollDatabase.poll_id}:${pollDatabase.question}</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link text-success" href="<c:url value="/lecture/${poll_id}/pollcomment"/>">Leave a Comment</a>
                    </li>
                </ul>
                <span class="navbar-text">
                    <security:authorize access="!isAuthenticated()">
                        <a href="<c:url value="/login"/>">Login</a>
                    </security:authorize>
                    <security:authorize access="isAuthenticated()">
                        <c:url var="logoutUrl" value="/logout"/>
                        <form action="${logoutUrl}" method="post">
                            <input type="submit" value="Log out" class="btn btn-primary"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                    </security:authorize>
                </span>
            </div>
        </nav>

        <div class="container">
            <br>
            <p class="text-monospace">There are ${pollAllCount} votes.</p>

            <c:set var = "Ivoted" value = "${Ivote}"/>
            <c:choose>
                <c:when test="${Ivoted==null}"><p class="text-monospace">You haven't vote.</p></c:when>
                <c:otherwise> <p class="text-monospace">You voted to ${Ivote}.</p></c:otherwise>
            </c:choose>

            <form:form method="POST" modelAttribute="ansPollForm">
                <div class="form-check">
                    <form:radiobutton class="form-check-input" path="response" value="${pollDatabase.response1}" required="required"/>${pollDatabase.response1}
                    <div class="progress">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${pollCount1/pollAllCount*100}%" aria-valuenow="${pollCount1}" aria-valuemin="0" aria-valuemax="100">${pollCount1} vote</div>
                    </div><br>
                </div>
                <div class="form-check">
                    <form:radiobutton class="form-check-input" path="response" value="${pollDatabase.response2}"/>${pollDatabase.response2}
                    <div class="progress">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${pollCount2/pollAllCount*100}%" aria-valuenow="${pollCount2}" aria-valuemin="0" aria-valuemax="100">${pollCount2} vote</div>
                    </div><br>
                </div>
                <div class="form-check">
                    <form:radiobutton class="form-check-input" path="response" value="${pollDatabase.response3}"/>${pollDatabase.response3}
                    <div class="progress">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${pollCount3/pollAllCount*100}%" aria-valuenow="${pollCount3}" aria-valuemin="0" aria-valuemax="100">${pollCount3} vote</div>
                    </div><br>
                </div>
                <div class="form-check">
                    <form:radiobutton class="form-check-input" path="response" value="${pollDatabase.response4}"/>${pollDatabase.response4}
                    <div class="progress">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${pollCount4/pollAllCount*100}%" aria-valuenow="${pollCount4}" aria-valuemin="0" aria-valuemax="100">${pollCount4} vote</div>
                    </div><br><br>
                </div>
                <form:hidden path="username" value="${principal.username}"/>
                <input type="submit" value="Submit" class="btn btn-success"/>
            </form:form>
                
                <br><br>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th scope="col">User</th>
                        <th scope="col">Comment</th>
                    </tr>
                </thead>

                <c:choose>
                    <c:when test="${fn:length(pollCommentDatabase) == 0}">
                        <tbody>
                            <tr>
                                <td colspan="2"><i>There are no comments.</i></td>
                            </tr>
                        </tbody>
                    </c:when>
                    <c:otherwise>
                        <tbody>
                            <c:forEach items="${pollCommentDatabase}" var="entry">
                                <tr>
                                    <td><c:out value="${entry.username}" /></td>
                                    <td><c:out value="${entry.comment}" />
                                        <security:authorize access="hasRole('ADMIN')">
                                            [<a href="<c:url value="deleteComment/${poll_id}/${entry.id}" />" class="text-danger">Delete</a>]
                                        </security:authorize></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </c:otherwise>
                </c:choose>

            </table><br>
            <a href="<c:url value="/lecture" />">Return to list lectures</a>
        </div>
    </body>
</html>
