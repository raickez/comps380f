<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>User List</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Users</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item"><a class="nav-link" href="<c:url value="/user/create" />">Create a User</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value="/lecture" />">Return to list lectures</a></li>
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
            <c:choose>
                <c:when test="${fn:length(lectureUsers) == 0}">
                    <i>There are no users in the system.</i>
                </c:when>
                <c:otherwise>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Username</th><th>Password</th><th>Roles</th><th>Action</th>
                            </tr>
                        </thead>
                        <c:forEach items="${lectureUsers}" var="user">
                            <tr>
                                <td>${user.username}</td><td>${user.password}</td>
                                <td>
                                    <c:forEach items="${user.roles}" var="role" varStatus="status">
                                        <c:if test="${!status.first}">, </c:if>
                                        ${role.role}
                                    </c:forEach>
                                </td>
                                <td>
                                    [<a class="text-danger" href="<c:url value="/user/delete/${user.username}" />">Delete</a>]
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
