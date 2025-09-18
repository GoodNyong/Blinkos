<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
<link rel="stylesheet" href="${ctp}/resources/css/helper_wizard.css" />
<script src="${ctp}/resources/js/helper_wizard.js" defer></script>

<main class="container mt-4 mb-5" data-page="goalMeal">
	<div class="mb-4">
		<h2>식단 목표 설정</h2>
		<p class="text-muted">오늘부터 목표 섭취를 시작해볼까요?</p>
	</div>

	<div class="row">
		<div class="col-md-6">
			<form method="post" action="${ctp}/rec/goalInputNutritionOk" class="needs-validation" novalidate>
				<input type="hidden" name="user_id" value="${sessionScope.sUser.user_id}" />
				<input type="hidden" name="set_by" value="1" />

				<!-- 목표 유형 -->
				<div class="mb-3">
					<label for="goal_type" class="form-label">목표 유형</label>
					<select name="goal_type" id="goal_type" class="form-select" required>
						<option value="">유형 선택</option>
						<option value="1">영양소 기준</option>
						<option value="2">식품 기준</option>
					</select>
				</div>

				<!-- 영양소 목표 -->
				<div class="mb-3 d-none" id="nutrient-section">
					<label for="nutrient_id" class="form-label">영양소 선택</label>
					<select name="nutrient_id" id="nutrient_id" class="form-select">
						<option value="">영양소를 선택하세요</option>
						<c:forEach var="nutrient" items="${nutrientList}">
							<option value="${nutrient.id}"
								data-unit-code="${nutrient.goalUnitCode}"
								data-unit-label="${nutrient.goalUnitEnum.label}">
								${nutrient.name} (${nutrient.goalUnitEnum.label})
							</option>
						</c:forEach>
					</select>
				</div>

				<!-- 식품 목표 -->
				<div class="mb-3 d-none" id="food-section">
					<label for="food_id" class="form-label">식품 선택</label>
					<select name="food_id" id="food_id" class="form-select">
						<option value="">식품을 선택하세요</option>
						<c:forEach var="food" items="${foodList}">
							<option value="${food.food_id}">${food.name}</option>
						</c:forEach>
					</select>

				</div>

				<!-- 목표 수치 + 단위 -->
				<div class="mb-3">
					<label class="form-label">목표 수치</label>
					<div class="input-group">
						<input type="number" id="target_value" name="target_value" class="form-control" placeholder="예: 150" step="0.1" min="0.1" required />
						<select name="goal_unit" class="form-select" required>
							<option value="">단위 선택</option>
						</select>
					</div>
				</div>

				<!-- 목표 기간 -->
				<div class="mb-3">
					<label for="start_date" class="form-label">시작일</label>
					<input type="date" name="start_date" id="start_date" class="form-control" required />
				</div>

				<div class="mb-4">
					<label for="end_date" class="form-label">종료일</label>
					<input type="date" name="end_date" id="end_date" class="form-control" required />
				</div>

				<div class="d-grid gap-2">
					<button type="submit" class="btn btn-primary btn-lg">목표 저장</button>
				</div>
			</form>

			<div class="mt-4 mb-4 text-center">
				<a href="${ctp}/user/main" class="btn btn-outline-primary">🏠 메인으로 돌아가기</a>
				<a href="${ctp}/rec/goalListNutrition" class="btn btn-outline-secondary">← 목표 목록으로</a>
			</div>
		</div>

		<div class="col-md-6 text-center">
			<jsp:include page="/WEB-INF/views/include/helper_wizard.jsp" />
		</div>
	</div>
</main>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
document.addEventListener("DOMContentLoaded", function () {
	const goalType = document.getElementById("goal_type");
	const nutrientSection = document.getElementById("nutrient-section");
	const foodSection = document.getElementById("food-section");
	const nutrientSelect = document.getElementById("nutrient_id");
	const goalUnitSelect = document.querySelector("select[name='goal_unit']");

	// GoalUnitEnum 기준 코드값 사용
	const foodUnitOptions = [
		{ code: 31, label: "g" },
		{ code: 32, label: "ml" },
		{ code: 34, label: "컵" },
		{ code: 33, label: "개" },
		{ code: 35, label: "공기" },
		{ code: 36, label: "조각" }
	];
	
	// 목표 유형 선택 시 영역 전환
	goalType.addEventListener("change", function () {
		const val = this.value;
		nutrientSection.classList.toggle("d-none", val !== "1");
		foodSection.classList.toggle("d-none", val !== "2");
		
		// 단위 초기화
		goalUnitSelect.innerHTML = "<option value=''>단위 선택</option>";
		
		// 식품 기준일 경우 단위 목록 직접 구성
		if (val === "2") {
			// 변경 후 append 방식
			foodUnitOptions.forEach(function (opt) {
				const option = document.createElement("option");
				option.value = opt.code; // ⬅️ 코드값으로 전송
				option.textContent = opt.label;
				goalUnitSelect.appendChild(option);
			});
		}
	});
	
	// 영양소 선택 시 단위 자동 지정
	nutrientSelect.addEventListener("change", function () {
		if (goalType.value !== "1") return;

		const selectedOption = nutrientSelect.options[nutrientSelect.selectedIndex];
		const unitCode = selectedOption.getAttribute("data-unit-code");
		const unitLabel = selectedOption.getAttribute("data-unit-label");

		goalUnitSelect.innerHTML = "<option value=''>단위 선택</option>";

		if (unitCode && unitLabel) {
			const option = document.createElement("option");
			option.value = unitCode;
			option.textContent = unitLabel;
			option.selected = true;
			goalUnitSelect.appendChild(option);
		}
	});
});
</script>
