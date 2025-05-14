# Flutter Dock iOS

Flutter 프로젝트를 Docker를 사용해 빌드할때, 필요한 ios 설정들을 자동으로 적용되도록 도와주는 도구입니다.



## Project Structure

```
flutter-dock-ios/
├── docker/
│   ├── config.json
│   └── Dockerfile
├── build_runner.sh
└── README.md
```

### docker/config.json
ios 빌드를 위한 설정 파일입니다.

```json
{
    "scheme": "Runner", // Runner.xcodeproj 파일의 이름
    "configuration": "Release", // Release or Debug
    "certificate": "dist_cert.p12", // p12 파일의 이름
    "certificate_password": "", // p12 파일의 비밀번호
    "provisioningProfile": "dist_profile.mobileprovision" // profile.mobileprovision 파일 이름
}
```

#### p12 파일 생성

`.p12` 파일은 **개발자의 개인 키와 인증서**를 하나로 묶은 패키지이며, iOS 앱을 서명할 때 필수적으로 사용됩니다.

빌드 종류에 따라 내보내야할 인증서가 달라집니다.

| 상황 | 인증서 종류 | 예시 |
|------|-------------|------|
| 개발 협업 (디버깅, 실기기 테스트) | Apple Development | `flutter run` 가능 |
| 릴리즈 빌드 및 TestFlight 업로드 | Apple Distribution | `flutter build ios` 가능 |

1. Mac OS의 Keychain Access를 실행.
2. 좌측 메뉴의 `login` 선택
3. 컨텐츠 상단의 `인증서` 선택
4. 아래 인증서 중 하나 선택
    - 개발용 : Apple Development
    - 릴리즈용 : Apple Distribution
> 🔒 **중요:** 인증서를 펼쳤을 때 아래에 **"개인 키"**(🔑 아이콘)가 함께 있어야 `.p12`로 내보낼 수 있습니다!

5. 인증서를 우클릭하고 `Export` 버튼을 눌러 `.p12` 파일로 내보냅니다.
    - 파일 포맷: **Personal Information Exchange (.p12)** 선택
    - 파일명
        - 개발용 : `dist_cert.p12`
        - 릴리즈용 : `dist_cert.p12`

6. `Export` 버튼을 눌러 `.p12` 파일로 내보냅니다.
7. p12 파일을 프로젝트에 복사
    - `flutter-dock-ios/docker/certs/`

> 🐳 **Recommand**  
> `.p12` 파일은 개인 키가 포함된 민감한 파일이므로,  
> `docker/certs/`로 복사한 뒤에도 **원본 파일은 안전한 곳에 따로 보관**하는 것을 권장합니다.

#### provisioningProfile 생성

`provisioningProfile` 필드에는 **Apple Developer 계정에서 다운로드한 `.mobileprovision` 파일의 이름**을 입력해야 합니다.

1. [Apple Developer Portal](https://developer.apple.com/account/resources/profiles/list)에서 자신의 팀, App ID에 맞는 프로파일 생성
2. `.mobileprovision` 파일 다운로드
3. `docker/certs/` 폴더에 복사
4. config.json에 파일명 입력

```json
"provisioningProfile": "dist_profile.mobileprovision"