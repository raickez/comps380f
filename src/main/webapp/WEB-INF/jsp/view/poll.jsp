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
            <a class="navbar-brand" href="#">Poll Page</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <security:authorize access="hasRole('ADMIN')">
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value="/lecture/poll/list/addPoll" />">Add Poll</a>
                        </li>
                    </security:authorize>
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

        <div class="container-fluid">
            <c:choose>
                <c:when test="${fn:length(pollDatabase) == 0}">
                    <i>There are no poll in the system.</i>
                </c:when>
                <c:otherwise>
                    <ul class="list-group list-group-flush">
                        <c:forEach items="${pollDatabase}" var="poll">
                            <li class="list-group-item">
                                Question #${poll.poll_id}:
                                <a href="<c:url value="${poll.poll_id}" />">
                                    <c:out value="${poll.question}" /></a>
                                    <security:authorize access="hasRole('ADMIN')">            
                                    [<a class="text-danger" href="<c:url value="/lecture/poll/delete/${poll.poll_id}" />">Delete</a>]
                                </security:authorize>
                            </li>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>
            <br>
            <a href="<c:url value="/lecture" />">Return to list lectures</a>
        </div>
    </body>
</html>
