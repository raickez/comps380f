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

        <h2>Lecture ${lecture.id}</h2>
        <form:form method="POST" enctype="multipart/form-data"
                   modelAttribute="lectureForm">   
            <form:label path="subject">Subject</form:label><br/>
            <form:input type="text" path="subject" /><br/><br/>
            <c:if test="${fn:length(lecture.attachments) > 0}">
                <b>Lecture Materials:</b><br/>
                <ul>
                    <c:forEach items="${lecture.attachments}" var="attachment">
                        <li>
                            <c:out value="${attachment.name}" />
                            [<a href="<c:url
                                    value="/lecture/${lecture.id}/delete/${attachment.name}"
                                    />">Delete</a>]
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            <b>Lecture Materials</b><br />
            <input type="file" name="attachments" multiple="multiple"/><br/><br/>
            <input type="submit" value="Save"/><br/><br/>
        </form:form>
        <a href="<c:url value="/lecture" />">Return to list lectures</a>
    </body>
</html>