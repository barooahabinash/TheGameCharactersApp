# The GameCharacters App
This is a simple app where a user can see different game characters and also images and names of those characters . The app utilizes the IGDB API (https://api-docs.igdb.com) to retrieve game characters related information.

The app is built using SwiftUI and uses the MVVM design pattern. There are view models for screens , view for the game character image page and separate class for Network calls. For the network call class I have used protocols so that those can be mocked for testing. I have made most of the UI components as separate entities so that they can be reused later if needed.

Features:
* Shows different game characters
* Display images and names of the different game characters.
* Placeholder images in case images are not avaialble in API.
* Error handling.Log errors in console
* Modal view to display images along with a dismiss button.
* Save the session token until expiration to avoid retrieving it when not needed.

Additional features that I think can be added:
* Add an option for the user to choose a game (from a list of games) and then display the characters according to the game choosen.
* The home screen with the game character list can be customized further to give it a better look and feel
* Features like share game character details to social media
* Search & Filter game characters
* Add a splash screen

 *Note: Currently, there are no tests included in the project.
  Only game characters from the Characters endpoint is shown .
  users do not have an option to choose a game*
