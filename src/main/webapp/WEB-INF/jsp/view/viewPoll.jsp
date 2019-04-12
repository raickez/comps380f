<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Poll Page</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <c:choose>
            <c:when test="${fn:length(pollDatabase) == 0}">
                <i>null in pollDatabase</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${pollDatabase}" var="poll">
                    <h2>Question #${poll.poll_id}:${poll.question}</h2>
                    <form:form method="POST" modelAttribute="ansPollForm">
                        <form:radiobutton path="response" value="${poll.response1}">${poll.response1}</form:label><br>
                            <form:radiobutton path="response" value="${poll.response2}">${poll.response2}</form:label><br>
                                <form:radiobutton path="response" value="${poll.response3}">${poll.response3}</form:label><br>
                                    <form:radiobutton path="response" value="${poll.response4}">${poll.response4}</form:label><br>
                                        <input type="submit" value="Submit"/>
                                        </form:form>
                                        </c:forEach>
                                        </c:otherwise>
                                        </c:choose>


                                    </body>
                                </html>
