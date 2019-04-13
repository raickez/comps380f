<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>COMPS380F Web Applications: Design and Development</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">COMPS380F Web Applications: Design and Development</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="/lecture/poll/list" />">Poll Page</a>
                    </li>
                    <security:authorize access="hasRole('ADMIN')"> 
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value="/user" />">Manage User Accounts</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value="/lecture/create" />">Add a Lecture</a>
                        </li>
                    </security:authorize>
                </ul>
                <span class="navbar-text">
                    <security:authorize access="!isAuthenticated()">
                        <form action="<c:url value="/login"/>" method="GET">
                            <input type="submit" value="Login" class="btn btn-primary"/>
                        </form>
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
                <c:when test="${fn:length(lectureDatabase) == 0}">
                    <i>There are no lectures in the system.</i>
                </c:when>
                <c:otherwise>
                    <ul class="list-group list-group-flush">
                        <c:forEach items="${lectureDatabase}" var="lecture">
                            <li class="list-group-item">Lecture ${lecture.id}:
                                <a href="<c:url value="/lecture/view/${lecture.id}" />">
                                    <c:out value="${lecture.subject}" /></a>
                                    <security:authorize access="isAuthenticated() and (hasRole('ADMIN') or
                                                        principal.username=='${lecture.customerName}')">
                                    [<a href="<c:url value="/lecture/edit/${lecture.id}" />" class="text-warning">Edit</a>]
                                </security:authorize>
                                <security:authorize access="isAuthenticated() and (hasRole('ADMIN'))">            
                                    [<a href="<c:url value="/lecture/delete/${lecture.id}" />" class="text-danger">Delete</a>]
                                </security:authorize>
                            </li>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>