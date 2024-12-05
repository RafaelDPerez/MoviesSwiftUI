## **Description**

This is a project written in SwiftUI and Swift to tackle the iOS challenge for Code Road.

## **Introduction**

Project UI in its entirety is written in SwiftUI. 
I decided to use MVVM as architecture. Also, I implemented the api calls using the latest concurrency framework from Apple, async/await. I have a ContentView that shows the Search bar and when you type a movie name, it hits the api and returns the movie found. Once you tap on the movie, I show the details with what was requested and a button on the top right part ot add/remove from favorites.

## **Technologies used**
- Combnine
- Async/Await
- SwiftUI
- Swift
- protocol oriented
- ObservableObject
- Swift
- Cache
- UserDefaults
- Repository Pattern

## **Components**
**MovieViewModel**: this ViewModel is an ObservavbleOvject that is in charge of grabbing the search text and sending it to the API. This ViewModel requires a MovieRepo to be injected.

**MovieRepo**: is a struct that conforms to MovieRepository protocol, and it's in charge of sending the api call with the search text and updating a published var that refreshes the main view.

**MovieViewModel**: this ViewModel contains the info that needs to be displayed in both the results list and the details view. This ViewModel also contains the Favorites manager.

**FavoritesMovieManager**: this class is in charge of receiving the movies and adding/removing from Favorites. This also saves it in UserDefaults. I thought about useing CoreDta but thought it might be an overkill.

**MovieService**: is a struct in charge of building the URL for the API call.

**CachedAsyncImage**: is a modified AsyncImage that's in charge of caching the images so it can load faster and save resources.


## **Tech debt**

1. I didn't add any unit tests because of time constraints, but I created the MovieRepo from a MovieRepository protocol because we could create a mock repo to add some unit testing.

## **Screenshots/GIFs**
![movie app](https://github.com/user-attachments/assets/f90bf504-04ea-464f-90f5-aadc71fee427)
