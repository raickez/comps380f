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
        <form:form method="POST" modelAttribute="commentForm">
            <form:label path="question">Question</form:label>
            <form:input type="text" path="question"/>
            <form:label path="response1">Answer1</form:label>
            <form:input type="text" path="response1"/>
            <form:label path="response2">Answer2</form:label>
            <form:input type="text" path="response2"/>
            <form:label path="response3">Answer3</form:label>
            <form:input type="text" path="response3"/>
            <form:label path="response4">Answer4</form:label>
            <form:input type="text" path="response4"/>
            <input type="submit" value="Submit"/>
        </form:form>

    </body>
</html>
