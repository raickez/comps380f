<!DOCTYPE html>
<html>
    <head>
        <title>Course</title>
    </head>
    <body>
        <h2>Course</h2>
        <a href="<c:url value="/course/create" />">Add Course</a><br /><br />
        <table border="1">
            <tr>
                <th>Course</th>
                <th>Lectures</th>
                <th>Poll</th>
            </tr>
            <tr>
        <c:choose>
            <c:when test="${fn:length(courseDatabase) == 0}">
                <td colspan="3"><i>There are no class in the system.</i></td>
            </c:when>
            <c:otherwise>
                <c:forEach items="${courseDatabase}" var="entry">
                    <td><a href="<c:url value="/course/view/${entry.key}" />">${entry.value.courseTitle}</a></td>
                    <td>${entry.value.lectures}</td>
                    <td>testing</td>
                </c:forEach>
            </c:otherwise>
        </c:choose>
            </tr>
        </table>
    </body>
</html>
