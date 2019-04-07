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

        <h2>Course Title: <c:out value="${course.subject}" /></h2>
        <c:if test="${fn:length(course.attachments) > 0}">
            Course Materials:
            <c:forEach items="${course.attachments}" var="attachment"
                       varStatus="status">
                <c:if test="${!status.first}">, </c:if>
                <a href="<c:url value="/course/${course.id}/attachment/${attachment.name}" />">
                    <c:out value="${attachment.name}" /></a>
            </c:forEach><br /><br />
        </c:if>

        Lectures: <c:out value="${course.body}" /><br /><br />

        <a href="<c:url value="/course" />">Return to list courses</a>
    </body>
</html>
