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

        <h2>Lecture ${ticket.id}: <c:out value="${ticket.subject}" /></h2>
        <security:authorize access="hasRole('ADMIN') or principal.username=='${ticket.customerName}'">            
            [<a href="<c:url value="/ticket/edit/${ticket.id}" />">Edit</a>]
        </security:authorize>
        <security:authorize access="hasRole('ADMIN')">            
            [<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]
        </security:authorize>
        <br /><br />
        <c:if test="${fn:length(ticket.attachments) > 0}">
            Lecture Materials:
            <c:forEach items="${ticket.attachments}" var="attachment"
                       varStatus="status">
                <c:if test="${!status.first}">, </c:if>
                <a href="<c:url value="/ticket/${ticket.id}/attachment/${attachment.name}" />">
                    <c:out value="${attachment.name}" /></a>
            </c:forEach><br /><br />
        </c:if>
            
            <table border="1">
                <tr>
                    <th>User</th>
                    <th>Comment</th>
                </tr>
                <tr>
                    <td>user test</td>
                    <td>comment test test test</td>
                </tr>
            </table>
            
        <a href="<c:url value="/ticket" />">Return to list tickets</a>
    </body>
</html>
