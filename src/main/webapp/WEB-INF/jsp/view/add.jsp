<!DOCTYPE html>
<html>
    <head>
        <title>Course Material Page</title>
    </head>
    <body>
        <h2>Course Material Page</h2>
        <form:form method="POST" enctype="multipart/form-data" modelAttribute="courseForm">
            <form:label path="courseTitle">Course Title</form:label><br/>
            <form:input type="text" path="courseTitle" /><br/><br/>
            
            <form:label path="lectures">Lectures</form:label><br/>
            <form:textarea path="lectures" row="5" cols="30" /><br/><br/>
            
            <form:label path="body">Comments</form:label><br/>
            <form:textarea path="body" rows="5" cols="30" /><br/><br/>
            <b>Course Materials</b><br/>
            <input type="file" name="attachments" multiple="multiple"/><br/><br/>
            <input type="submit" value="Submit"/>
        </form:form>
            <a href="<c:url value="/course" />">Return to list courses</a>
    </body>
</html>
