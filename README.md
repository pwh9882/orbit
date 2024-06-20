이 프로젝트는 객체지향분석및설계 과목의 프로젝트로 시작되었습니다.

# 최종프로젝트 결과 보고서

# 1. Project Team 구성

## 1.1. Team 인원 수

- 1명

## 1.2. 팀원 소개

- 이름: 박우혁
- 학번: 20203070
- 학부: 소프트웨어학부
- 업무경험: 없음
- 특징: 성실함

# 2. 추진하려는 Project

- **Project 명**: Orbit
- **대상 SW system의 명칭**: Cross-Platform Web Browser Inspired by Arc Browser

## 2-1. Project Vision

프로젝트의 시작점은 개인적인 경험에서 비롯되었습니다. 브라우저를 사용하며 항상 느꼈던 불편함은 바로 '탭 관리' 였습니다. 여러 플랫폼에서 업무와 개인 용도로 웹 브라우징을 하다 보니 수 백 개의 열려있는 탭 들을 효과적으로 관리하기 어려웠습니다. 다양한 브라우저 들을 사용해본 결과, Arc 브라우저의 탭 관리 기능이 저에 아주 매력적 이었습니다.

Arc 브라우저는 기존의 웹 브라우저와는 다르게, 탭 관리와 작업 공간을 Space라는 개념으로 재구성하여 제공합니다. 탭들은 사이드바에 정리되어 있으며, 작업 공간 개념을 도입함으로써 사용자는 자신의 업무, 취미 등을 위한 개별적인 공간을 생성할 수 있습니다. 이는 탭의 과부하를 방지하고, 더욱 집중된 웹 사용 경험을 가능하게 합니다.

하지만 Arc의 이러한 매력적인 기능은 macOS에서만 이용할 수 있었고, 이는 크로스 플랫폼 사용자인 저의 요구를 충족시키지 못했습니다. Arc 브라우저 제작사는 mac과 ios 외의 플랫폼에는 개발 의사가 적어 보였습니다. 그래서 제가 Flutter를 사용하여 Windows, Android, iOS, macOS 등 다양한 플랫폼에서 동일한 사용 경험을 제공하는 웹 브라우저를 개발하고자 합니다. 이를 통해 사용자들은 어떠한 기기에서도 일관된 탭 관리와 작업 공간의 이점을 누릴 수 있게 됩니다.

이 프로젝트의 궁극적인 목표는 사용자들이 다양한 환경에서 웹을 더욱 효율적으로 사용하고, 일상과 업무에서 웹 브라우징의 새로운 표준을 경험하게 하는 것입니다. Arc 브라우저의 혁신적인 아이디어를 바탕으로, 모든 플랫폼에서 뛰어난 탭 관리와 작업 공간 기능을 갖춘, 진정으로 통합된 웹 브라우징 경험을 제공하고자 합니다. 이는 단순한 소프트웨어 개발을 넘어서, 사용자들의 웹 사용 방식을 혁신하는 여정이 될 것입니다.

저는 개인 프로젝트로 이 어플의 초기 기술 조사와 함께 약간의 데모 어플을 만들었는데, 구조에 대한 큰 계획 없이 깊이 없이 개발을 무턱대고 하다보니 구조가 스파게티가 되는 한계를 겪었습니다. 이번 객체지향분석및설계 수업에서 배우는 프로젝트 설계 방법을 실제로 제가 사용할 어플을 만들기 위해 적용하면 좋지 않을까 생각하여 과제 프로젝트로 선정했습니다.

## 2-2. Project Scope

- **Arc 브라우저의 Tab management 구현하기**: Space, folder, tab을 통한 Sidebar tab 관리 시스템.
- **Tab의 클라우드 실시간 Sync 여부**: 로컬 sqlite를 이용해 데이터를 저장하고 필요하면 export, import하는 방식으로 제한하여 구현.
- **기본적인 주소창 구현**: Web browser가 기본적으로 가지는 검색 주소창 구현하기.
- **Tab에 따른 WebPage 로딩**: Web browser가 기본적으로 가지는 webview loading, pause, switch 기능 구현.

