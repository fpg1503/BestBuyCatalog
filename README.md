# BestBuy Catalog

This app is a really simple BestBuy Catalog.

## How to run

### API Key

To run this locally you'll need a [BestBuy API key](https://developer.bestbuy.com/documentation/). When you have one simply create an `APIClient` extension like the following:


```swift
extension APIClient {
    init() {
        self.init(key: <#your key goes here#>)
    }
}
```

Download the project and run on Xcode 8.0 (Swift 3.0). Even though I'm not a big fan of [committing the `Pods` directory](https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control) I've done it in this project to make running this project a bit sampler.

## Current features

- [x] Universal App
- [x] Listing
- [x] Searching
- [x] Sorting
- [x] Model tests
- [x] Pull to refresh
- [x] Accessibility (Voice Over)
- [x] Automatic paging
- [x] Autolayout
- [x] Localization
- [x] Zoom in onto images
- [x] Share products on social networks


## TODO (in the future):

- [ ] UI tests
- [ ] Try ReLayout
- [ ] Replace Storyboards with ViewCoding
- [ ] Peek and Pop
- [ ] CoreSpotlight
- [ ] Use SwiftGen


# Architecture

The chosen architecture was protocol-oriented model-view-viewModel.

The model consists of immutable, `Hashable` and `Decodable` value types.

The view was done using Storyboard and AutoLayout. The view can only be configured using a viewModel.

The viewModel uses protocols and protocol extensions to apply the necessary transformations to the model (i.e. date and text, formatting, creation of accessibility labels).

Since our models are immutable and no changes had to made two-way binding was not required.

# Testing

Currently there are only 2 test classes: `APIClientTests`, and `ProductDecodingTests`.

`ProductDecodingTests` attempts to decode both valid and invalid dictionaries to `Product`. It wouldn't make sense to test the `NSJSONSerialization` here since our goal is to test decoding/mapping. Handling the JSON --> Dictionary conversion **is not a responsibility of our model.**

`APIClientTests` uses `Mockingjay` to mock the response of the server so `APIClient.getProducts()` can be tested. All responses are wrapped in a generic `Response` which is indirectly tested.

# Created extensions


- `Array+SafeAccess`: Safe access to any array index (returns `Element?`)
- `UIViewController+Alert`: Simple `UIAlertController` creation from `String`s and `Error`s
- `NumberFormatter+Currency`: Creation of pre-configured `NumberFormatter`s
- `UIView+Border`: IBInspectable view borders
- `String+Localization`: Simple String localization
- `UIAccessibility+Inferred`: Ability to infer the `accessibilityLabel` of a view based on its contents and their order.
- `UIViewController+ImageController`: Simple JTSImageViewController wrapper
- `Logger`: A precondition failure logger. Aborts execution on debug.

# Tools and frameworks

- [Alamofire](https://github.com/Alamofire/Alamofire) - Networinkg
- [AlamofireImage](https://github.com/Alamofire/AlamofireImage) - Image download/caching
- [JTSImageViewController](https://github.com/jaredsinclair/JTSImageViewController) - Image viewer that does double tap to zoom, flick to dismiss, et cetera.
- [Mockingjay](https://github.com/kylef/Mockingjay) Elegant HTTP request stubbing
- [Reveal](http://revealapp.com) - UI Debugging
- [Paw](https://paw.cloud) - API Testing
- [OptionalOutlets](https://github.com/fpg1503/OptionalOutlets) - Optional `@IBOutlets`

