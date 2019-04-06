<!DOCTYPE html>
<html>
    <head>
        <title>Course</title>
    </head>
    <body>
        <h2>TCourse</h2>
        <a href="<c:url value="/ticket/create" />">Add Course</a><br /><br />
        <table border="1">
            <tr>
                <th>Course</th>
                <th>Lectures</th>
                <th>Poll</th>
            </tr>
            <tr>
        <c:choose>
            <c:when test="${fn:length(ticketDatabase) == 0}">
                <td colspan="3"><i>There are no class in the system.</i></td>
            </c:when>
            <c:otherwise>
                <c:forEach items="${ticketDatabase}" var="entry">
                    <td><a href="<c:url value="/ticket/view/${entry.key}" />">${entry.value.customerName}</a></td>
                    <td>test</td>
                    <td>testing</td>
                    <!--Course ${entry.key}:
                    <a href="<c:url value="/ticket/view/${entry.key}" />">
                        <c:out value="${entry.value.subject}" /></a>
                    (customer: <c:out value="${entry.value.customerName}" />)<br />-->
                </c:forEach>
            </c:otherwise>
        </c:choose>
            </tr>
        </table>
    </body>
</html>
