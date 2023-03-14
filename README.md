
## This app is created to list products in your iPhone and one can check the details listed with products by selecting the product from the list.    

## About the app

This app is created using MVVM design pattern.

The app is build using UIKit framework and no two party is used to build this app.

This app uses the *Fakestore API* i.e https://fakestoreapi.com/products to list the products and their details.

## Features in the app

*Products List* : This screen displays all the producrs fetched from the API. It dispays the title, Orice and image of the product.

*Characters Detail* : This screen displays the Image, full description, name and price to the product in the screen. Along with that this app also have an option to Add, Delete or update the product.


************** Technical Details ******

*Architecture* : This app is developed using MVVM design pattern which includes three layer i.e Model, View and View model. 
*Model* : This layer includes parsing of the json coming from the server.

*View* : This layer is reponsible performing the UI Related actions such as Button actions, Scrolls etc.
*ViewModel* : This layer contains the business logic, asynchronus networking code. 

## To Run the app

1. Download/Clone the app from the github
*Command to clone the app* : Open terminal and use this command *git clone (branch url)* to clone the app.
