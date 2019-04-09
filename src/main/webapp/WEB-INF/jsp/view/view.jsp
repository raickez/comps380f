<!DOCTYPE html>
<html>
    <head>
        <title>Customer Support</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Lecture ${lecture.id}: <c:out value="${lecture.subject}" /></h2>
        <security:authorize access="hasRole('ADMIN') or principal.username=='${lecture.customerName}'">            
            [<a href="<c:url value="/lecture/edit/${lecture.id}" />">Edit</a>]
        </security:authorize>
        <security:authorize access="hasRole('ADMIN')">            
            [<a href="<c:url value="/lecture/delete/${lecture.id}" />">Delete</a>]
        </security:authorize>
        <br /><br />
        <c:if test="${fn:length(lecture.attachments) > 0}">
            Lecture Materials:
            <c:forEach items="${lecture.attachments}" var="attachment"
                       varStatus="status">
                <c:if test="${!status.first}">, </c:if>
                <a href="<c:url value="/lecture/${lecture.id}/attachment/${attachment.name}" />">
                    <c:out value="${attachment.name}" /></a>
            </c:forEach><br /><br />
        </c:if>

        <table border="1">
            <tr>
                <th>User</th>
                <th>Comment</th>
            </tr>
            <c:choose>
                <c:when test="${fn:length(commentDatabase) == 0}">
                    <tr><td><i>There are no comments in the system</i></td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${commentDatabase}" var="comment">
                        <td><c:out value="${comment.username}" /></td>
                        <td><c:out value="${comment.comment}" /></td>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
        <form:form method="POST" modelAttribute="commentForm">
            <form:label path="comment">Leave Comment</form:label><br/>
            <form:input type="text" path="comment" /><br/><br/>
            <input type="hidden" name="username" value="${lecture.customerName}"/>
            <input type="hidden" name="lecture_id" value="${lecture.id}"/>
            <input type="submit" value="Comment"/>
        </form:form>

        <a href="<c:url value="/lecture" />">Return to list lectures</a>
    </body>
</html>