# 3. 기능적인 요구사항 (Functional Requirements) 도출하기

## 3.1 Use Case Specification: 주소창에 검색 또는 주소 입력으로 새 탭 열기

|                    |                                                                                                                                                       |        |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| Use case name      | 주소창에 검색 또는 주소 입력으로 새 탭 열기                                                                                                           |        |
| Scenario           | 사용자가 주소창에 웹사이트 주소나 검색어를 입력하여 새 탭에서 웹 페이지를 열고자 하는 경우                                                            |        |
| Triggering event   | 사용자가 브라우저의 주소창을 클릭하고 입력을 시작함                                                                                                   |        |
| Brief description  | 사용자가 주소창에 웹사이트의 URL이나 검색어를 입력하면, 시스템은 새 탭에서 해당 URL의 웹사이트를 열거나, 검색어에 대한 결과를 검색 엔진을 통해 보여줌 |        |
| Actors             | 사용자                                                                                                                                                |        |
| Related use cases  | -                                                                                                                                                     |        |
| Stakeholders       | 사용자                                                                                                                                                |        |
| Preconditions      | 브라우저가 정상적으로 실행되고 있어야 하며, 주소창이 사용자 입력을 받을 준비가 되어 있어야 함                                                         |        |
| Post conditions    | 새 탭이 생성되고, 입력된 URL의 웹사이트 또는 검색 결과가 표시됨. DB가 업데이트됨.                                                                     |        |
| Flow of activities | Actor                                                                                                                                                 | System |
|                    | 1. 사용자가 주소창을 클릭한다.                                                                                                                        |

2. 사용자가 웹사이트의 URL을 입력하거나 검색어를 입력한다. | <br><br>3. 시스템은 새 탭에서 해당 웹사이트를 열거나 검색 결과를 보여준다. |
   | Exception conditions | - 입력된 URL이 유효하지 않을 경우, 시스템은 오류 메시지를 표시한다. <br> - 검색어가 입력되었을 경우, 시스템은 검색 선호도에 따라 최적화된 결과를 제공한다. | |

## 3.2 Use Case Specification: 사이드바의 SpaceItem 조작하기 (Arc 브라우저 기반)

