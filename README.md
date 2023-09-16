# Explore-Planet

Explore Planet
Purpose of the App is View All the Stare wars Locations.

Preview Of the App
</br>
<img width="350" alt="Screenshot 2023-09-16 at 11 06 19 PM" src="https://github.com/Kangajan18/Explore-Planet/assets/97095835/e5acee50-1837-400d-a01b-3d96bc531e19">


Tools and Architecture.
The Project employs the MVVM architectural pattern, leveraging RxSwift and RxCocoa libraries for view-model bindings. For network operations, it utilizes the Alamofire library.

A Simple Explanation of MVVM from My point of view.
The ViewModels handle data transformation for displaying in the app's views. These transformed data are then made available as properties to the ViewController. The ViewController's role is to connect these properties to the views and pass user interactions to the ViewModel. This ensures constant synchronization between the Views and ViewModels.

The primary principles advocated by the MVVM pattern are:
* Each Model is managed by a ViewModel and is unaware of the ViewModel's existence.
* Each ViewModel is managed by a ViewController and is oblivious to the ViewController's presence.
* The ViewController manages the ViewModel and should not have any knowledge of the underlying model.
Benefits of MVVM.
* Ensures effective encapsulation of business logic and model data transformations.
* Simplifies the creation of unit tests.
* Results in lighter ViewControllers compared to the MVC pattern, helping to mitigate the "Massive ViewController" issue.

List of Classes group by responsibilities:
View
* PlanetListViewController : this going to show the list of starers planet locations. 
* PlanetDetailsViewController : this is respons to provide more data about planet.
View Models
* PlanetViewModel : Functionality for Planet Views' Business Logic.
Model
* Planet : The model contains DTOs (Data Transfer Objects) used to retrieve data from the API for all planets.
