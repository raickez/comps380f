<!DOCTYPE html>
<html>
    <head>
        <title>Course Material Page</title>
    </head>
    <body>
        <h2>Course Title: <c:out value="${course.courseTitle}"/></h2>
        <p>Lectures: <c:out value="${course.lectures}"/></p>
        <!--<c:out value="${course.body}" /><br /><br />-->
        <c:if test="${course.numberOfAttachments > 0}">
            Course Materials:
            <c:forEach items="${course.attachments}" var="attachment" varStatus="status">
                <c:if test="${!status.first}">, </c:if>
                <a href="<c:url value="/course/${courseId}/attachment/${attachment.name}" />">
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
            
            
        <a href="<c:url value="/course" />">Return to list courses</a>
    </body>
</html>