|                      |                                                                                                                                                                                                                                                    |                                                                                                                                                                                  |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Use case name        | 사이드바의 SpaceItem 조작하기 (Arc 브라우저 기반)                                                                                                                                                                                                  | 용어 설명: SpaceItem이란, 한 Space가 담고 있는 Folder, Tab등의 아이템들을 말함. Folder는 Folder와 Tab을 담을 수 있으며, Tab은 일반 브라우저에서 볼 수 있는 WebPage의 Tab과 같음. |
| Scenario             | 사용자가 사이드바를 사용하여 열린 SpaceItem들을 관리하고 빠르게 접근하고자 하는 경우                                                                                                                                                               |                                                                                                                                                                                  |
| Triggering event     | 사용자가 브라우저의 사이드바를 통해 SpaceItem을 관리하려 할 때                                                                                                                                                                                     |                                                                                                                                                                                  |
| Brief description    | 사용자는 사이드바를 통해 현재 열린 SpaceItem들을 보고, 원하는 탭을 선택하거나, 탭을 사이드바에 고정하거나, 자동으로 아카이브하도록 설정함                                                                                                          |                                                                                                                                                                                  |
| Actors               | 사용자                                                                                                                                                                                                                                             |                                                                                                                                                                                  |
| Related use cases    | -                                                                                                                                                                                                                                                  |                                                                                                                                                                                  |
| Stakeholders         | 사용자                                                                                                                                                                                                                                             |                                                                                                                                                                                  |
| Preconditions        | 브라우저가 정상적으로 실행되고 있어야 하며, 사이드바에 열린 탭들이 표시되어 있어야 함                                                                                                                                                              |                                                                                                                                                                                  |
| Post conditions      | 사용자가 조작한 SpaceItem 상태가 UI로 반영되며 DB가 업데이트 됨.                                                                                                                                                                                   |                                                                                                                                                                                  |
| Flow of activities   | Actor                                                                                                                                                                                                                                              | System                                                                                                                                                                           |
|                      | 1. 사용자가 사이드바를 열어 현재 열린 SpaceItem 목록을 확인한다.                                                                                                                                                                                   | 1.1 시스템은 사용자가 현재 전환한 Space의 SpaceItem 목록을 DB에서 불러와 사이드바에 표시한다.                                                                                    |
|                      | 2-1. 사용자는 원하는 SpaceItem을 선택하여 페이지로 이동하거나, 폴더를 열거나, SpaceItem을 삭제하거나 하는 조작을 한다.                                                                                                                             | 2-1.1 시스템은 사용자가 선택한 탭에 해당하는 페이지를 표시하는 등 해당하는 SpaceItem의 조작에 맞는 반응을 한다.                                                                  |
|                      | 2-2. 사용자가 탭을 사이드바에 고정하거나 아카이브 설정을 한다.                                                                                                                                                                                     | 2-2.1 시스템은 사용자의 설정에 따라 탭을 고정하거나 아카이브한다.                                                                                                                |
| Exception conditions | - 사용자가 너무 많은 탭을 열어 성능 저하가 발생할 경우, 시스템은 탭을 자동으로 아카이브하거나 사용자에게 탭 정리를 권장한다. <br> - 사용자가 탭을 고정하려 할 때, 고정할 수 있는 탭의 최대 수에 도달했다면 시스템은 알림을 통해 사용자에게 알린다. |                                                                                                                                                                                  |

## 3.3 Use Case Specification: 스페이스 관리하기

|                      |                                                                                                     |                                                                                   |
| -------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| Use case name        | 스페이스 관리하기                                                                                   |                                                                                   |
| Scenario             | 사용자가 스페이스를 관리(생성, 수정, 삭제)하고자 하는 경우.                                         |                                                                                   |
| Triggering event     | 사용자가 사이드바의 현재 스페이스를 수정하거나 새로운 스페이스를 생성한다.                          |                                                                                   |
| Brief description    | 사용자가 현재 Space의 정보를 수정하거나 새로운 Space를 생성한다.                                    |                                                                                   |
| Actors               | 사용자                                                                                              |                                                                                   |
| Related use cases    | -                                                                                                   |                                                                                   |
| Stakeholders         | 사용자                                                                                              |                                                                                   |
| Preconditions        | 사용자가 정의한 스페이스가 있어야 하며, 브라우저가 해당 스페이스들의 SpaceList를 보여주고 있어야함. |                                                                                   |
| Post conditions      | 사용자가 선택한 스페이스를 수정하거나 생성. DB가 업데이트됨.                                        |                                                                                   |
| Flow of activities   | Actor                                                                                               | System                                                                            |
|                      | 1. 사용자가 사이드바에 있는 스페이스 리스트를 클릭한다.                                             | -                                                                                 |
|                      | 2. 사용자는 필요에 따라 현재스페이스를 수정하거나 새 스페이스를 생성하거나 순서를 조작한다.         | 2.1 시스템은 새 스페이스를 생성하고, 사용자가 추가하거나 정리한 Space를 관리한다. |
| Exception conditions | - 유일하게 남은 Space를 삭제하려 시도하면 빈 Space를 자동으로 생성한다.                             |                                                                                   |

## 3.4 Use Case Specification: 스페이스 전환하기

## 3.5 UseCase Diagram 그리기

![UseCase Diagram0.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/4f109390-6c06-4352-9c65-61f758fef053/UseCase_Diagram0.png)

# 4. 비기능적인 요구 사항 (Non-Functional Requirements) 도출하기

