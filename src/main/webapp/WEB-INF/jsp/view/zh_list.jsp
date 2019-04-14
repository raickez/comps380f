<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>COMPS380F 網頁應用程式: 設計和開發</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">COMPS380F 網頁應用程式: 設計和開發</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <security:authorize access="hasRole('ADMIN')"> 
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value="/lecture/zh/create" />">新增講課</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value="/lecture/poll/zh/list/addPoll" />">新增投票</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value="/user/zh" />">管理用戶帳戶</a>
                        </li>
                    </security:authorize>
                    <li class="nav-item"><a class="nav-link" href="<c:url value="/lecture/list" />">English</a></li>
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
                            <input type="submit" value="登出" class="btn btn-primary"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                    </security:authorize>
                </span>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <div class="col col-lg-7">
                    <h2>講課</h2>
                    <c:choose>
                        <c:when test="${fn:length(lectureDatabase) == 0}">
                            <i>系統沒有講課資料.</i>
                        </c:when>
                        <c:otherwise>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${lectureDatabase}" var="lecture">
                                    <li class="list-group-item">講課 ${lecture.id}:
                                        <a href="<c:url value="/lecture/zh/view/${lecture.id}" />">
                                            <c:out value="${lecture.subject}" /></a>
                                            <security:authorize access="isAuthenticated() and (hasRole('ADMIN') or
                                                                principal.username=='${lecture.customerName}')">
                                            [<a href="<c:url value="/lecture/zh/edit/${lecture.id}" />" class="text-warning">修改</a>]
                                        </security:authorize>
                                        <security:authorize access="isAuthenticated() and (hasRole('ADMIN'))">            
                                            [<a href="<c:url value="/lecture/zh/delete/${lecture.id}" />" class="text-danger">刪除</a>]
                                        </security:authorize>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col col-lg-5">
                    <h2>投票</h2>
                    <c:choose>
                        <c:when test="${fn:length(pollDatabase) == 0}">
                            <i>系統沒有投票.</i>
                        </c:when>
                        <c:otherwise>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${pollDatabase}" var="poll">
                                    <li class="list-group-item">
                                        問題 #${poll.poll_id}:
                                        <a href="<c:url value="poll/${poll.poll_id}" />">
                                            <c:out value="${poll.question}" /></a>
                                            <security:authorize access="hasRole('ADMIN')">            
                                            [<a class="text-danger" href="<c:url value="/lecture/zh/poll/delete/${poll.poll_id}" />">刪除</a>]
                                        </security:authorize>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
    </body>
</html>