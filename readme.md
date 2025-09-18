# 🏃‍♂️ Blinkos - 건강 관리 웹 애플리케이션

Blinkos는 사용자가 자신의 건강을 체계적으로 관리하고, 다른 사용자들과 소통하며 동기를 부여받을 수 있는 종합 건강 관리 웹 애플리케이션입니다.

## ✨ 주요 기능

### 🔐 사용자 관리
- **회원가입/로그인** - 이메일 인증을 통한 안전한 가입
- **비밀번호 찾기** - 이메일을 통한 비밀번호 재설정
- **회원정보 수정** - 개인정보 업데이트
- **회원탈퇴** - 계정 삭제

### 💪 건강 기록 관리
- **운동 기록** - 운동 종류, 시간, 강도 등 상세 기록
- **식단 기록** - 음식 섭취량, 칼로리 등 영양 정보 기록
- **목표 설정** - 개인별 운동/영양 목표 설정 및 관리
- **다중 입력** - 여러 항목 동시 입력 지원

### 👨‍👩‍👧‍👦 커뮤니티
- **게시판** - 자유게시판, 정보공유 등 다양한 카테고리
- **댓글 시스템** - 게시물에 대한 소통 기능
- **파일 업로드** - 이미지 첨부 지원

### 👮‍♂️ 관리자 기능
- **사용자 관리** - 회원 정보 조회 및 관리
- **게시물 관리** - 부적절한 게시물 관리
- **시스템 관리** - 전반적인 서비스 운영 관리

### 🎯 전문가 상담
- **피드백 요청** - 전문가에게 건강 관련 조언 요청

## 🛠️ 기술 스택

### Backend
- **Java 11**
- **Spring Framework 5.3.39** (보안 업데이트 적용)
- **Spring MVC** - 웹 프레임워크
- **Spring Security 4.2.3** - 보안 관리
- **MyBatis 3.5.16** - ORM 프레임워크
- **MySQL 8.0.33** - 데이터베이스
- **Logback 1.2.12** - 로깅 (log4j 대체)
- **Lombok 1.18.24** - 코드 간소화
- **Jackson 2.14.2+** - JSON 처리
- **Commons FileUpload 1.5** - 파일 업로드
- **JavaMail 1.4.7** - 이메일 전송
- **Hibernate Validator 6.2.0** - 서버 유효성 검사

### Frontend
- **JSP & JSTL** - 뷰 템플릿
- **HTML5, CSS3, JavaScript** - 프론트엔드
- **Bootstrap 5** - UI 프레임워크
- **CKEditor** - 리치 텍스트 에디터

### Build Tool
- **Maven** - 의존성 관리 및 빌드

## 🚀 시작하기

### 📋 사전 요구사항
- Java 11+
- MySQL 8.0+
- Maven 3.6+
- IDE (Eclipse/IntelliJ/VS Code)

### ⚙️ 환경 설정

1. **프로젝트 클론**
   ```bash
   git clone https://github.com/GoodNyong/springProject1.git
   cd springProject1
   ```

2. **환경변수 설정**
   - `ENVIRONMENT_SETUP.md` 파일 참조
   - 필요한 환경변수 설정:
     ```
     DB_USERNAME=your_db_username
     DB_PASSWORD=your_db_password
     MAIL_USERNAME=your_email@gmail.com
     MAIL_PASSWORD=your_app_password
     RECAPTCHA_SECRET=your_recaptcha_secret
     ARIA_PRIVATE_KEY=your_encryption_key
     ```

3. **데이터베이스 설정**
   ```sql
   CREATE DATABASE springproject1;
   ```

4. **프로젝트 실행**
   ```bash
   mvn clean install
   mvn spring-boot:run
   ```

5. **웹 브라우저에서 접속**
   ```
   http://localhost:8080
   ```

## 📂 프로젝트 구조

```
springProject1/
├── src/main/
│   ├── java/com/spring/springProject1/
│   │   ├── HomeController.java          # 메인 컨트롤러
│   │   ├── admin/                       # 👮‍♂️ 관리자 기능
│   │   ├── board/                       # 📝 게시판 기능
│   │   ├── common/                      # 🛠️ 공통 유틸리티
│   │   ├── expert/                      # 🎯 전문가 상담
│   │   ├── rec/                         # 💪 건강 기록 관리
│   │   └── user/                        # 🔐 사용자 관리
│   ├── resources/
│   │   ├── application.properties       # 환경변수 참조 설정
│   │   └── mappers/                     # MyBatis SQL 매퍼
│   └── webapp/WEB-INF/views/            # JSP 뷰 파일
├── .env.example                         # 환경변수 템플릿
├── .gitignore                          # Git 제외 설정
├── ENVIRONMENT_SETUP.md                # 환경설정 가이드
└── pom.xml                             # Maven 설정
```

## 🔒 보안 강화

- **환경변수 분리**: 민감한 정보를 환경변수로 관리
- **최신 라이브러리**: 보안 취약점이 해결된 최신 버전 사용
- **암호화**: 비밀번호 SHA256 암호화 저장
- **세션 관리**: 안전한 세션 관리 및 자동 로그아웃

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.

## 📞 문의

프로젝트 관련 문의사항이 있으시면 Issues를 통해 연락해 주세요.

---
⭐ 이 프로젝트가 도움이 되었다면 Star를 눌러주세요!
