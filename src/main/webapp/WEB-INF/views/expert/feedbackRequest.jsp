<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/navbar.jsp" />
<link rel="stylesheet" href="${ctp}/resources/css/helper_wizard.css" />
<script src="${ctp}/resources/js/helper_wizard.js" defer></script>

<main class="container mt-4 mb-5" data-page="feedbackRequest">
	<div class="mb-4">
		<h2>🧙 피드백 요청</h2>
		<p class="text-muted">생활 습관, 수면, 스트레스, 전반적인 건강 상태에 대해 전문가의 조언을 받아보세요.</p>
	</div>

	<form action="${ctp}/expert/feedbackSubmit" method="post" novalidate>
		<input type="hidden" name="is_paid" value="0" />

		<!-- 피드백 도메인 선택 -->
		<div class="mb-3">
			<label class="form-label">피드백 종류 선택</label> <select name="feedbackDomain" class="form-select" id="domainSelect" required>
				<option value="">피드백 분야를 선택해주세요</option>
				<option value="work">🏃 운동</option>
				<option value="meal">🍱 식단</option>
				<option value="health">🧠 건강 일반</option>
			</select>
		</div>
		
		<!-- 건강 리포트 요약 선택 (확장용 - 현재는 placeholder) -->
		<div class="mb-3" id="healthReportBox">
			<label class="form-label" for="healthReportId">참조할 건강 리포트 (선택)</label> <select name="healthReportId" id="healthReportId" class="form-select" disabled>
				<option value="">(준비중) 향후 리포트 선택 기능이 추가될 예정입니다</option>
			</select>
		</div>

		<!-- 전문 태그 필터 -->
		<div class="mb-3">
			<label class="form-label">전문 분야 선택</label>
			<select name="tag_id" class="form-select" required>
				<option value="">전문가 태그를 선택해주세요</option>
				<c:forEach var="tag" items="${specialtyTagList}">
					<option value="${tag.tag_id}">${tag.tag_name}</option>
				</c:forEach>
			</select>
		</div>

		<!-- 전문가 선택 -->
		<div class="mb-3">
			<label class="form-label">전문가 선택</label>
			<select name="expert_id" class="form-select" required>
				<option value="">전문가를 선택해주세요</option>
				<c:forEach var="expert" items="${expertList}">
					<option value="${expert.expert_id}">${expert.username} (${expert.professionLabel})</option>
				</c:forEach>
			</select>
		</div>

		<!-- 피드백 내용 -->
		<div class="mb-3">
			<label class="form-label">상담 내용 입력</label>
			<textarea name="content" class="form-control" rows="6" placeholder="궁금한 점이나 조언을 받고 싶은 내용을 입력해주세요." required></textarea>
		</div>

		<div class="text-center">
			<button type="submit" class="btn btn-primary">피드백 요청하기</button>
		</div>
		
		<!-- 유/무료 선택 -->
		<div class="mb-3">
			<label class="form-label">피드백 방식</label>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="is_paid" id="freeOption" value="0" checked />
				<label class="form-check-label" for="freeOption">무료 피드백 (기본 3회 제공)</label>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="is_paid" id="paidOption" value="1" />
				<label class="form-check-label" for="paidOption">유료 피드백 요청</label>
			</div>
		</div>
	</form>

	<div class="text-center mt-4">
		<a href="${ctp}/expert/feedbackRequest" class="btn btn-outline-secondary">🔙 이전으로</a>
	</div>

	<div class="text-center mt-4">
		<jsp:include page="/WEB-INF/views/include/helper_wizard.jsp" />
	</div>
</main>

<script>
document.addEventListener('DOMContentLoaded', function() {
	showWizardMessage("선생님! 날 보고있다면 정답을 알려줘~!!");
});
</script>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
