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
        <title>Add Poll Page</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Create a Poll</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
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
            <form:form method="POST" modelAttribute="pollForm">
                <div class="form-group">
                    <form:label path="question">Question:</form:label><br>
                    <form:textarea path="question" rows="2" cols="50" class="form-control" required="required"/>
                </div>
                <div class="form-group">
                    <form:label path="response1">Answer1:</form:label><br>
                    <form:textarea path="response1" rows="2" cols="50" class="form-control" required="required"/>
                </div>
                <div class="form-group">
                    <form:label path="response2">Answer2:</form:label><br>
                    <form:textarea path="response2" rows="2" cols="50" class="form-control" required="required"/>
                </div>
                <div class="form-group">
                    <form:label path="response3">Answer3:</form:label><br>
                    <form:textarea path="response3" rows="2" cols="50" class="form-control" required="required"/>
                </div>
                <div class="form-group">
                    <form:label path="response4">Answer4:</form:label><br>
                    <form:textarea path="response4" rows="2" cols="50" class="form-control" required="required"/>
                </div>
                <input type="submit" value="Submit" class="btn btn-success"/>
            </form:form>
            <br>
            <form action="<c:url value="/lecture/list" />" method="GET">
                <input type="submit" value="Cancel" class="btn btn-secondary"/>
            </form>
        </div>
    </body>
</html>
