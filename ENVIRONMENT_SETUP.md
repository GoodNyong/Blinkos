# 🔧 환경변수 설정 가이드

## 📋 개요
이 프로젝트는 보안을 위해 민감한 정보를 환경변수로 관리합니다.

## 🔑 필요한 환경변수

| 변수명 | 설명 | 예시값 |
|--------|------|--------|
| `DB_USERNAME` | 데이터베이스 사용자명 | root |
| `DB_PASSWORD` | 데이터베이스 비밀번호 | your_db_password |
| `MAIL_USERNAME` | 메일 발송용 계정 | your_email@gmail.com |
| `MAIL_PASSWORD` | 메일 앱 비밀번호 | your_app_password |
| `RECAPTCHA_SECRET` | reCAPTCHA 비밀키 | your_recaptcha_secret |
| `ARIA_PRIVATE_KEY` | ARIA 암호화 키 | your_encryption_key |

## 🚀 설정 방법

### 방법 1: .env 파일 사용 (권장)

1. 프로젝트 루트에 `.env` 파일 생성:
```bash
# .env
DB_USERNAME=root
DB_PASSWORD=your_password
MAIL_USERNAME=your_email@gmail.com
MAIL_PASSWORD=your_app_password
RECAPTCHA_SECRET=your_recaptcha_secret
ARIA_PRIVATE_KEY=your_encryption_key
```

2. Spring Boot에서 자동 로드되도록 설정 (이미 적용됨)

### 방법 2: IDE에서 설정

#### Eclipse/STS
1. 프로젝트 우클릭 → `Run As` → `Run Configurations`
2. `Environment` 탭 클릭
3. `New` 버튼으로 각 환경변수 추가

#### IntelliJ IDEA
1. `Run` → `Edit Configurations`
2. `Environment variables` 필드에 값 입력
3. 세미콜론(;)으로 구분하여 입력

### 방법 3: 시스템 환경변수

#### Windows
```cmd
setx DB_USERNAME "root"
setx DB_PASSWORD "your_password"
setx MAIL_USERNAME "your_email@gmail.com"
setx MAIL_PASSWORD "your_app_password"
setx RECAPTCHA_SECRET "your_recaptcha_secret"
setx ARIA_PRIVATE_KEY "your_encryption_key"
```

#### Linux/macOS
```bash
export DB_USERNAME="root"
export DB_PASSWORD="your_password"
export MAIL_USERNAME="your_email@gmail.com"
export MAIL_PASSWORD="your_app_password"
export RECAPTCHA_SECRET="your_recaptcha_secret"
export ARIA_PRIVATE_KEY="your_encryption_key"
```

## 📧 Gmail 앱 비밀번호 생성 방법

1. Gmail 계정 → 보안 설정
2. 2단계 인증 활성화 (필수)
3. 앱 비밀번호 생성
4. 생성된 16자리 비밀번호를 `MAIL_PASSWORD`에 사용

## 🔐 reCAPTCHA 설정 방법

1. [Google reCAPTCHA](https://www.google.com/recaptcha/admin) 접속
2. 새 사이트 등록
3. 도메인 설정 (localhost:8080 포함)
4. 발급받은 Secret Key를 `RECAPTCHA_SECRET`에 사용

## ✅ 설정 확인 방법

1. 애플리케이션 시작
2. 로그에서 다음 확인:
   - 데이터베이스 연결 성공
   - Bean 생성 오류 없음
3. 기능 테스트:
   - 로그인/회원가입
   - 메일 발송
   - reCAPTCHA 동작

## ⚠️ 주의사항

- **절대 실제 값을 코드에 하드코딩하지 마세요**
- **.env 파일은 .gitignore에 포함되어 GitHub에 업로드되지 않습니다**
- **팀원과 공유시 안전한 채널을 사용하세요**
- **운영환경에서는 더 강력한 보안 정책을 적용하세요**

## 🔍 문제 해결

### 환경변수를 찾을 수 없음
- 환경변수 이름 정확성 확인
- 애플리케이션 재시작
- IDE 재시작

### 데이터베이스 연결 실패
- MySQL 서버 실행 상태 확인
- 사용자명/비밀번호 정확성 확인
- 데이터베이스 존재 여부 확인

### 메일 발송 실패
- Gmail 앱 비밀번호 사용 확인
- 2단계 인증 활성화 확인
- 계정 보안 설정 확인