| Use Case                                          | Non-Functional Requirement 내역                                                                                                                                                                                                | Quality       | Quality Attributes                                             |
| ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- | -------------------------------------------------------------- |
| 주소창에 검색 또는 주소 입력으로 새 탭 열기       | 웹 페이지 로딩 시간을 최소화한다.                                                                                                                                                                                              | Performance   | 웹 페이지는 사용자가 주소를 입력하고 나서 2초 이내에 로드된다. |
|                                                   | 브라우저는 입력된 값이 URL인지 검색값인지 잘 구분해야한다.                                                                                                                                                                     | Usability     | 90%이상의 분류 정확도를 가지도록 한다.                         |
| 사이드바의 SpaceItem 조작하기 (Arc 브라우저 기반) | 사용자 인터페이스는 직관적이고 반응이 빨라야 한다.                                                                                                                                                                             | Usability     |
| Performance                                       | 사용자는 탭 관리 기능으로 SpaceItem을 조작할때 사용자 인터랙션에 대한 UI의 평균 응답 시간은 50밀리초를 넘지 않아야 한다.(60fps(프레임 당 16.67ms)에서는 각 프레임 간의 지연이 50ms 미만으로 유지되어야 부드러운 움직임이 가능) |
| 스페이스 전환하기                                 | 스페이스 전환은 사용자 작업의 흐름을 방해하지 않도록 신속하게 이루어져야 한다.                                                                                                                                                 | Performance   |
| Efficiency                                        | 스페이스 전환은 1초 이내에 완료되어야 한다.                                                                                                                                                                                    |
| 공통                                              | 시스템은 다양한 사용자 환경을 지원하며 호환성을 유지해야 한다.                                                                                                                                                                 | Compatibility | 소프트웨어가 Android, IOS, Web 환경 3가지를 동시 지원한다.<br> |
| 공통                                              | DB로딩 시간을 최소화한다.                                                                                                                                                                                                      | Performance   |
| Efficiency                                        | DB 접근 시간은 1초 이내로 한다.                                                                                                                                                                                                |

# 5. Domain Model 분석 설계하기(7에서 수정됨)

| Class 명        | Concept 설명                                                                                                                   | 주요 attributes                                                                     |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------- |
| Browser         | 웹 브라우징을 주관하는 메인 애플리케이션 클래스                                                                                | spaces: 스페이스 목록currentSpace: 현재 활성 스페이스                               |
| Space           | 사용자의 작업공간을 나타내는 클래스, SpaceItem들을 포함                                                                        | id: 고유 식별자name: 이름items: SpaceItem 목록 (탭과 폴더)                          |
| SpaceItem       | 공간 내에서 관리되는 항목을 위한 추상 베이스 클래스                                                                            | id: 고유 식별자name: 항목 이름isActivated: 활성화 상태type: 항목 유형 (tab, folder) |
| Folder          | SpaceItem을 구현하여 여러 탭을 그룹화하는 클래스                                                                               | items: 포함된 SpaceItem 목록                                                        |
| Tab             | SpaceItem을 구현하여 개별 웹 페이지를 표시하는 클래스                                                                          | url: 웹 페이지 URL                                                                  |
| WebPage         | 실제 웹 페이지의 데이터와 상태를 관리하는 클래스(Flutter In App WebView를 이용)<https://pub.dev/packages/flutter_inappwebview> | inAppWebView: webview 객체progress: 로드 상태                                       |
| DatabaseManager | 애플리케이션의 데이터를 저장하고 관리하는 클래스                                                                               | \_database: 데이터베이스 연결 정보instance: 싱글톤구현 인스턴스                     |

# 6. Design Model 설계하기(7에서 수정됨)

## 6-1. System Sequence Diagram 그리기

## 6-2. Operation Contract 만들기

## SSD 결과: (좌측 SSD, 우측 Operation Contract)

