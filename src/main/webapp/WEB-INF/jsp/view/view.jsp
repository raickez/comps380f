<!DOCTYPE html>
<html>
    <head>
        <title>Lecture</title>
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
                    <tr>
                        <td colspan="2"><i>There are no comments.</i></td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${commentDatabase}" var="entry">
                        <tr>
                            <td><c:out value="${entry.username}" /></td>
                            <td><c:out value="${entry.comment}" />
                                <security:authorize access="hasRole('ADMIN') or principal.username=='${entry.username}'">
                                [<a href="<c:url value="deleteComment/${lectureId}/${entry.id}" />">Delete</a>]
                            </security:authorize></td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </table><br>

        <a href="<c:url value="/lecture/${lectureId}/comment"/>">Leave Comment</a><br>
        <a href="<c:url value="/lecture" />">Return to list lectures</a>
    </body>
</html>
