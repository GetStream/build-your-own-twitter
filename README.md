# Build a Twitter Clone With SwiftUI in a Weekend :sunglasses:

[Eight tutorials](#) aimed at teaching you how to build a functional Twitter clone using APIs and SwiftUI. In this project, we will use [Stream](https://getstream.io/ios-activity-feed/tutorial/) for Chat and Activity Feeds, [Algolia](https://www.algolia.com/) for search, [RevenueCat](https://www.revenuecat.com/) for subscriptions, [100ms](https://www.100ms.live/) for audio rooms and [Mux](https://www.mux.com/) for video playback.

![Header image](https://github.com/GetStream/build-your-own-twitter/blob/main/Preview/byot-wrapup-header.png)

## Key Features

| Partners | Main Features | Description | Preview |
|---------------|---------------|-------------|---------|
| ![Stream](https://github.com/GetStream/stream-twitter-byo-ios/blob/main/Preview/stream.svg) | **Homepage Timeline Feeds**     | Stream Feeds and the React Activity Feeds SDK from Stream to create a mobile clone of Twitter.    | ![Stream feeds](https://github.com/GetStream/stream-twitter-byo-ios/blob/main/Preview/01_signInTimeLine.gif) |
| ![100ms](https://github.com/GetStream/stream-twitter-byo-ios/blob/main/Preview/100ms.svg) |   **Twitter Spaces**   | Create an audio room for conversations     | ![https://www.100ms.live/](https://github.com/GetStream/stream-twitter-byo-ios/blob/main/Preview/04_spaces.gif) |
| ![Algolia](https://github.com/GetStream/stream-twitter-byo-ios/blob/main/Preview/algolia.svg) | **Search & Follow Users**     | Build a fully functional search to find and follow users using Algolia's search API     | ![Algolia](https://github.com/GetStream/stream-twitter-byo-ios/blob/main/Preview/03_search.gif) |
| ![Mux](https://github.com/GetStream/stream-twitter-byo-ios/blob/main/Preview/mux.svg) | **Media Upload**     | Tweet with video     | ![]() |
| ![RevenueCat](https://github.com/GetStream/stream-twitter-byo-ios/blob/main/Preview/revenueCat.svg) | **Twitter Blue**     | In-app subscriptions     | ![]() |


## The following links are the various parts of the tutorial series.

1. [Building the Timeline](#) 
2. [Adding Stream Feeds to the Timeline](#)
3. [Enabling Support For Media Tweets and Video Playback](#)
4. [Searching and Following Users](#)
5. [Messaging and DMs](#)
6. [Conversations With Spaces](#)
7. [Twitter Blue and In-app Subscriptions](#)

-------------

# Getting Started

## Node backend
Please run the Node sample backend from this Git repository: [GetStream/stream-node-simple-integration-sample](https://github.com/getstream/stream-node-simple-integration-sample/)

## iOS Frontend

The folder TwitterClone contains the iOS codebase

To get started with it, you need to install Tuist and run `tuist generate` in the directory `TwitterClone`. Then open the `TwitterClone.xcworkspace` file.

[![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)


### To install Tuist on your system:

Run:
```shell
curl -Ls https://install.tuist.io | bash
```

### Fetching external dependencies

When you get freshly cloned this repository or dependencies have been updated. Run:

```shell
tuist fetch
```

### Generate and open project files
To generate the Xcode project files and open the project in Xcode, run:
```shell
tuist generate
```

## iOS package graph
We work towards a µFramework based packaging system

![](TwitterClone/graph.png)

To generate a fresh graph, in case you updated the project's package structure or dependencies. Run:

```shell
tuist graph --skip-test-targets
```

