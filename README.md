### Introduction

Demo application in iOS that uses Marvel public API to show a list of characters.

### Architecture

Application is built upon Clean Architecture concepts. There are 3 layers that perform different aspects of the code.

- Domain Layer: Contains domain specific Use Case classes
- Data Layer: Talks to network module to retrieve DTOs.
- Presentation Layer (MVVM): ViewModels + Views

### Dependency Injection
Dependency Injection is achieved using a library called Resolver. Different containers are set for test and app environments.

### Networking
Networking layer is a wrapper around URLSession. URLProtocol is used to mock the network calls in unit tests.

### UI
UIKit is used instead of SwiftUI for Views. MVVM pattern (using Combine) is used as presentation architecture.

### Video Demo

https://user-images.githubusercontent.com/20021603/152728774-90d9cb16-6d03-4271-b8cd-f75e1a579bc5.mp4


