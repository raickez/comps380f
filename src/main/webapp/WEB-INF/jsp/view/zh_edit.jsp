<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <!--<link rel="stylesheet" href="/css/add.css">-->
        <title>Edit the Lecture</title>
        <style>
            .files input {
                outline: 2px dashed #92b0b3;
                outline-offset: -10px;
                -webkit-transition: outline-offset .15s ease-in-out, background-color .15s linear;
                transition: outline-offset .15s ease-in-out, background-color .15s linear;
                padding: 120px 0px 85px 35%;
                text-align: center !important;
                margin: 0;
                width: 100% !important;
            }
            .files input:focus{     outline: 2px dashed #92b0b3;  outline-offset: -10px;
                                    -webkit-transition: outline-offset .15s ease-in-out, background-color .15s linear;
                                    transition: outline-offset .15s ease-in-out, background-color .15s linear; border:1px solid #92b0b3;
            }
            .files{ position:relative}
            .files:after {  pointer-events: none;
                            position: absolute;
                            top: 60px;
                            left: 0;
                            width: 50px;
                            right: 0;
                            height: 56px;
                            content: "";
                            background-image: url(https://image.flaticon.com/icons/png/128/109/109612.png);
                            display: block;
                            margin: 0 auto;
                            background-size: 100%;
                            background-repeat: no-repeat;
            }
            .color input{ background-color:#f1f1f1;}
            .files:before {
                position: absolute;
                bottom: 10px;
                left: 0;  pointer-events: none;
                width: 100%;
                right: 0;
                height: 57px;
                content: " or drag it here. ";
                display: block;
                margin: 0 auto;
                color: #2ea591;
                font-weight: 600;
                text-transform: capitalize;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">講課 ${lecture.id}</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">

                </ul>
                <span class="navbar-text">
                    <security:authorize access="!isAuthenticated()">
                        <a href="<c:url value="/login"/>">Login</a>
                    </security:authorize>
                    <security:authorize access="isAuthenticated()">
                        <c:url var="logoutUrl" value="/logout"/>
                        <form action="${logoutUrl}" method="post">
                            <input type="submit" value="登出" class="btn btn-primary"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                    </security:authorize>
                </span>
            </div>
        </nav>


       <div class="container">
           <br>
        <form:form method="POST" enctype="multipart/form-data" modelAttribute="lectureForm">
            <div class="form-group">
            <form:label path="subject" class="font-weight-bold">標題</form:label><br/>
            <form:textarea path="subject" rows="2" cols="50" placeholder="Leave Comment Here" class="form-control" required="required"/>
            </div>
            <c:if test="${fn:length(lecture.attachments) > 0}">
                <div class="form-group">
                <b>教材</b><br/>
                <ul class="list-group list-group-flush">
                    <c:forEach items="${lecture.attachments}" var="attachment">
                        <li class="list-group-item">
                            <c:out value="${attachment.name}" />
                            [<a class="text-danger" href="<c:url
                                    value="/lecture/${lecture.id}/zh/delete/${attachment.name}"
                                    />">刪除</a>]
                        </li>
                    </c:forEach>
                </ul>
                </div>
            </c:if>
            <b>上載教材</b><br /><br />
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group files">
                            <input type="file" name="attachments" multiple="multiple" class="form-control"/>
                        </div>
                    </div>
                </div>
            </div>
            <input type="submit" value="儲存" class="btn btn-success"/><br/><br/>
        </form:form>
        <a href="<c:url value="/lecture/zh/list" />">返回主頁</a>
       </div>
    </body>
</html>