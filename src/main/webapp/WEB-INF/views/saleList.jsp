<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<% // 세션에 sessionId가 존재하는지 확인
    String sessionId = (String) session.getAttribute("urId");
%>
<html>

<head>
    <title>판매/나눔</title>
    <style>
        #saleListTB {
            margin: 0 auto; /* 수평 가운데 정렬 */
            width: 80%; /* 테이블의 너비 설정 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }
    </style>
</head>

<body>
<button type="button" onclick="writeBtn()">글쓰기</button>
<select id="addr_cd">
    <option id="selectAll" value="" selected>전체</option>
    <c:forEach var="AddrCd" items="${addrCdList}">
        <option value="${AddrCd.addr_cd}">${AddrCd.addr_name}</option>
    </c:forEach>
</select><br>
<select id="category1" onchange="loadCategory2()">
    <option value="" disabled selected>대분류</option>
    <c:forEach var="category" items="${saleCategory1}">
        <option value="${category.sal_cd}">${category.name}</option>
    </c:forEach>
</select>

<select id="category2" onchange="loadCategory3()">
    <option value="" disabled selected>중분류</option>
</select>

<select id="category3">
    <option value="" disabled selected>소분류</option>
</select>
<p style="color: orangered;" id="salecategoryMsg"></p>
<span><b><p style="display: inline; color: red" id="sal_name"></p></b> 상품</span>
<br><br>
<table id="saleListTB">
    <tr>
        <th class="no">번호</th>
        <th class="title">제목</th>
        <th class="writer">이름</th>
        <th class="addr_name">주소명</th>
        <th class="regdate">등록일</th>
        <th class="viewcnt">조회수</th>
    </tr>
    <tbody id="saleList">
    </tbody>
</table>
<br>
<div style="text-align: center">
    <a href="<c:url value="/sale/list?page=1"/>"> << </a>
    <c:choose>
        <c:when test="${(ph.page-1) < 1}">
            <a href="<c:url value="/sale/list?page=${ph.totalPage}"/>"> < </a>
        </c:when>
        <c:otherwise>
            <a href="<c:url value="/sale/list?page=${ph.page - 1}"/>"> < </a>
        </c:otherwise>
    </c:choose>
    <c:forEach var="i" begin="${ph.startPage}" end="${ph.endPage}">
        <a class="page ${i==ph.page? "paging-active" : ""}" href="<c:url value="/sale/list?page=${i}"/>">${i}</a>
    </c:forEach>
    <c:choose>
        <c:when test="${(ph.page+1) > ph.totalPage}">
            <a href="<c:url value="/sale/list?page=1"/>"> > </a>
        </c:when>
        <c:otherwise>
            <a href="<c:url value="/sale/list?page=${ph.page+1}"/>"> > </a>
        </c:otherwise>
    </c:choose>
    <a href="<c:url value="/sale/list?page=${ph.totalPage}"/>"> >> </a>
</div>
<br>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
    // window.onload = function() {
    //     // 페이지가 로드될 때 실행할 코드 작성
    //     alert("페이지가 로드되었습니다!");
    // };

    // "전체" 옵션이 보이지 않도록 설정
    if ("${sessionId}" != null || "${sessionId}" != "") {
        document.getElementById("selectAll").style.display = "none"; // "전체" 옵션 숨기기

        // 첫 번째 옵션 선택
        var addrCdSelect = document.getElementById("addr_cd");
        addrCdSelect.selectedIndex = 1;
    }

    function loadCategory2() {
        let category1Value = $('#category1').val();
        console.log(category1Value)
        if (category1Value !== "") {
            $.ajax({
                type: "POST",
                url: "/sale/saleCategory2",
                dataType: "json", // 받을 값
                data: {category1: category1Value},
                success: function (data) {
                    let category2Select = document.getElementById("category2");
                    category2Select.innerHTML = "<option value='' disabled selected>중분류</option>";
                    let category3Select = document.getElementById("category3");
                    category3Select.innerHTML = "<option value='' disabled selected>소분류</option>";
                    console.log("data.length : ", data.length);
                    if (data.length > 0) {
                        data.forEach(function (category) {
                            // console.log(typeof category);
                            if (category.sal_cd.startsWith(category1Value)) {
                                let option = new Option(category.name, category.sal_cd);
                                category2Select.add(option);
                            }
                        });
                    } else {
                        $("#sal_name").text("");
                    }
                },
                error: function (xhr, status, error) {
                    alert("error", error);
                }
            });
        }
    }

    function loadCategory3() {
        let category2Value = $('#category2').val();
        console.log(category2Value)
        if (category2Value !== "") {
            $.ajax({
                type: "POST",
                url: "/sale/saleCategory3",
                dataType: "json",
                data: {category2: category2Value},
                success: function (data) {
                    // alert(data);
                    let category3Select = document.getElementById("category3");
                    category3Select.innerHTML = "<option value='' disabled selected>소분류</option>";
                    console.log("data.length : ", data.length);
                    if (data.length > 0) {
                        data.forEach(function (category) {
                            if (category.sal_cd.startsWith(category2Value)) {
                                let option = new Option(category.name, category.sal_cd);
                                category3Select.add(option);
                            }
                        });
                    } else {
                        $("#sal_name").text("");
                    }
                },
                error: function (xhr, status, error) {
                    alert("Error", error);
                }
            });
        }
    }

    let sal_name = "";

    let saleList = function (page=1,pageSize=10,addr_cd,tx_s_cd) {
        $.ajax({
            type:'GET',       // 요청 메서드
            url: "/sale/searchAddrCd?page=" + page + "&pageSize=" + pageSize + "&addr_cd=" + addr_cd + "&tx_s_cd=" + tx_s_cd,  // 요청 URI
            headers: {"content-type": "application/json"}, // 요청 헤더
            dataType : 'json',
            success : function(result){
                // 후기글 목록과 페이징 정보 가져오기
                let comments = result.comments;
                let ph = result.ph;
                $("#commentList").html(toHtml(comments,ph,sal_id));
                closeModal();
            },
            error   : function(result){ alert(result.responseText) } // 에러가 발생했을 때, 호출될 함수
        }); // $.ajax()
    }


    $(document).ready(function () {
        // 대분류 선택 전 메시지 설정
        $("#sal_name").text("전체");

        // 대분류 선택 시 중분류 메시지
        $("#category1").change(function () {
            $("#sal_name").text($("#category1 option:checked").text());
        });

        // 중분류 선택 시 소분류 메시지
        $("#category2").change(function () {
            $("#sal_name").text($("#category2 option:checked").text());
        });

        // 소분류 선택 시 메시지 제거
        $("#category3").change(function () {
            $("#sal_name").text($("#category3 option:checked").text());
        });


        // AddrCd 선택이 변경될 때마다 실행되는 함수
        $("#addr_cd").change(function () {
            // 선택된 AddrCd 값 가져오기
            let addr_cd = $(this).val();

            // 서버에 선택된 AddrCd 값을 전송하여 새로운 addrCdList 받아오기
            $.ajax({
                type: "GET",
                url: "/sale/search", // 새로운 addrCdList를 반환하는 URL로 변경해야 함
                dataType: "json",
                data: {addr_cd: addr_cd},
                success: function (data) {
                    // startOfToday 값을 추출
                    let startOfToday = data.startOfToday;
                    // 판매 목록 업데이트 함수 호출 시 startOfToday 값을 함께 전달
                    updateSaleList(data.saleList, startOfToday);
                },
                error: function (xhr, status, error) {
                    console.error("Error:", error);
                }
            });
        });
    });

    function writeBtn() {
        // 선택된 주소 코드(addr_cd) 값 가져오기
        let addrCdValue = $('#addr_cd').val();

        // form 엘리먼트 생성
        let form = $('<form>', {
            method: 'POST', // POST 방식 설정
            action: '/sale/write' // 전송할 URL 설정
        });

        // hidden input 엘리먼트 생성
        $('<input>').attr({
            type: 'hidden',
            name: 'addr_cd',
            value: addrCdValue
        }).appendTo(form);

        // form을 body에 추가하고 자동으로 submit
        form.appendTo('body').submit();
    }

    // 업데이트된 saleList를 화면에 출력하는 함수
    function updateSaleList(saleList, startOfToday) {
        // 기존 saleList 테이블의 tbody를 선택하여 내용을 비웁니다.
        $("#saleList").empty();
        if (saleList.length > 0) {
            saleList.forEach(function (sale) {
                let row = $("<tr>");
                row.append($("<td>").text(sale.no)); // 판매 번호
                row.append($("<td>").addClass("title").html("<a href='/sale/read?no=" + sale.no + "'>" + sale.title + "</a>")); // 제목
                row.append($("<td>").text(sale.seller_nick)); // 판매자 닉네임
                row.append($("<td>").text(sale.addr_name)); // 주소명

                let saleDate = new Date(sale.r_date);
                let regdate;
                if (saleDate.getTime() >= startOfToday) {
                    regdate = $("<td>").addClass("regdate").text(formatDate(saleDate, "HH:mm"));
                } else {
                    regdate = $("<td>").addClass("regdate").text(formatDate(saleDate, "yyyy-MM-dd"));
                }

                row.append(regdate);
                row.append($("<td>").text(sale.view_cnt)); // 조회수
                $("#saleList").append(row);
            });
        } else {
            $("#saleList").append("<tr><td colspan='5'>데이터가 없습니다.</td></tr>");
        }
    };

    // 날짜 형식을 변환하는 함수
    function formatDate(date, format) {
        // 현재는 간단히 예시로만 구현한 함수입니다. 실제로는 더 복잡한 로직이 필요할 수 있습니다.
        return date.toLocaleString();
    }


</script>

</html>