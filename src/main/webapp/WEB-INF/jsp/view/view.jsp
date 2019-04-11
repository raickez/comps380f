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
            <tr>
                <c:choose>
                    <c:when test="${fn:length(commentDatabase) == 0}">
                        <td colspan="2"><i>There are no tickets in the system.</i><td>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${commentDatabase}" var="entry">a
                                <td><c:out value="${entry.value.username}" /></td>
                                <td><c:out value="${entry.value.comment}" /></td>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tr>
        </table><br>
            
        <a href="<c:url value="/lecture/${lectureId}/comment"/>">Leave Comment</a><br>
        <a href="<c:url value="/lecture" />">Return to list lectures</a>
    </body>
</html>