![SSD_ 3.1 새 Tab 열기.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/d0f87972-01ff-4df5-8907-3609ab97b039/SSD__3.1_%E1%84%89%E1%85%A2_Tab_%E1%84%8B%E1%85%A7%E1%86%AF%E1%84%80%E1%85%B5.png)

![SSD_ 3.2 Space Item 조작.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/ab5e2473-37b3-4494-bbca-20b6bb0ac5ab/SSD__3.2_Space_Item_%E1%84%8C%E1%85%A9%E1%84%8C%E1%85%A1%E1%86%A8.png)

![SSD_ 3.3 Space 관리.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/6ff70d55-a6e7-4c42-89a9-4dbb32ab362f/SSD__3.3_Space_%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5.png)

![SSD_ 3.4 Space 전환.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/f2334ae7-cb48-401f-8106-1964c7cf25c7/SSD__3.4_Space_%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%92%E1%85%AA%E1%86%AB.png)

## 6-3. Sequence Diagram 설계하기

### 주요한 Use case 두 가지를 선택하여 Sequence Diagram을 설계하기

UseCase: 3.1 새 Tab 열기

![SD_ 3.1.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/125f898a-6a94-4530-a260-17fcab90902f/SD__3.1.png)

UseCase: 3.4 Space 전환

![SD_ 3.4.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/89feae09-bffd-411a-97d5-e3208ce2c519/SD__3.4.png)

## 6-4. Class Diagram 완성하기

![Class Diagram0.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/22b26e31-f7d6-4e66-a01b-3235bd7dfcd0/Class_Diagram0.png)

## 과제 4에서 수정된 다이어그램

![Class Diagram0.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/4f332a26-00cd-4563-9327-29aa4aba5cf1/Class_Diagram0.png)

## 과제 4 시연영상

<https://youtu.be/BBxi0ef5oso>

<https://www.youtube.com/watch?v=fETjLdwgFuU>

## 과제 4에서 시연된 SSD (유튜브 영상 챕터 참조)

![SSD_ 3.1 새 Tab 열기.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/b2b673fa-c474-4811-b471-ba2439d58cda/SSD__3.1_%E1%84%89%E1%85%A2_Tab_%E1%84%8B%E1%85%A7%E1%86%AF%E1%84%80%E1%85%B5.png)

![SSD_ 3.2 Space Item 조작.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/8485dca8-c8ed-473d-a543-ac1dc2c55f88/SSD__3.2_Space_Item_%E1%84%8C%E1%85%A9%E1%84%8C%E1%85%A1%E1%86%A8.png)

![SSD_ 3.3 Space 관리.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/f6a34dd3-a815-4322-8a90-c72cb85c3090/SSD__3.3_Space_%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5.png)

![SSD_ 3.4 Space 전환.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/c5458a77-b934-41b9-8e51-bc896fc3617f/SSD__3.4_Space_%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%92%E1%85%AA%E1%86%AB.png)

<aside>
💡 HW5 : THE FINAL PROJECT WITH OBJECT-ORIENTED ANALYSIS AND DESIGNS ↓↓↓

</aside>

# 7 .SW Design Pattern을 적용한 (after) Class Diagram

## 7-1. Design Refinement by GRASP Principles and design patterns

> Design Refinement 표

