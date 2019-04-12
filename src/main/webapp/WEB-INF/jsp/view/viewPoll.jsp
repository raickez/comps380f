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
        <h2>Question #${pollDatabase.poll_id}:${pollDatabase.question}</h2>
        <form:form method="POST" modelAttribute="ansPollForm">
            <form:radiobutton path="response" value="${pollDatabase.response1}" checked="checked"/>${pollDatabase.response1}<br>
            <form:radiobutton path="response" value="${pollDatabase.response2}"/>${pollDatabase.response2}<br>
            <form:radiobutton path="response" value="${pollDatabase.response3}"/>${pollDatabase.response3}<br>
            <form:radiobutton path="response" value="${pollDatabase.response4}"/>${pollDatabase.response4}<br><br>
            <form:hidden path="username" value="${principal.username}"/>
            <input type="submit" value="Submit"/>
        </form:form>
        <br>
        <a href="<c:url value="/lecture/poll/list" />">Return to poll page</a>
    </body>
</html>
