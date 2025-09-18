<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
<link rel="stylesheet" href="${ctp}/resources/css/helper_wizard.css" />
<script src="${ctp}/resources/js/helper_wizard.js" defer></script>

<main class="container mt-4 mb-5" data-page="mealRecordInput">
	<div class="mb-4">
		<h2>✏️ 식단 기록 수정</h2>
		<p class="text-muted">기존 식사 기록을 마법처럼 편집해보세요.</p>
	</div>

	<div class="row">
		<div class="col-md-6">
			<form method="post" action="${ctp}/rec/mealRecordEdit" class="needs-validation" novalidate>
				<input type="hidden" name="meal_id" value="${record.meal_id}" />
				<input type="hidden" name="user_id" value="${sessionScope.sUser.user_id}" />
				<input type="hidden" name="quantity" id="quantity_hidden" />

				<!-- 음식 선택 -->
				<div class="mb-3">
					<label for="food_id" class="form-label">음식 선택</label>
					<select name="food_id" id="food_id" class="form-select" required>
						<option value="">음식을 선택하세요</option>
						<option value="1" ${record.food_id == 1 ? 'selected' : ''}>밥</option>
						<option value="2" ${record.food_id == 2 ? 'selected' : ''}>닭가슴살</option>
						<option value="3" ${record.food_id == 3 ? 'selected' : ''}>샐러드</option>
						<option value="4" ${record.food_id == 4 ? 'selected' : ''}>라면</option>
					</select>
				</div>

				<!-- 시간대 -->
				<div class="mb-3">
					<label for="meal_time" class="form-label">식사 시간대</label>
					<select name="meal_time" id="meal_time" class="form-select" required>
						<option value="">시간대를 선택하세요</option>
						<option value="1" ${record.meal_time == 1 ? 'selected' : ''}>아침</option>
						<option value="2" ${record.meal_time == 2 ? 'selected' : ''}>점심</option>
						<option value="3" ${record.meal_time == 3 ? 'selected' : ''}>저녁</option>
						<option value="4" ${record.meal_time == 4 ? 'selected' : ''}>간식/기타</option>
					</select>
				</div>

				<!-- 수량 + 단위 분리 -->
				<c:set var="amount" value="${fn:replace(record.quantity, '[^0-9.]', '')}" />
				<c:set var="unit" value="${fn:replace(record.quantity, '[0-9.]', '')}" />

				<div class="mb-3">
					<label class="form-label">섭취량</label>
					<div class="input-group">
						<input type="number" name="amount" id="amount" class="form-control" step="0.1" min="0.1" value="${record.amount}" required />
						<select name="unit" id="unit" class="form-select" required>
							<option value="">단위 선택</option>
							<option value="g" ${record.unit == 'g' ? 'selected' : ''}>g</option>
							<option value="ml" ${record.unit == 'ml' ? 'selected' : ''}>ml</option>
							<option value="컵" ${record.unit == '컵' ? 'selected' : ''}>컵</option>
							<option value="개" ${record.unit == '개' ? 'selected' : ''}>개</option>
							<option value="공기" ${record.unit == '공기' ? 'selected' : ''}>공기</option>
							<option value="조각" ${record.unit == '조각' ? 'selected' : ''}>조각</option>
						</select>

					</div>
				</div>

				<!-- 날짜 -->
				<div class="mb-3">
					<label for="meal_date" class="form-label">식사 날짜</label>
					<fmt:formatDate var="dateStr" value="${record.meal_date}" pattern="yyyy-MM-dd" />
					<input type="date" name="meal_date" id="meal_date" class="form-control" value="${dateStr}" required />
				</div>

				<div class="d-grid gap-2">
					<button type="submit" class="btn btn-warning btn-lg">✅ 수정 저장</button>
				</div>
			</form>

			<div class="mt-4 mb-4 text-center">
				<a href="${ctp}/user/main" class="btn btn-outline-primary">🏠 메인으로 돌아가기</a>
				<a href="${ctp}/rec/mealRecordList" class="btn btn-outline-secondary">← 식단 기록 목록으로</a>
			</div>
		</div>

		<div class="col-md-6 text-center">
			<jsp:include page="/WEB-INF/views/include/helper_wizard.jsp" />
		</div>
	</div>
</main>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
document.querySelector('form').addEventListener('submit', function (e) {
	const amount = document.getElementById('amount').value.trim();
	const unit = document.getElementById('unit').value;
	const hidden = document.getElementById('quantity_hidden');

	if (amount === '' || unit === '') {
		showWizardMessage("섭취량과 단위를 모두 입력해 주세요!");
		e.preventDefault();
		return false;
	}
	hidden.value = amount + unit;
});
</script>
