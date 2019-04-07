<!DOCTYPE html>
<html>
    <head>
        <title>Edit Course Materials Page</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Edit ${course.subject}</h2>
        <form:form method="POST" enctype="multipart/form-data"
                   modelAttribute="courseForm">   
            <form:label path="subject">Course</form:label><br/>
            <form:input type="text" path="subject" /><br/><br/>
            <form:label path="body">Lectures</form:label><br/>
            <form:textarea path="body" rows="5" cols="30" /><br/><br/>
            <c:if test="${fn:length(course.attachments) > 0}">
                <b>Course Materials:</b><br/>
                <ul>
                    <c:forEach items="${course.attachments}" var="attachment">
                        <li>
                            <c:out value="${attachment.name}" />
                            [<a href="<c:url
                                    value="/course/${course.id}/delete/${attachment.name}"
                                    />">Delete</a>]
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            <b>Add course materials</b><br />
            <input type="file" name="attachments" multiple="multiple"/><br/><br/>
            <input type="submit" value="Save"/><br/><br/>
        </form:form>
        <a href="<c:url value="/course" />">Return to list courses</a>
    </body>
</html>