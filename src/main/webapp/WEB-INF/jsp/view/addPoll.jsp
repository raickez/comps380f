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

        <h2>Create a Poll</h2>
        <form:form method="POST" modelAttribute="pollForm">
            <form:label path="question">Question:</form:label><br>
            <form:textarea path="question" rows="5" cols="50" /><br>
            <form:label path="response1">Answer1:</form:label><br>
            <form:textarea path="response1" rows="5" cols="50" /><br>
            <form:label path="response2">Answer2:</form:label><br>
            <form:textarea path="response2" rows="5" cols="50" /><br>
            <form:label path="response3">Answer3:</form:label><br>
            <form:textarea path="response3" rows="5" cols="50" /><br>
            <form:label path="response4">Answer4:</form:label><br>
            <form:textarea path="response4" rows="5" cols="50" /><br><br>
            <input type="submit" value="Submit"/>
        </form:form>

    </body>
</html>