| Before 단계의 Class 등 설계 classifier | After 단계의 Class 등 설계 classifier | 적용한 설계 개념
(GRASP, Design Pattern 적용) | Architecture Design Rationale (본인이 생각하는 합리성 | NFR과 QA에 대한 영향 분석 |
| --- | --- | --- | --- | --- |
| Broswer | Broswer | Controller
Singleton
creator
observable | UI에서 model과 상호작용하는 입구 역할을 해서 모든 다른 model로 연결시켜준다. 하나만 존재하면 되므로 singleton, 여러 SpaceItemTreeNode를 생성하므로 Creator
Getx 라이브러리를 이용한 obs(observable) 을 사용하여 값이 변경되면 자동으로 UI에 전달되어 변경될 수 있도록 했다. | 싱글톤으로 인한 불필요한 메모리 재할당 감소 |
| WebviewTab | WebviewTabViewerController | Controller
Singleton
Expert | 브라우저 상태관리와 inappwebview의 Webview의 관리를 분리 시켜 높은 응집도를 가지도록 하기 위해 webview ui에 대한 contoller는 분리했다.
마찬가지로 하나만 있으면 되니 GetxService를 이용해 Singleton으로 구현했다. | 싱글톤으로 인한 불필요한 메모리 재할당 감소 |
| Space
SpaceItem | SpaceItemTreeNode | polymophism
Composite | 기존에는 Space와 Folder, Tab을 별개로 생각했으나, Tree 구조로 UI를 구성하기 위해 고민하면서 동시에 Composite 패턴도 배우게 되어 이를 구현하는 방식으로 트리구조를 저장하기 좋게 만들었다. | NFR에 미치는 영향은 적음 |
| DatabaseManger | SpaceItemDAO
DatabaseManager | singleton
Pure Fabrication | 기존에는 Space, Folder, Tab 각각이 db를 직접 부르는 방식이었으나 Pure Fabrication 패턴을 적용하고 위의 Composite Pattern으로 감싼 SpaceItem을 단일로 다루도록 해서 중복되는 코드를 줄였다. | 싱글톤으로 인한 불필요한 메모리 재할당 감소 |

## 7-2. Refinement 결과 수정된 Domain Model

| Class 명                   | Concept 설명                                                                                                                | 주요 attributes                                                   |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| Browser                    | 웹 브라우징을 주관하는 메인 애플리케이션 클래스⇒ 웹 브라우저 UI에서 Model 간의 상호작용을 담당하는 싱글톤 Controller 클래스 | spaces: 스페이스 목록currentSpaceIndex: 현재 활성 스페이스 인덱스 |
| SpaceItemTreeNode          | Composite Pattern을 활용한 Abstract class, Tree 구조를 사용하기 위해 구현됨.                                                | id: 고유 식별자name: 이름children: Composite 용 자식목록          |
| Space                      | 사용자의 작업공간을 나타내는 클래스, SpaceItemNode들을 포함하는 Composite                                                   | currentSeletedTab: 현재 Space에서 선택된 Tab                      |
| Folder                     | SpaceItemNode을 구현하여 여러 탭을 그룹화하는 클래스, SpaceItemNode들을 포함하는 Composite                                  | items: 포함된 SpaceItem 목록                                      |
| TabNode                    | SpaceItemNode을 구현하여 개별 웹 페이지를 표시하는 클래스                                                                   |
| Composite 패턴의 Leaf node | isActivated : 탭의 webviewTab이 존재하는지 여부                                                                             |

isSeleted : 현재 탭이 UI상에서 선택되었는지 여부
customTitle : 사용자가 지정한 탭 이름 |
| WebviewTabViewerController | 실제 웹 페이지의 데이터와 상태를 관리하는 싱글톤 컨트롤러 클래스(Flutter In App WebView를 이용)<https://pub.dev/packages/flutter_inappwebview> | webviewTabs: webviewTab들currentTabIndex: 현재 webview의 webviewTabs상의 인덱스
currentTabUrl: 현재 webviewTab이 로딩한 url
currentTabUrlHost: Host url |
| SpaceItemDAO | SpaceItemTreeNode을 DB에 저장하기 위한 싱글톤 Pure Fabrication 클래스 | |
| DatabaseManager | 애플리케이션의 데이터를 저장하고 관리하는 싱글톤 DB 클래스 | \_database: 데이터베이스 연결 정보instance: 싱글톤구현 인스턴스 |

## 7-3 Refinement 결과 수정된 Design Model

### 7-3-1 수정된 SSD

<aside>
💡 전체적으로 Observable Pattern을 적용하여 System으로 부터 Return 값을 받아오지 않아도 되게 변해서 SSD 로직이 간단해졌다.

</aside>

![SSD_ 3.1 새 Tab 열기.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/5d96f5da-6204-4db4-a77a-a5ffafe9113e/SSD__3.1_%E1%84%89%E1%85%A2_Tab_%E1%84%8B%E1%85%A7%E1%86%AF%E1%84%80%E1%85%B5.png)

![SSD_ 3.2 Space Item 조작.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/e4e5233a-f101-40f9-bf84-d53e51b879c9/SSD__3.2_Space_Item_%E1%84%8C%E1%85%A9%E1%84%8C%E1%85%A1%E1%86%A8.png)

![SSD_ 3.3 Space 관리.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/9edd5740-056b-47f0-9aac-02fe8d85b99a/SSD__3.3_Space_%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5.png)

![SSD_ 3.4 Space 전환.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/ae308380-965e-4273-a710-70ae9dec2c76/SSD__3.4_Space_%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%92%E1%85%AA%E1%86%AB.png)

### 7-3-2 수정된 세부 SD 2개

![SD_ 3.1.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/03e629b0-5dfd-4b26-9db6-0b5f2d9a8b42/SD__3.1.png)

![SD_ 3.4.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/63237749-e8e4-4e9f-a05a-fc11c795227f/SD__3.4.png)

### 7-3-3 수정된 최종 Class Diagram

![Class Diagram0.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/b88dc437-d6b1-4abd-a5b5-2951fd7b88a0/Class_Diagram0.png)

# 8. 구현 결과 Snapshot (영상 챕터 기능 참조!)

<aside>
💡 영상설명란의 timestamp를 확인하시면 각 부분이
어떤 UseCase와 NFR를 구현한 것인지 확인 가능합니다!!!!!

</aside>

![스크린샷 2024-06-18 오후 11.14.39.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/57fae1ae-57d9-42cb-9c1d-efc1c8544a88/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2024-06-18_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.14.39.png)

<aside>
💡 1. 구동시연 영상: Use Case와 NFR 반영 시연
Youtube 영상 챕터 기능으로 해당하는 UseCase시연을 찾을 수 있습니다.

</aside>

<https://youtu.be/zvGbyZYE3L0>

<aside>
💡 2. 크로스플랫폼 동작 (NFR : 시스템은 다양한 사용자 환경을 지원하며 호환성을 유지해야 한다.)
Orbit는 Flutter를 이용하여 Cross-platform을 지원합니다.
Apple의 IpadOS에서의 동작을 시연합니다.

</aside>

<https://youtu.be/Ia1h935xxas>

# Source Codes

Github 주소

<https://github.com/pwh9882/orbit.git>

과제 제출 시 마지막 commit

<https://github.com/pwh9882/orbit/commit/414b7f8a6d1ec22c42526f0b2ff67a3b6989983c>

Github project 소스코드 전체

[orbit-main.zip](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/564938ce-8b99-4a68-ae1b-17a6e062ebef/orbit-main.zip)

프로젝트 보고서 pdf export

[최종프로젝트 결과 보고서 백업.zip](https://prod-files-secure.s3.us-west-2.amazonaws.com/eabc2885-0396-4f4d-a76f-ac4a784e4e96/ed62bb68-2f4d-4525-80ea-50cf7ca2f765/%E1%84%8E%E1%85%AC%E1%84%8C%E1%85%A9%E1%86%BC%E1%84%91%E1%85%B3%E1%84%85%E1%85%A9%E1%84%8C%E1%85%A6%E1%86%A8%E1%84%90%E1%85%B3_%E1%84%80%E1%85%A7%E1%86%AF%E1%84%80%E1%85%AA_%E1%84%87%E1%85%A9%E1%84%80%E1%85%A9%E1%84%89%E1%85%A5_%E1%84%87%E1%85%A2%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8.zip)

[https://healthy-sleet-e1b.notion.site/5-20203070-98409d704f97425f9d52afb76ff4624f?pvs=4](https://www.notion.so/5-20203070-98409d704f97425f9d52afb76ff4624f?pvs=21)
