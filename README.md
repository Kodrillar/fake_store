# Fake Store - Overview

This is a simple eCommerce app developed using Flutter & Dart. It utilizes the following libraries:

`dio` for handling API calls and networking.\
`flutter_bloc` for state management.\
`get_it` to access & manage app services.\
`shared_preferences` for storing data persistently.\
`go_router` for applicationwide routing and navigation.

## Key App Features

- Product catalogue
- Carting
- Wishlisting

<img width="200" alt="Welcome Page" src="https://github.com/user-attachments/assets/9ee34999-d105-4746-be7f-aa8ca305b20d"> <img width="200" alt="Auth Page" src="https://github.com/user-attachments/assets/640d810d-3164-4ddf-9f0f-b3ac1c873a5a"> <img width="200" alt="Home - Catalogue" src="https://github.com/user-attachments/assets/31ec7ec9-79c9-4dc7-ba9c-d8b09a322a29"> <img width="200" alt="Product details" src="https://github.com/user-attachments/assets/d348dd72-da0e-4e5a-8c74-3054a19eea1b"> <img width="200" alt="Wishlist" src="https://github.com/user-attachments/assets/c6068681-e019-41c3-9714-82d94666a7a3"> <img width="200" alt="Cart" src="https://github.com/user-attachments/assets/4aae4ef9-cb85-4623-b5c9-17648b4c5b60">

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

## Project structure

This project uses a layered architecture where entities(Presentation, Data, Domain e.t.c) with specific responsibilities are modularized. As for the folder structure, the project uses a feature-first approach to create a modular project structure..

`/src` : This folder contains all the source code used in building the app.\
`/src/core`: This folder contains reusable modules & resouces that are used within the app, e.g service locators, reusable widgets, and so on.\
`/features`: This module contains implemented modular app features.\
`/theme`: This folder contains applicationwide theming implementaton details.
`/routing`: This folder contains applicationwide routing system that utilizes the `go_router` package.\
`/exceptions`: This module contains custom exception classes used within the app.\
`/res`: This contains applicationwide resources like fonts names, image or svg paths and so on.\

## Adaptive UI Implementation

In this project, I used a package created by me, [Screendapt package](https://github.com/Kodrillar/screendapt) which utilizes the [Flutter Screenutil package](https://pub.dev/packages/flutter_screenutil) under the hood to ensure UI components are adaptive. Widgets like the `SText`, `SContainer`, and `SIcon` where used to create UI components to ensure that overall app UI looks great on different devices.

## Authentication & App APIs

This project utilizes the open source [Fake Store API](https://fakestoreapi.com/). Thanks to the creators.

You can use these credentials to log in or create yours with the [Fake Store API](https://fakestoreapi.com/docs):
**Username:** `johnd`\
**Password:** `m38rmF$`
