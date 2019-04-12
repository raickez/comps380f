<%-- 
    Document   : comment
    Created on : 2019年4月9日, 下午06:08:28
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add a New Comment</title>
    </head>
    <body>
        <h1>Add a New Comment</h1>
        <form:form method="POST" modelAttribute="commentForm">
            <form:label path="comment">Leave Comment</form:label>
            <form:input type="text" path="comment"/>
            <form:hidden path="username" value="${principal.username}"/>
            <form:hidden path="lecture_id" value="${lecture.id}"/>
            <input type="submit" value="Comment"/>
        </form:form>
    </body>
</html>
