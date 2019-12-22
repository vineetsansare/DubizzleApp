# DubizzleApp
This repo holds the code for Dubizzle App for a client.

## About App

This is a simple app which basically fetches a product list from the given API, and parses the JSON response into models which are `Codable` structs & ultimately displaying it in a collectionView. Every item is a product item which displays image, product name, product price. On tapping any of the item, user can get into the detail screen.

## Note for the Reviewers

**Covered all required activities**
- [x] Retrived data from the given endpoint 
- [x] Designed Homepage with product listings
- [x] Designed product details screen
- [x] Good UI approach - _(MVC pattern followed, though I'm aware of MVVM, VIPER & other architectural design patterns too but I thought for this app MVC would be better)_
- [x] Unit tests using XCTest
- [x] Simple UI tests using XCUITest
- [x] Search listings **(Covered bonus point)**
- [x] Clear README.md that explains how the code and the test can be run

## Running the app

Once you have clonned the app to your local system, you can fire-up the app by opening _DubizzleApp.xcworkspace_ file.

## Important Info 
> _To demonstrate that I also have knowledge on using Cocoapods, I'm using SDWebImage for asynchronously downloading images from the server._ 

## Orientation & universal support

- App can be run on both the orientations i.e. Landscape and Portrait
- App also runs on iPad
- App is tested on simulators of iPhone Xs /iPad (6th gen) running on iOS 12.4 

### Screenshots

**Product Listings screen**

<img width="1159" alt="productListing" src="https://user-images.githubusercontent.com/6418402/71324228-b9bd4d80-24f5-11ea-8159-38f2ed9a8679.png">

**Product Details screen**

<img width="1162" alt="productDetails" src="https://user-images.githubusercontent.com/6418402/71324227-b924b700-24f5-11ea-8979-e02524a4ed8e.png">

**Search Product screen**

<img width="1143" alt="productSearch" src="https://user-images.githubusercontent.com/6418402/71324229-b9bd4d80-24f5-11ea-9b5b-c68a543f3407.png">



## App Architecture

On revieiwing the code the code-reviewer will notice that I've tried to keep the code as generic as possible and used the MVC design pattern to keep models, views & controllers as separate entities. 

The folder structure is architected to keep the Network layer, UI layer, and App Constants modular for reusability.

**UI Structure**
* Main.Storyboard has a ViewController embeded in NavigationController & also has ProductDetailsViewController.
* ViewController has UICollectionView with a prototype cell.
* The contentView of the cell has an imageView with labels embeded in stackViews for displaying productName and price

**Views**
- **ProgressView** - It's a custom view to that shows that a task is in progress. [Activity indicator]

**Network structure**
- **Reachability** - To check for network reachability
- **NetworkManager** - As the name suggests, its a manager for making service calls.
- **ProductNetworkAdapter** - It's a helper for getProducts API call which internally uses NetworkManager only. But this class returns us a ProductModel after parsing the JSON response.


**Constants**
- **AppConstants** - It holds all the app constants
- **NetworkConstants** - It holds all the constants required during networking i.e. API calls. For now only baseURL string is there.

## Unit Testing 

> _Since the app has no complex business logic to test as such, I've written a simple test case to cover the Asynchronous API call made to fetch the data from the server._

## Running Test cases

> Please run entire test cases by pressing Commad+U

**Unit Test cases**

##### Please refer the comments in the code for better idea.

- **No internet connection -** Turn off internet connection and run this test case, it should fail with `XCTFail("error: No internet connection.")`
- **Some Server Error -** If the block returns with `error` i.e if error is not `nil` it means there is some server error, thus the test for server error succeeds. It should ideally fail to meet the expectation (promise).
- **Expectation fulfilled i.e. response data received -** This test succeeds if the `error` object is nil & we've received the response successfully.
- **asynchronous wait fail -** If asynchronous wait failed i.e. exceeds 10 secs then our expectation (promise) doesn't get fullfilled & we get failed - error: The operation couldn’t be completed. To test this reduce the `waitForExpectations(timeout: 10)` to `waitForExpectations(timeout: 0.2)`

**UI Test cases**
- Displaying only one collectionView

The above UI test can be run by opening up the `DubizzleAppUITests.swift` file and navigating to `func testForOneCollectionView()` & pressing the play button in front of it. 




