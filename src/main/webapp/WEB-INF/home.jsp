<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        body, body * {
            font-family: 'Jua'
        }
    </style>
</head>
<body>
    <h2><b>Testing for Release from Jenkins's Maven Project</b></h2>
    <h5>아 집에 가고 싶다! 잠이 쏟아진다!</h5>
    <h4> 자동 빌드 테스트</h4>

    <div>
        <textarea id="msg" style="width: 100%; height: 120px;" class="form-control">함께폭사하자!</textarea>
    </div>

    <div class="input-group" style="width: 250px; margin-left: 50px; margin-top: 10px">
        <select id="seltrans" class="form-select">
            <option value="ko">한국어</option>
            <option value="en">영어</option>
            <option value="ja">일본어</option>
            <option value="zh-CN">중국어</option>
            <option value="es">스페인어</option>
            <option value="de">독일어</option>
        </select>
    <button type="button" id="btntrans" class="btn btn-outline-success">번역하기</button>
    <i class="bi bi-megaphone speak voicespeak" style="font-size: 30px; margin-left: 10px; cursor: pointer"></i>
    </div>

<div id="trans" style="margin-left: 30px; margin-top: 20px; width: 100%; font-size: 20px;"></div>
<script>
    $("#btntrans").click(function (){
        //입력한 메시지
        let msg = $("#msg").val();
        //선택한 나라 기호
        let lang = $("#seltrans").val();

        $.ajax({
            type:"post",
            url:"./trans",
            data:{"msg":msg, "lang":lang},
            dataType:"text",
            success:function (res){
                // alert(res);
                // string을 json 데이터로 변환
                let j = JSON.parse(res);
                //번역한 문자열을 얻는다.
                let s = j.message.result.translatedText;
                //div에 출력
                $("#trans").html(s);
            }
        });
    });

    // 스피커 버튼 영역
    $(".voicespeak").click(function () {
        //입력한 메시지
        let msg = $("#trans").text();
        //선택한 나라 기호
        let lang = $("#seltrans").val();

        if(lang=='en' || lang=='ja' || lang=='zh-CN' || lang=='es' || lang=='ko'){
        $.ajax({
            type: "get",
            url: "./voice",
            data: {"msg": msg, "lang": lang},
            dataType: "text",    //mp3파일명이 될것임
            success: function (res) { //res가 mp3파일명이 반환될것임
                // alert(res);
                let audio = new Audio(res);
                audio.play();
            }
        });
    }else {
            alert("현재 영어, 일어, 중국어, 스페인어만 목소리가 나옵니다.");
          }
    });
</script>
</body>
</html>
