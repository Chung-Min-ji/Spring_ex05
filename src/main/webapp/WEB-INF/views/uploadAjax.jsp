<%@ page
        language="java"
        contentType="text/html; charset=utf-8"
        pageEncoding="utf-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<h1>Upload With Ajax</h1>

<div class="uploadDiv">
    <input type="file" name="uploadFile" multiple>
</div>

<button id="uploadBtn">Upload</button>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>

<script>
    $(function(){

        $("#uploadBtn").on("click", function(e){
            var formData = new FormData();
            var inputFile = $("input[name='uploadFile']");
            var files=inputFile[0].files;

            console.log("files : {}", files);

            // add File Data to formData
            // 첨부파일 데이터를 formData 에 추가해서, formData 자체를 전송.
            for(var i = 0; i< files.length; i++){
                formData.append("uploadFile", files[i]);
            } //for

            $.ajax({
                url: 'uploadAjaxAction',
                // processData와 contentType은 false로 지정해야 전송됨.

                // processData란?
                // 일반적으로 서버에 전송되는 데이터는 쿼리스트링 형태로 전달되는데,
                // 파일전송의 경우 이를 막기 위해 false 지정.
                processData: false,

                // contentType의 default는 application/x-www-form-urlencoded; charset=UTF-8 인데,
                // 이를 multipart/form-data 로 전송하기 위해 false 지정.
                contentType: false,
                data: formData,
                type: 'post',
                success: function(result){
                     alert("Uploaded");
                } //success
            }); //ajax
        }); //on click for uploadBtn

    }) //.jq
</script>

</body>
</html>