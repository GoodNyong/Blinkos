<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
<link rel="stylesheet" href="${ctp}/resources/css/helper_wizard.css" />
<script src="${ctp}/resources/js/helper_wizard.js" defer></script>

<main class="container my-5" data-page="exerciseRecordMultiInput">
	<h2 class="mb-4">✨ 다중 운동 기록 입력</h2>
	<p class="text-muted">1행에 1개씩 다양한 운동을 입력할 수 있어요.</p>

	<form method="post" action="${ctp}/rec/exerciseRecordMultiInput" id="multiForm" novalidate>
		<div class="table-responsive shadow rounded-4 border border-2 border-light overflow-hidden">
			<table class="table align-middle text-center m-0" id="recordTable">
				<thead class="table-light">
					<tr class="table-info">
						<th class="text-nowrap">운동 종류</th>
						<th class="text-nowrap">시간(분)</th>
						<th class="text-nowrap">칼로리</th>
						<th class="text-nowrap">날짜</th>
						<th class="text-nowrap">플랫폼</th>
						<th>🪄</th>
					</tr>
				</thead>
				<tbody id="recordTableBody" class="table-group-divider">
					<!-- JS 행 추가 영역 -->
				</tbody>
			</table>
		</div>


		<div class="d-flex justify-content-between my-3">
			<button type="button" class="btn btn-outline-primary" onclick="addRow()">➕ 행 추가</button>
			<button type="submit" class="btn btn-primary">✅ 전체 기록 저장</button>
		</div>
	</form>
	<div class="mt-4 mb-4 text-center">
		<a href="${ctp}/user/main" class="btn btn-outline-primary">🏠 메인으로 돌아가기</a>
		<a href="${ctp}/rec/exerciseRecordList" class="btn btn-outline-secondary">← 운동 기록 목록으로</a>
	</div>

	<!-- 마법사 영역 -->
	<div class="text-center mt-5">
		<jsp:include page="/WEB-INF/views/include/helper_wizard.jsp" />
	</div>
</main>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
var loginUserId = "${sessionScope.sUser.user_id}";
let rowIndex = 0;

function getRowIndex() {
	return document.querySelectorAll('#recordTableBody tr').length;
}

function addRow() {
	const tbody = document.getElementById("recordTableBody");
	const currentIndex = getRowIndex();

	const tr = document.createElement("tr");
	tr.innerHTML =
		'<td>' +
			'<select name="exerciseRecordList[' + currentIndex + '].exercise_id" class="form-select" required>' +
				'<option value="">선택</option>' +
				'<option value="1">걷기</option>' +
				'<option value="2">러닝</option>' +
				'<option value="3">사이클링</option>' +
				'<option value="4">근력 운동</option>' +
			'</select>' +
			/* '<input type="hidden" name="exerciseRecordList[' + currentIndex + '].user_id" value="' + loginUserId + '" />' + */
		'</td>' +
		'<td><input type="number" name="exerciseRecordList[' + currentIndex + '].duration_minutes" class="form-control" min="1" required /></td>' +
		'<td><input type="number" name="exerciseRecordList[' + currentIndex + '].calories_burned" class="form-control" min="0" required /></td>' +
		'<td><input type="date" name="exerciseRecordList[' + currentIndex + '].activity_date" class="form-control" value="' + getToday() + '" required /></td>' +
		'<td><input type="text" name="exerciseRecordList[' + currentIndex + '].source_platform" class="form-control" /></td>' +
		'<td>' +
			'<button type="button" class="btn btn-outline-danger btn-sm" onclick="removeRow(this)">🗑 삭제</button>' +
		'</td>';

	tbody.appendChild(tr);
	showWizardMessage("새로운 마법 기록 행이 나타났어요!");
}

function removeRow(button) {
	const row = button.closest("tr");
	row.remove();

	const rows = document.querySelectorAll("#recordTableBody tr");
	rows.forEach(function (tr, i) {
		tr.querySelectorAll("input, select").forEach(function (el) {
			el.name = el.name.replace(/exerciseRecordList\[\d+\]/, "exerciseRecordList[" + i + "]");
		});
	});

	showWizardMessage("마법의 흔적이 사라졌어요...");
}

function getToday() {
	const today = new Date();
	const yyyy = today.getFullYear();
	const mm = String(today.getMonth() + 1).padStart(2, '0');
	const dd = String(today.getDate()).padStart(2, '0');
	return yyyy + '-' + mm + '-' + dd;
}

document.addEventListener("DOMContentLoaded", function () {
	addRow(); // 기본 1행

	const form = document.getElementById("multiForm");
	form.addEventListener("submit", function (e) {
		e.preventDefault();
		if (validateFormOnSubmit(form)) {
			form.submit();
		}
	});
});
</script>