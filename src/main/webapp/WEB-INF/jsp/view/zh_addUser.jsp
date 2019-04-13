<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>新增用戶</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">新增用戶</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                </ul>
                <span class="navbar-text">
                    <c:url var="logoutUrl" value="/logout"/>
                    <form action="${logoutUrl}" method="post">
                        <input type="submit" value="登出" class="btn btn-primary"/>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </span>
            </div>
        </nav>

        <div class="container">
            <br>
            <form:form method="POST" enctype="multipart/form-data" modelAttribute="lectureUser">
                <div class="form-group">
                    <form:label path="username">用戶</form:label><br/>
                    <form:input type="text" path="username" class="form-control" required="required"/>
                </div>
                <div class="form-group">
                    <form:label path="password">密碼</form:label><br/>
                    <form:input type="text" path="password" class="form-control" required="required"/>
                </div>
                <form:label path="roles" class="form-check-label">組別</form:label>
                    <div class="form-group form-check">
                    <form:checkbox path="roles" value="ROLE_USER" />ROLE_USER
                    <form:checkbox path="roles" value="ROLE_ADMIN" />ROLE_ADMIN
                </div>
                <input type="submit" value="新增" class="btn btn-success"/>
            </form:form>
            <br>
            <form action="<c:url value="/zh/user" />" method="GET">
                <input type="submit" value="取消" class="btn btn-secondary"/>
            </form>
        </div>
    </body>
</html>
