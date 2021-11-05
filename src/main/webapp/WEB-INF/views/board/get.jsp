<%@ page
        language="java"
        contentType="text/html; charset=utf-8"
        pageEncoding="utf-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file ="../includes/header.jsp" %>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header"> Board Read </h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
    <div class="col-lg-12">

        <div class="panel panel-default">

            <div class="panel-heading">Board Read Page</div>
            <!-- /.pannel-heading -->
            <div class="panel-body">

                <div class="form-group">
                    <label>Bno</label>
                    <input class="form-control" name="bno" value="<c:out value="${board.bno}"/>"
                           readonly="readonly">
                </div>

                <div class="form-group">
                    <label>Title</label>
                    <input class="form-control" name="title" value="<c:out value="${board.title}"/>"
                           readonly="readonly">
                </div>

                <div class="form-group">
                    <label>Text area</label>
                    <textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>
                </div>

                <div class="form-group">
                    <label>Writer</label>
                    <input class="form-control" name="writer" value="<c:out value="${board.writer}" />"
                           readonly="readonly">
                </div>

                <button data-oper="modify"
                        class="btn btn-default"
                        onclick="location.href='/board/modify?bno=<c:out value="${board.bno}" />'">
                    Modify
                </button>

                <button data-oper="list"
                        class="btn btn-info"
                        onclick="location.href='/board/list'">
                    List
                </button>

                <form id="operForm" action="/board/modify" method="get">
                    <input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
                    <input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
                    <input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
                    <input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
                    <input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
                </form>

            </div>
            <!-- end panel-body -->

        </div>
        <!-- end panel-heading -->
    </div>
    <!-- end panel -->
</div>
<!-- /.row -->


<!-- 첨부파일 영역 시작-->
<!-- 원본 이미지 영역 -->
<div class="bigPictureWrapper">

    <div class="bigPicture">
    </div>
</div>

<style>
    .uploadResult{
        width: 100%;
        background-color: gray;
    }

    .uploadResult ul{
        display:flex;
        flex-flow: row;
        justify-content: center;
        text-align: center;
    }

    .uploadResult ul li{
        list-style: none;
        padding: 10px;
        align-content: center;
        text-align: center;
    }

    .uploadResult ul li img{
        width: 100px;
    }

    .uploadResult ul li span{
        color: white;
    }

    .bigPictureWrapper{
        position: absolute;
        display: none;
        justify-content: center;
        align-items: center;
        top: 0%;
        width: 100%;
        height: 100%;
        background-color: gray;
        z-index: 100;
        background: rgba(225, 225, 225, 0.5);
    }

    .bigPicture{
        position: relative;
        display:flex;
        justify-content: center;
        align-items: center;
    }

    .bigPicture img{
        width: 600px;
    }
</style>

<!-- 첨부파일 목록 -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-heading">Files</div>
            <!-- /.panel-heading -->

            <div class="panel-body">

                <div class="uploadResult">
                    <ul>
                    </ul>
                </div>
            </div>
            <!-- end panel-body-->
        </div>
        <!-- end panel-body -->
    </div>
    <!-- end panel -->
</div>
<!-- /. row -->
<!-- 첨부파일 영역 끝-->


<!-- 댓글목록 시작-->
<div class="row">

    <div class="col-lg-12">

        <!-- /.panel -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-comments fa-fw"></i>
                Reply
                <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
            </div>
        </div>

        <!-- /.panel-heading -->
        <div class="panel-body">

            <ul class="chat">
                <!-- start reply -->
                <li class="left clearfix" data-rno="12">
                    <div>
                        <div class="header">
                            <strong class="primary-font">user00</strong>
                            <small class="pull-right text-muted">2018-01-01 13:13</small>
                        </div>
                        <p>Good job!</p>
                    </div>
                </li>
                <!-- end reply -->
            </ul>
            <!-- /.end ul-->
        </div>
        <!-- /.panel .chat-panel -->

        <div class="panel-footer">

        </div>
        <!-- /. pannel-footer -->
    </div>
