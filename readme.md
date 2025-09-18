# Blinkos - 당신의 건강 비서

Blinkos는 사용자가 자신의 건강을 체계적으로 관리하고, 다른 사용자들과 소통하며 동기를 부여받을 수 있는 종합 건강 관리 웹 애플리케이션입니다.

## 🌟 주요 기능

- **💪 운동 및 식단 기록:** 매일의 운동과 식단을 간편하게 기록하고 관리할 수 있습니다.
- **🎯 목표 설정 및 관리:** 개인의 필요에 맞는 운동 및 영양 목표를 설정하고 달성도를 추적할 수 있습니다.
- **📊 대시보드 및 리포트:** 기록된 데이터를 바탕으로 일일 요약 및 목표 진행 상황을 시각적인 리포트로 확인하며 성취감을 느낄 수 있습니다.
- **👨‍👩‍👧‍👦 커뮤니티:** 자유게시판, 정보공유 등 다양한 카테고리의 게시판을 통해 다른 사용자들과 정보를 교환하고 소통할 수 있습니다.
- **🔐 사용자 관리:** 안전한 회원가입, 로그인, 정보 수정 및 비밀번호 찾기 기능을 제공합니다.
- **👮‍♂️ 관리자 기능:** 관리자는 사용자, 게시물 등을 관리할 수 있는 전용 페이지를 통해 서비스를 원활하게 운영할 수 있습니다.

## 🛠️ 기술 스택

### Backend
- Java 11
- Spring Framework (4.3.14.RELEASE)
- Spring MVC
- Spring Security
- MyBatis
- MySQL
- Lombok
- Jackson (JSON 처리)
- Commons FileUpload (파일 업로드)
- JavaMail (이메일 전송)
- Jsoup & Selenium (웹 크롤링)
- ZXing (QR Code 생성)
- Hibernate Validator (서버 유효성 검사)
- Quartz (스케줄링)

### Frontend
- JSP & JSTL
- HTML, CSS, JavaScript
- CKEditor (게시판 에디터)

### Build Tool
- Maven

## 📂 프로젝트 구조

```
springProject1
├── .settings/               # Eclipse IDE 설정
├── src/
│   ├── main/
│   │   ├── java/com/spring/springProject1/
│   │   │   ├── HomeController.java # 메인 컨트롤러
│   │   │   ├── ad/                   # 광고 관련 기능 (예: AdController.java)
│   │   │   ├── admin/                # 관리자 기능 (AdminController, AdminService, AdminServiceImpl, dao)
│   │   │   ├── api/                  # 외부 API 연동 (ApiController.java)
│   │   │   ├── board/                # 게시판 기능 (BoardController, BoardService, BoardServiceImpl, dao, 다수의 Vo 클래스)
│   │   │   ├── common/               # 공통 유틸, VO, 스케줄러, 암호화 등
│   │   │   ├── expert/               # 전문가 피드백 기능 (ExpertController.java)
│   │   │   ├── rec/                  # 건강 기록/추천 기능 (RecController, RecService, RecServiceImpl, dao, vo, wrapper)
│   │   │   └── user/                 # 사용자 관리 (UserController, UserService, UserServiceImpl, UserVo, dao)
│   │   ├── resources/
│   │   │   ├── application.properties # 애플리케이션 설정
│   │   │   ├── log4j.xml             # Log4j 로깅 설정
│   │   │   └── mappers/              # MyBatis 매퍼 XML (adminMapper, boardMapper, recMapper, userMapper)
│   │   └── webapp/
│   │       ├── resources/            # 정적 리소스 (css, js, img, ckeditor, data)
│   │       └── WEB-INF/
│   │           ├── spring/
│   │           │   ├── root-context.xml    # Spring 루트 컨텍스트 설정
│   │           │   └── appServlet/         # 서블릿 컨텍스트 설정 (servlet-context.xml, servlet-interceptor.xml)
│   │           ├── views/                # JSP 뷰 파일 (각 기능별 폴더로 구성)
│   │           │   ├── ad/
│   │           │   ├── admin/
│   │           │   ├── api/
│   │           │   ├── board/
│   │           │   ├── content/
│   │           │   ├── expert/
│   │           │   ├── include/          # 공통 JSP (header, footer, navbar)
│   │           │   ├── rec/
│   │           │   └── user/
│   │           └── web.xml               # 웹 애플리케이션 배포 서술자
│   └── test/                   # 테스트 코드
│       └── resources/
├── target/                    # 빌드 결과물
├── .classpath                 # Eclipse 클래스패스 설정
├── .project                   # Eclipse 프로젝트 설정
├── pom.xml                    # Maven 프로젝트 설정
└── readme.md                  # 프로젝트 소개 문서
```
