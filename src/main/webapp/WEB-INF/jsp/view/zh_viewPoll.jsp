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
        <title>投票</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">問題 #${pollDatabase.poll_id}:${pollDatabase.question}</a>
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
                            <input type="submit" value="登出" class="btn btn-primary"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                    </security:authorize>
                </span>
            </div>
        </nav>

        <div class="container">
            <br>
            <p class="text-monospace">總共有 ${pollAllCount} 票.</p>
            
            <c:set var = "Ivoted" value = "${Ivote}"/>
            <c:choose>
                <c:when test="${Ivoted==null}"><p class="text-monospace">你還未投票.</p></c:when>
                <c:otherwise> <p class="text-monospace">你投給了 ${Ivote}.</p></c:otherwise>
            </c:choose>
                
            <form:form method="POST" modelAttribute="ansPollForm">
                <div class="form-check">
                    <form:radiobutton class="form-check-input" path="response" value="${pollDatabase.response1}"/>${pollDatabase.response1}
                    <div class="progress">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${pollCount1/pollAllCount*100}%" aria-valuenow="${pollCount1}" aria-valuemin="0" aria-valuemax="100">${pollCount1} 票</div>
                    </div><br>
                </div>
                <div class="form-check">
                    <form:radiobutton class="form-check-input" path="response" value="${pollDatabase.response2}"/>${pollDatabase.response2}
                    <div class="progress">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${pollCount2/pollAllCount*100}%" aria-valuenow="${pollCount2}" aria-valuemin="0" aria-valuemax="100">${pollCount2} 票</div>
                    </div><br>
                </div>
                <div class="form-check">
                    <form:radiobutton class="form-check-input" path="response" value="${pollDatabase.response3}"/>${pollDatabase.response3}
                    <div class="progress">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${pollCount3/pollAllCount*100}%" aria-valuenow="${pollCount3}" aria-valuemin="0" aria-valuemax="100">${pollCount3} 票</div>
                    </div><br>
                </div>
                <div class="form-check">
                    <form:radiobutton class="form-check-input" path="response" value="${pollDatabase.response4}"/>${pollDatabase.response4}
                    <div class="progress">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${pollCount4/pollAllCount*100}%" aria-valuenow="${pollCount4}" aria-valuemin="0" aria-valuemax="100">${pollCount4} 票</div>
                    </div><br><br>
                </div>
                <form:hidden path="username" value="${principal.username}"/>
                <input type="submit" value="投票" class="btn btn-success"/>
            </form:form>
            <br>
            <a href="<c:url value="/lecture/zh/list" />">返回主頁</a>
        </div>
    </body>
</html>
