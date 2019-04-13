<!DOCTYPE html>
<html>
    <head>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <title>Login</title>
    </head>
    <body>
        <div class="container">
            <br><br>
            <h2>Login</h2>       
            <form action="login" method="POST">
                <div class="form-group">
                    <label for="username">Username:</label><br/>
                    <input type="text" id="username" name="username" class="form-control"/>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label><br/>
                    <input type="password" id="password" name="password" class="form-control"/>
                </div>
                <div class="form-group form-check">
                    <label class="form-check-label">
                        <input class="form-check-input" type="checkbox" id="remember-me" name="remember-me" />
                        <label for="remember-me">Remember me</label></label><br/><br/>
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="submit" value="Log In" class="btn btn-primary"/>
            </form>
            <br/>
            <form action="<c:url value="/register/create" />" method="GET">
                <input type="submit" value="Sign Up" class="btn btn-light"/>
            </form>
            <br>
            <c:if test="${param.error != null}">
                <p class="text-danger">Login failed.</p>
            </c:if>
            <c:if test="${param.logout != null}">
                <p class="text-info">You have logged out.</p>
            </c:if>
        </div>
    </body>
</html>