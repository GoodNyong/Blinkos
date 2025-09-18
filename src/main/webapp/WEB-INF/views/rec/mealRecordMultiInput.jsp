<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
<link rel="stylesheet" href="${ctp}/resources/css/helper_wizard.css" />
<script src="${ctp}/resources/js/helper_wizard.js" defer></script>

<main class="container my-5" data-page="mealRecordMultiInput">
	<h2 class="mb-4">🍱 다중 식단 기록 입력</h2>
	<p class="text-muted">다양한 식단을 한 번에 마법처럼 입력해보세요.</p>

	<form method="post" action="${ctp}/rec/mealRecordMultiInput" id="multiForm" novalidate>
		<div class="table-responsive shadow rounded-4 border border-2 border-light overflow-hidden">
			<table class="table align-middle text-center m-0" id="recordTable">
				<thead class="table-light">
					<tr class="table-info">
						<th>음식</th>
						<th>시간대</th>
						<th>섭취량</th>
						<th>날짜</th>
						<th>🪄</th>
					</tr>
				</thead>
				<tbody id="recordTableBody" class="table-group-divider">
					<!-- JS 행 추가 영역 -->
				</tbody>
			</table>
		</div>

		<div class="d-flex justify-content-between my-3">
			<button type="button" class="btn btn-outline-success" onclick="addRow()">➕ 행 추가</button>
			<button type="submit" class="btn btn-primary">✅ 전체 저장</button>
		</div>
	</form>

	<div class="mt-4 text-center">
		<a href="${ctp}/user/main" class="btn btn-outline-primary">🏠 메인으로 돌아가기</a>
		<a href="${ctp}/rec/mealRecordList" class="btn btn-outline-secondary">← 식단 기록 목록으로</a>
	</div>

	<!-- 마법사 -->
	<div class="text-center mt-5">
		<jsp:include page="/WEB-INF/views/include/helper_wizard.jsp" />
	</div>
</main>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
var loginUserId = "${sessionScope.sUser.user_id}";

function getRowIndex() {
	return document.querySelectorAll('#recordTableBody tr').length;
}

function addRow() {
	const tbody = document.getElementById("recordTableBody");
	const index = getRowIndex();

	const tr = document.createElement("tr");
	tr.innerHTML =
		'<td>' +
			'<select name="mealRecordList[' + index + '].food_id" class="form-select" required>' +
				'<option value="">선택</option>' +
				'<option value="1">밥</option>' +
				'<option value="2">닭가슴살</option>' +
				'<option value="3">샐러드</option>' +
				'<option value="4">라면</option>' +
			'</select>' +
			'<input type="hidden" name="mealRecordList[' + index + '].user_id" value="' + loginUserId + '" />' +
			'<input type="hidden" name="mealRecordList[' + index + '].quantity" id="quantity' + index + '" />' +
		'</td>' +

		'<td>' +
			'<select name="mealRecordList[' + index + '].meal_time" class="form-select" required>' +
				'<option value="">시간대</option>' +
				'<option value="1">아침</option>' +
				'<option value="2">점심</option>' +
				'<option value="3">저녁</option>' +
				'<option value="4">간식</option>' +
			'</select>' +
		'</td>' +

		'<td>' +
			'<div class="input-group">' +
				'<input type="number" class="form-control" step="0.1" min="0.1" id="amount' + index + '" required />' +
				'<select class="form-select" id="unit' + index + '" required>' +
					'<option value="">단위</option>' +
					'<option value="g">g</option>' +
					'<option value="ml">ml</option>' +
					'<option value="컵">컵</option>' +
					'<option value="개">개</option>' +
					'<option value="공기">공기</option>' +
					'<option value="조각">조각</option>' +
				'</select>' +
			'</div>' +
		'</td>' +

		'<td>' +
			'<input type="date" name="mealRecordList[' + index + '].meal_date" class="form-control" value="' + getToday() + '" required />' +
		'</td>' +

		'<td>' +
			'<button type="button" class="btn btn-outline-danger btn-sm" onclick="removeRow(this)">🗑 삭제</button>' +
		'</td>';

	tbody.appendChild(tr);
	showWizardMessage("🍱 식단 입력 행이 추가되었어요!");
}

function removeRow(button) {
	const row = button.closest("tr");
	row.remove();

	const rows = document.querySelectorAll("#recordTableBody tr");
	rows.forEach((tr, i) => {
		tr.querySelectorAll("input, select").forEach(el => {
			el.name = el.name.replace(/mealRecordList\[\d+\]/, "mealRecordList[" + i + "]");
			if (el.id) el.id = el.id.replace(/\d+/, i);
		});
	});
	showWizardMessage("🥄 밥이 어디갔지...?");
}

function getToday() {
	const today = new Date();
	return today.toISOString().slice(0, 10);
}

document.addEventListener("DOMContentLoaded", function () {
	addRow(); // 기본 1행

	const form = document.getElementById("multiForm");
	form.addEventListener("submit", function (e) {
		const rows = document.querySelectorAll("#recordTableBody tr");

		rows.forEach((tr, i) => {
			const amount = tr.querySelector("#amount" + i).value.trim();
			const unit = tr.querySelector("#unit" + i).value;
			const quantityInput = tr.querySelector("#quantity" + i);

			if (amount && unit) {
				quantityInput.value = amount + unit;
			} else {
				quantityInput.value = "";
			}
		});

		if (!validateFormOnSubmit(form)) {
			e.preventDefault();
			return;
		}
	});
});
</script>
