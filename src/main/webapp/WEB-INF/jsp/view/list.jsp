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
        <h2>Courses</h2>
        <security:authorize access="hasRole('ADMIN')">    
            <a href="<c:url value="/user" />">Manage User Accounts</a><br /><br />
        </security:authorize>
        <a href="<c:url value="/course/create" />">Add a Course</a><br /><br />
        <table border="1">
            <tr>
                <th>Course</th>
                <th>Lectures</th>
                <th>Poll</th>
                    <security:authorize access="hasRole('ADMIN') or
                                        principal.username=='${course.lecturerName}'">
                    <th colspan='2'>Modify</th>
                    </security:authorize>
            </tr>
            <tr>
                <c:choose>
                    <c:when test="${fn:length(courseDatabase) == 0}">
                        <td colspan="4"><i>There are no courses in the system.</i></td>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${courseDatabase}" var="course">
                            <td><a href="<c:url value="/course/view/${course.id}"/>"><c:out value="${course.subject}"/></a></td>
                            <td><c:out value="${course.body}"/></td>
                            <td>
                                <ol><li>test...</li>
                                <li>test....</li></ol>
                            </td>
                            <security:authorize access="hasRole('ADMIN') or
                                                principal.username=='${course.lecturerName}'">
                                <td><a href="<c:url value="/course/edit/${course.id}" />">Edit</a></td>
                                <td><a href="<c:url value="/course/delete/${course.id}" />">Delete</a></td>
                            </security:authorize>
                                
                        
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
    </body>
</html>
