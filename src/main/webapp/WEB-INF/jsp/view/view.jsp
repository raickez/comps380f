<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>Lecture</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Lecture ${lecture.id}: <c:out value="${lecture.subject}" /></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link text-success" href="<c:url value="/lecture/${lectureId}/comment"/>">Leave Comment</a>
                    </li>      
                    <security:authorize access="hasRole('ADMIN') or principal.username=='${lecture.customerName}'">  
                        <li class="nav-item">
                            <a class="nav-link text-warning" href="<c:url value="/lecture/edit/${lecture.id}" />">Edit</a>
                        </li>
                    </security:authorize>
                    <security:authorize access="hasRole('ADMIN')">    
                        <li class="nav-item">
                            <a class="nav-link text-danger" href="<c:url value="/lecture/delete/${lecture.id}" />">Delete</a>
                        </li>
                    </security:authorize>
                </ul>
                <span class="navbar-text">
                    <c:url var="logoutUrl" value="/logout"/>
                    <form action="${logoutUrl}" method="post">
                        <input type="submit" value="Log out" class="btn btn-primary"/>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </span>
            </div>
        </nav>

        <div class="container">
            <c:if test="${fn:length(lecture.attachments) > 0}">
                <br>
                Lecture Materials:
                <c:forEach items="${lecture.attachments}" var="attachment"
                           varStatus="status">
                    <c:if test="${!status.first}">, </c:if>
                    <a href="<c:url value="/lecture/${lecture.id}/attachment/${attachment.name}" />">
                        <c:out value="${attachment.name}" /></a>
                </c:forEach><br />
            </c:if>
                <br>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th scope="col">User</th>
                        <th scope="col">Comment</th>
                    </tr>
                </thead>

                <c:choose>
                    <c:when test="${fn:length(commentDatabase) == 0}">
                        <tbody>
                            <tr>
                                <td colspan="2"><i>There are no comments.</i></td>
                            </tr>
                        </tbody>
                    </c:when>
                    <c:otherwise>
                        <tbody>
                            <c:forEach items="${commentDatabase}" var="entry">
                                <tr>
                                    <td><c:out value="${entry.username}" /></td>
                                    <td><c:out value="${entry.comment}" />
                                        <security:authorize access="hasRole('ADMIN')">
                                            [<a href="<c:url value="deleteComment/${lectureId}/${entry.id}" />" class="text-danger">Delete</a>]
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
