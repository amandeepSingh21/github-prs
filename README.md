![Demo](docs/demo.gif)

## 1. Assignment

by [Amandeep](mailto:amandeep.saluja21@gmail.com).

<img src="https://raw.githubusercontent.com/amandeepSingh21/github-prs/main/docs/screenshot.png" width="300" height="600">>

## 2. Requirements
- iOS 13.0+
- Tested on iOS 16 Simulator
- [Xcode 14.0.1+]

## 3. Getting Started
- Open `GithubPRs.xccodeproj` in Xcode

## 4. API
[API](https://api.github.com/repos/apple/swift/pulls?page=1&per_page=10)

## 5. Swift
This project is build using Swift 5.

## 6. 3rd Party
- None

## 7. Unit/UI Test case
 - Test coverage is 49%
 - There are tests for presenters.
 - There are tests for interactors.
 - There are tests for wireframes.
 - There are tests to test the pagination logic.
 ![Coverage](docs/coverage.png)


## 8. Architecture 
- In this project, I'm using **VIPER** architecture.
I have slightly modified VIPER to use completion handler for InteractorToView communication
and use a closure wrapper(Observable) for PresenterToView communication. This helped me trim down
boilerplate code for testing.
- Note: I am referring to the domain representation of APIResponse/Codeable as ViewModel.
- Heavily using Container ViewController to prevent massive view controllers.
- Container ViewControllers are used to render messages as well as the Segmented ViewControllers.
- Navigation is scalable for multiple tabs and authenticaiton flow.
- You might see some code duplication across commits/comments/PR module. This is intentional.
   We don't want to prematurely optimize. For e.g in the future comments feature can be extended to support replying to comments (chat)
![Coverage](docs/architecture.png)

## 9. Features 
 - Two main screens: PullRequestList and PullRequestDetail.
 - PullRequestList: I have provided 'open' and 'closed' filters (No local filtering but actual API calls).
 - PullRequestDetail: Comments list and Commits list.
 - Clicking on an item in Commnts list or Commits list opens HTMLlink in Safari.
 - Image caching.Image requests are cancellable.
 - All screens are pagianted.
 - Pull to refresh.
 - Extensible for API response caching since Interactor only exposes domain model and not codable.
 - Dark mode is supported.
 - Dynamic cell height.
