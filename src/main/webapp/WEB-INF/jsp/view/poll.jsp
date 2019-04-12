<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Poll Page</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <h1>Poll Page</h1>
        <security:authorize access="hasRole('ADMIN')"><a href="<c:url value="/lecture/poll/list/addPoll" />">Add Poll</a><br /><br /></security:authorize>

        <c:choose>
            <c:when test="${fn:length(pollDatabase) == 0}">
                <i>There are no poll in the system.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${pollDatabase}" var="poll">
                    Question #${poll.poll_id}:
                    <a href="<c:url value="${poll.poll_id}" />">
                        <c:out value="${poll.question}" /></a>
                        <security:authorize access="hasRole('ADMIN')">            
                        [<a href="<c:url value="/lecture/poll/delete/${poll.poll_id}" />">Delete</a>]
                    </security:authorize>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <br>
        <a href="<c:url value="/lecture" />">Return to list lectures</a>
    </body>
</html>
