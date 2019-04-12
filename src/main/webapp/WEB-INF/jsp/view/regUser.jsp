<!DOCTYPE html>
<html>
    <head>
        <title>Registration</title>
    </head>
    <body>
        <h2>Registration</h2>
        <form:form method="POST" enctype="multipart/form-data"
                   modelAttribute="lectureUser">
            <form:label path="username">Username</form:label><br/>
            <form:input type="text" path="username" /><br/><br/>
            <form:label path="password">Password</form:label><br/>
            <form:input type="text" path="password" /><br/><br/>
            <form:hidden path="roles" value="ROLE_USER" />
            <input type="submit" value="Register"/>
        </form:form>
            <br/>
        <form action="<c:url value="/login" />" method="get">
            <input type="submit" value="Login" />
        </form>
    </body>
</html>