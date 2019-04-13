<!DOCTYPE html>
<html>
    <head>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <title>Registration</title>
    </head>
    <body>
        <div class="container">
            <br><br>
            <h2>Registration</h2>
            <form:form method="POST" enctype="multipart/form-data"
                       modelAttribute="lectureUser">
                <div class="form-group">
                    <form:label path="username">Username</form:label><br/>
                    <form:input type="text" path="username" class="form-control" required="required"/>
                </div>
                <div class="form-group">
                    <form:label path="password">Password</form:label><br/>
                    <form:input type="text" path="password" class="form-control" required="required"/>
                </div>
                <form:hidden path="roles" value="ROLE_USER" />
                <input type="submit" value="Register" class="btn btn-primary"/>
            </form:form>
            <br/>
            <form action="<c:url value="/login" />" method="get">
                <input type="submit" value="Login" class="btn btn-success"/>
            </form>
                <br>
            <c:if test="${param.error != null}">
                <p class="text-danger">Registration failed! Username already used by another user.</p>
            </c:if>
        </div>
    </body>
</html>