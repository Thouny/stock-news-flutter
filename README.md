# StockNews-Flutter

StockNews is a mobile application for people to get the latest business and tech news and stock market information.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Installation](#installation)
   1. [VSCode](#vscode)
   2. [IntelliJ/Android Studio](#intellijandroid-studio)
3. [Project Architecture Overview](#project-architecture-overview)
   1. [Features](#features)
      1. [Presentation](#presentation)
      2. [Domain](#domain)
      3. [Data](#data)
   2. [Core](#core)
   3. [Dependency Injection](#dependency-injection)
   4. [Routing](#routing)
   5. [Pages](#pages)
4. [Contributing](#contributing)

## Project Overview

StockNews is a project developed as a practice to showcase my approach to coding.

From a technical perspective, StockNews is implemented using Flutter using Clean Architecture.

It relies on [NewsAPI](https://newsapi.org/docs) to get the latest news

And [FinancialModelingPrepAPI](https://site.financialmodelingprep.com/developer/docs) for stock market data

Github is used to host the repositories.

Trello is used for managing the project. You can access it [here](https://trello.com/b/3rgk1UiX/stocknews)

## Installation

1. Install Flutter 3.16.7. Guide [here](https://docs.flutter.dev/get-started/install).
2. Clone the repository
3. Install dependencies: `flutter pub get`

## Usage

### VSCode

Add env vars to a `launch.json` config:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Dev-debug",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "program": "lib/main_dev.dart",
      "args": [
        "--dart-define",
        "NEWS_API_KEY=insert_api_key_here",
        "--dart-define",
        "FINANCIAL_MODELING_PREP_API_KEY=insert_api_key_here"
      ]
    },
    {
      "name": "UAT-debug",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "program": "lib/main_uat.dart",
      "args": [
        "--dart-define",
        "NEWS_API_KEY=insert_api_key_here",
        "--dart-define",
        "FINANCIAL_MODELING_PREP_API_KEY=insert_api_key_here"
      ]
    }
  ]
}
```

### IntelliJ/ Android Studio

- From the main menu, select Run | Edit Configurations or choose Edit Configurations from the run/debug configurations selector on the toolbar.

- In the Run/Debug Configurations dialog that opens, select a configuration where you want to pass the arguments

Example to create a configuration in the dialog
Name: `Dev-debug`
Dart entrypoint: "SOURCE_PATH/lib/main_dev.dart"
Additional run args: `--dart-define "NEWS_API_KEY=insert_api_key_here" --dart-define "FINANCIAL_MODELING_PREP_API_KEY=insert_api_key_here"`

[Additional documentation can be found here](https://www.jetbrains.com/help/idea/run-debug-configuration.html).

## Project Architecture Overview

This project is structured following the Clean Architecture principle.

### Features

- **News**: Provide business and tech news
- **Stock**: Allows the user to see companyies' stock data
- **User**: Used to fetch the user from the device and greet them on the home screen.

Each feature is organized into three fundamental layers: Presentation, Domain, and Data.

#### Presentation

The `presentation` layer contains all UI components associated with the feature.

- widgets: UI components responsible for displaying data (provided by the bloc) and responding to user interactions. They actively listen to state changes emitted from the bloc.
- blocs: The brain behind the UI. A bloc encapsulates the UI state, receives events from user interactions, delegates tasks to use cases, and emits states based on the results provided by the use case.

#### Domain

The `domain` layer holds the core business logic and entities, shaping the heart of each feature.

- usescases Where the business logic gets executed. Delegate the work of getting the data to the repository.
- entity: Represents the business object, defining the data to be displayed on the UI.
- repository: Acts as a contract, outlining the interface to be implemented in the data layer. It provides data to the use case.

#### Data

The `data` layer is responsible for data handling, interfacing with various sources.

- repository: Implements the interface defined in the domain layer, deciding which data source to fetch from (remote or local).
- datasource: Can be remote (API calls) or local (handling data from third-party libraries).

### Core

The `core` folder contains all reusable code across different features.

--> consts

--> enums

--> error

--> extension

--> theme

--> utils

--> widgets


### Dependency Injection

The `di` folder is responsible for registering and injecting all dependencies at app start-up.

### Routing

The `routing` folder encapsulates the navigation logic of the app.

### Pages

The `pages` folder contain all of the app pages.

## Contributing

1. Create a new branch: `git checkout -b feature/jmo-<feature name>`.
2. Make your changes and commit them: `git commit -m '[SN-<ticket number>] <short description>'`.
3. Push to the branch: `git push origin my-feature-branch`.
4. Submit a pull request.