</div>
<!-- ./end row : 댓글목록-->

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>Reply</label>
                    <input class="form-control" name="reply" value="new Repl!!!!">
                </div>
                <div class="form-group">
                    <label>Replyer</label>
                    <input class="form-control" name="replyer" value="replyer">
                </div>
                <div class="form-group">
                    <label>Reply Date</label>
                    <input class="form-control" name="replyDate" value="">
                </div>
            </div>

            <div class="modal-footer">
                <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
                <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
                <button id="modalRegisterBtn" type="button" class="btn btn-default" data-dismiss="modal">Register</button>
                <button id="modalCloseBtn" type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<%@include file="../includes/footer.jsp" %>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">
    $(function(){

        console.log("get.js started.....");
        console.log("replyService : {}" , replyService);


        //-------------- 수정/목록 클릭 이벤트
        var operForm = $("#operForm");

        var bnoValue = '<c:out value="${board.bno}"/>';
        var replyUL = $(".chat");


        $("button[data-oper='modify']").on("click", function(e){
            operForm.attr("action", "/board/modify").submit();

        }); //on click for modify

        $("button[data-oper='list']").on("click", function(e){
            operForm.find("#bno").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();

        }); //on click for list


        //-------------- 댓글목록 보이기
        // 댓글 목록 1페이지 보기
        showList(1);

        function showList(page){
            console.log("show list : " + page);

            replyService.getList({bno:bnoValue, page:page||1}, function(replyCnt, list){

                console.log("replyCnt : {} " , replyCnt);
                console.log("list: " + list);
                console.log(list);

                if(page == -1){
                    pageNum = math.ceil(replyCnt / 10.0);
                    showList(pageNum);

                    return;
                } //if : page번호가 -1로 전달되면, 마지막 페이지 찾아서 다시 호출.

                var str="";

                if(list==null || list.length == 0){
                    return;
                } //if : 작성된 댓글이 없으면..

                for (var i=0, len=list.length||0; i<len; i++){
                    str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
                    str += " <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
                    str += "   <small class='pull-right text-muted'>"
                        + replyService.displayTime(list[i].replyDate)
                        + "</small></div>";
                    str += "      <p>"+list[i].reply+"</p></div></li>";
                } //for

                replyUL.html(str);

                showReplyPage(replyCnt);
            }); //function
        }// showList


        //----------------- 댓글 등록 모달
        var modal = $(".modal");
        var modalInputReply = modal.find("input[name='reply']");
        var modalInputReplyer = modal.find("input[name='replyer']");
        var modalInputReplyDate = modal.find("input[name='replyDate']");

        var modalModBtn = $("#modalModBtn");
        var modalRemoveBtn = $("#modalRemoveBtn");
        var modalRegisterBtn = $("#modalRegisterBtn");


        $("#addReplyBtn").on("click", function(e){

            modal.find("input").val("");
            modalInputReplyDate.closest("div").hide();
            modal.find("button[id!='modalCloseBtn']").hide();

            modalRegisterBtn.show();

            $(".modal").modal("show");

        }); // on click for addReplyBtn


        modalRegisterBtn.on("click", function(e){
            var reply = {
                reply: modalInputReply.val(),
                replyer: modalInputReplyer.val(),
                bno: bnoValue
            };

            replyService.add(reply, function(result){

                alert(result);

                modal.find("input").val("");
                modal.modal("hide");

                // 새 댓글 등록 후, 댓글 목록 갱신
                // showList(1);

                // showList(-1) 호출하여 전체 댓글 숫자 파악하고, 다시 마지막 페이지를 호출해서 이동시킴.
                showList(-1);
            }); //add
        }); //on click for modalRegisterBtn


        //------------ 개별 댓글 클릭 이벤트 처리
        $(".chat").on("click", "li", function(e){

            var rno = $(this).data("rno");

            replyService.get(rno, function(reply){
                modalInputReply.val(reply.reply);
                modalInputReplyer.val(reply.replyer);
                modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
                    .attr("readonly", "readonly");
                modal.data("rno", reply.rno);

                modal.find("button[id != 'modalCloseBtn']").hide();
                modalModBtn.show();
                modalRemoveBtn.show();

                $(".modal").modal("show");

            }); //get
        }); //on click for chat


        modalModBtn.on("click", function(){
            var reply = {
                rno: modal.data("rno"),
                reply: modalInputReply.val()
            };

            replyService.update(reply, function(result){

                alert(result);
                modal.modal("hide");
                showList(pageNum);

            }); //update
        }); //on click for modalModBtn


        modalRemoveBtn.on("click", function(){
            var rno = modal.data("rno");

            replyService.remove(rno, function(result){

                alert(result);
                modal.modal("hide");
                showList(pageNum);
            }); //remove
        }); //on click for modalRemoveBtn


        //--------------- 댓글 페이지 출력
        var pageNum = 1;
        var replyPageFooter = $(".panel-footer");

        function showReplyPage(replyCnt){

            var endNum = Math.ceil(pageNum / 10.0) * 10;
            var startNum = endNum - 9;
            var prev = startNum != 1;
            var next = false;

            console.log("endNum : " + endNum);
            console.log("startNum : " + startNum);
            console.log("prev : " + prev);
            console.log("next : " + next);

            console.log("replyCnt : " + replyCnt);

            if(endNum * 10 >= replyCnt){
                endNum = Math.ceil(replyCnt / 10.0);
            } //if

            if(endNum * 10 < replyCnt){
                next = true;
            } //if

            var str = "<ul class='pagination pull-right'>";

            if(prev){
                str += "<li class='page-item'><a class='page-link' href='"
                    +(startNum -1) + "'>Previous</a></li>";
            } //if

            for(var i=startNum; i<=endNum; i++){
                var active = pageNum == i? "active" : "";

                str += "<li class='page-item"+active+"'><a class='page-link' href='"+i+"'>"+i+"</" +
                    "a></li>";
            } //for

            if(next){
                str += "<li class='page-item'><a class='page-link' href='" + (endNum+1)+"'>Next</a></li>";
            } //if

            str += "</ul></div>";

            console.log("str : " + str);

            replyPageFooter.html(str);
        } //showReplyPage


        //---------------- 댓글 페이지 이동
        replyPageFooter.on("click", "li a", function(e){
            e.preventDefault();

            console.log("page click...");

            var targetPageNum = $(this).attr("href");

            console.log("targetPageNum: " + targetPageNum);

            pageNum = targetPageNum;

            showList(pageNum);
        }); //on click for replyPageFooter

    }); //.jq


    console.log("----------reply.js TEST");

    var bnoValue = '<c:out value="${board.bno}"/>';

    //-- for replyService List test
    replyService.getList({bno:bnoValue, page:1}, function(list){

        for(var i=0, len=list.length||0; i<len; i++){
            console.log(list[i]);
        } //for
    }); //getList

    //-- for replyService add test
    replyService.add({reply:"js Test", replyer:"tester", bno:bnoValue}, function(result){
            alert("RESULT : " + result);
    }); //add

    //-- 4번 댓글 삭제 테스트
    replyService.remove(4,function(count){
      console.log(count);

      if(count === "success"){
          alert("REMOVED");
      } //if
    }, function(err){
        alert("REMOVE ERROR...");
    }); //remove

    //-- 9번 댓글 수정 테스트
    replyService.update({
        rno: 9,
        bno: bnoValue,
        reply: "Modified Reply..."
    }, function(result){
        alert("수정완료...");
    }); //update

    //-- 9번 댓글 보기 테스트
    replyService.get(10, function(data){
        console.log(data);
    }); //get

