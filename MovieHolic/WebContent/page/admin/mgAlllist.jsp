<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ap" value="${requestScope.ap}" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>


<table id="table1" class="table"
	style="border-bottom: 0.2em solid #fff;">
	<br>
	<thead>
		<tr>
			<th>
				<span class="allcheckbox"><button type="button"
						class="btn btn-success" style="z-index: 0;">전체선택</button></span>
			</th>
			<th>회원ID</th>
			<th>이름</th>
			<th>주민번호 앞자리</th>
			<th>연락처</th>
			<th>성별</th>
			<th>가입일</th>
			<th>탈퇴일</th>
			<th>휴면여부</th>
		</tr>
	</thead>
	<tbody>

		<c:forEach var="ap" items='${ap.list}'>
			<tr>
				<td><c:if test="${ap.outdate == null}">
						<input type="checkbox" class="ap_checkbox" name="ap_checkbox"
							value="${ap.userId}" />
					</c:if></td>
				<td>${ap.userId}</td>
				<td>${ap.name }</td>
				<td>${ap.birth }</td>
				<td>${ap.phoneFirst }-${ap.phoneMid }-${ap.phoneLast }</td>
				<td>${ap.gender }</td>
				<td>${ap.joinDate }</td>
				<td>${ap.outdate }</td>
				<td>





					<div>

						<button type="button" class="btn btn-success dropdown-toggle"
							data-toggle="dropdown">
							<c:if test="${ap.enable == 1}">휴면</c:if>
							<c:if test="${ap.enable == 0}">활동</c:if>
						</button>


						<div class="dropdown-menu">
							<span class="enable"> <a class="dropdown-item"
								href="/MovieHolic/admin?act=enable&ap_userId=${ap.userId}">
									<c:if test="${ap.enable == 1}">활동</c:if> <c:if
										test="${ap.enable == 0}">휴면</c:if>
							</a>
							</span>
						</div>

					</div>





				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>



<div class="row">

	<div class="col-lg-2">


		<c:if test="${ap.startPage > 1 }">
			<span class="page"> <a href="${ap.startPage - 1}"><button
						class="btn btn-success">이전</button></a>
			</span>

		</c:if>


	</div>


	<div class="col-lg-2"></div>

	<div class="col-lg-4">
		<ul class="pagination"
			style="width: 240px; margin-left: auto; margin-right: auto;">

			<c:forEach begin="${ap.startPage}" end="${ap.endPage}" var="i">
				<c:choose>

					<c:when test="${ap.currentPage == i}">
						<li class="page-item"><span><a class="page-link">${i}</a></span></li>
					</c:when>

					<c:otherwise>
						<li class="page-item"><span class="page"><a
								class="page-link" href="${i}">${i}</a></span></li>
					</c:otherwise>

				</c:choose>
			</c:forEach>

		</ul>
	</div>



	<div class="col-lg-2"></div>





	<div class="col-lg-2">

		<c:if test="${ap.totalPage > ap.endPage }">

			<span class="page"> <a href="${ap.endPage+1}"><button
						class="btn btn-success">다음</button></a>
			</span>

		</c:if>

	</div>


</div>
