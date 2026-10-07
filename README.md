# 커네버 Conever

여행 일정을 만들고, 당일 여행 코스와 사진 기록을 관리하는 Flutter 기반 모바일 앱입니다. 카카오 로그인, 네이버 지도, Firebase Cloud Messaging, 여행지 추천 WebSocket, 사진 업로드와 네컷 이미지 저장 기능을 포함합니다.

## 주요 기능

- 카카오 계정 로그인 및 테스트 계정 로그인
- 개인정보 수집 동의 여부에 따른 초기 라우팅
- 오늘의 여행 일정 조회, 장소별 진행률과 사진 관리
- 여행 일정 생성, 수정, 삭제, 동행자 추가
- AI 추천 기반 여행지 선택 및 사용자 직접 장소 추가
- 카카오 로컬 검색 기반 장소 검색
- 여행 사진 업로드, 삭제, 앨범 조회
- 여행 사진으로 네컷 이미지 생성 및 저장
- Firebase FCM 푸시 알림 수신
- `conever://snapshot` 딥링크로 스냅샷 상세 화면 이동

## 기술 스택

- Flutter / Dart
- GetX: 상태 관리와 라우팅
- Dio: REST API 통신
- WebSocket Channel: 여행지 추천 실시간 통신
- Kakao Flutter SDK: 카카오 로그인 및 로컬 API 연동
- Flutter Naver Map: 네이버 지도 SDK
- Firebase Core / Firebase Messaging: 푸시 알림
- Flutter Local Notifications: 앱 내부 로컬 알림
- Flutter Secure Storage: 토큰과 동의 여부 저장
- Image Picker / Image Gallery Saver: 사진 선택과 저장

## 프로젝트 구조

```text
lib/
├── components/          # 공통 UI 컴포넌트
├── controllers/         # GetX 컨트롤러
├── helper/              # 데이터 가공, 투어/사용자 보조 함수
├── pages/               # 화면 단위 UI
│   ├── add_page/        # 여행 추가, AI 추천, 직접 장소 추가
│   ├── home_page/       # 오늘의 여행
│   ├── login_page/      # 온보딩, 로그인, 개인정보 동의
│   ├── my_page/         # 마이페이지, 앨범, 네컷
│   └── plan_page/       # 여행 계획 목록과 상세
├── services/            # REST API, WebSocket, 토큰, 예외 처리
├── init_controllers.dart
├── main.dart
└── splash_router.dart
```

## 실행 환경

- Flutter SDK
- Dart SDK `^3.7.2`
- Android Studio 또는 Xcode
- Firebase 프로젝트 설정
- Kakao Developers 앱 설정
- Naver Cloud Platform Maps API 설정

## 환경 변수

루트 경로에 `.env` 파일을 만들고 아래 값을 채웁니다.

```env
KAKAO_NATIVE_APP_KEY=your_kakao_native_app_key
KAKAO_JAVA_SCRIPT_APP_KEY=your_kakao_javascript_app_key
KAKAO_REST_KEY=your_kakao_rest_api_key
NAVER_DYNAMIC_MAP=your_naver_map_client_id
```

`.env`는 `pubspec.yaml`의 assets에 등록되어 있으므로 앱 실행 전에 반드시 존재해야 합니다.

## Firebase 설정

Android는 `android/app/google-services.json` 파일을 사용합니다.

iOS에서 실행하려면 Firebase 콘솔에서 받은 `GoogleService-Info.plist`를 `ios/Runner/` 아래에 추가하고 Xcode Runner 타깃에 포함합니다.

## 설치 및 실행

```bash
flutter pub get
flutter run
```

iOS 의존성 갱신이 필요하면 아래 명령을 추가로 실행합니다.

```bash
cd ios
pod install
```

## 빌드

Android APK:

```bash
