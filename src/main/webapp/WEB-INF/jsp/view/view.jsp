<!DOCTYPE html>
<html>
    <head>
        <title>Course Material Page</title>
    </head>
    <body>
        <!--<h2>Ticket #${ticketId}: <c:out value="${ticket.subject}" /></h2>
        <i>Customer Name - <c:out value="${ticket.customerName}" /></i><br /><br />-->
        <h2>Course Title: <c:out value="${ticket.customerName}"/></h2>
        <!--<c:out value="${ticket.body}" /><br /><br />-->
        <c:if test="${ticket.numberOfAttachments > 0}">
            Course Materials:
            <c:forEach items="${ticket.attachments}" var="attachment" varStatus="status">
                <c:if test="${!status.first}">, </c:if>
                <a href="<c:url value="/ticket/${ticketId}/attachment/${attachment.name}" />">
                    <c:out value="${attachment.name}" /></a>
            </c:forEach><br /><br />
        </c:if>
            <table border="1">
                <tr>
                    <th>User</th>
                    <th>Comments</th>
                </tr>
                <tr>
                    <td>user test</td>
                    <td>comments test</td>
                </tr>
            </table>
        <a href="<c:url value="/ticket" />">Return to list tickets</a>
    </body>
</html>
