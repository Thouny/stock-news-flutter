# StockNews-Flutter

StockNews is a mobile application for people to get the latest business and tech news and stock market information.

## Project Overview

StockNews is a project developed as a practice to showcase my approach to coding.

From a technical perspective, StockNews is implemented using Flutter.

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

## Technical

This project architecture is based on the Clean Architecture.

Features:

- **News**: Provide business and tech news
- **Stock**: Allows the user to see companyies' stock data
- **User**: Used to fetch the user from the device and greet them on the home screen.

## Contributing

1. Create a new branch: `git checkout -b feature/jmo-<feature name>`.
2. Make your changes and commit them: `git commit -m '[SN-<ticket number>] <short description>'`.
3. Push to the branch: `git push origin my-feature-branch`.
4. Submit a pull request.
