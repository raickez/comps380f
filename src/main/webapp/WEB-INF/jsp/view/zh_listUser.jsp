<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>用戶名單</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">用戶</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item"><a class="nav-link" href="<c:url value="/user/zh/create" />">新增用戶</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value="/lecture/zh/list" />">返回主頁</a></li>
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
            <c:choose>
                <c:when test="${fn:length(lectureUsers) == 0}">
                    <i>系統沒有用戶.</i>
                </c:when>
                <c:otherwise>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>用戶</th><th>密碼</th><th>組別</th><th>刪除</th>
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
                                    [<a class="text-danger" href="<c:url value="/user/zh/delete/${user.username}" />">刪除</a>]
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