</script>

<script>
    $(function(){
        //------- 첨부파일 데이터 가져오기 (IIFE)
        (function(){
            console.debug("IIFE invoked...");

            var bno = '<c:out value="${board.bno}"/>';
            console.log("bno : {}", bno);

            $.getJSON("/board/getAttachList", {bno:bno}, function(arr){
                console.log("arr : {}", arr);

                var str = "";

                $(arr).each(function(i, attach){

                    //image type
                    if(attach.fileType){
                        var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);

                        str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid +
                            "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "'><div>";
                        str += "<img src='/display?fileName=" + fileCallPath + "'>";
                        str += "</div></li>";
                    } else {

                        str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid +
                            "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "'><div>";
                        str += "<span>"+ attach.fileName + "</span><br/>";
                        str += "<img src='/resources/img/attach.png'>";
                        str += "</div></li>";
                    }//if-else
                }); //traverse for arr

                $(".uploadResult ul").html(str);
            }); //getJSON

        })(); //IIFE


        //-----------첨부파일 목록에서, 첨부파일 클릭 시 이벤트(원본 이미지 보이기 or 다운로드)
        $(".uploadResult").on("click", "li", function(e){
            console.debug("uploadResult li is clicked.");

            var liObj = $(this);

            var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));

            if(liObj.data("type")){
                showImage(path.replace(new RegExp(/\\g/), "/"));

            } else {
                //download
                self.location= "/download?fileName=" + path;
            } //if-else

        }); //on click for uploadResult


        function showImage(fileCallPath){
            alert(fileCallPath);

            $(".bigPictureWrapper").css("display", "flex").show();

            $(".bigPicture").html("<img src='/display?fileName=" + fileCallPath + "'>")
                            .animate({width:'100%', height:'100%'}, 1000);
        } //showImage


        //----------- 원본 이미지 창 닫기
        $(".bigPictureWrapper").on("click", function(e){
            $(".bigPicture").animate({width:'0%', height:'0%'}, 1000);

            setTimeout(function (){
                $(".bigPictureWrapper").hide();
            }); //setTimeout

        }); //on click for bitPictureWrapper
    }); //.jq
</script>
