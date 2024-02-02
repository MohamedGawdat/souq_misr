enum AppState { Dev, Test, Production }

class _AuthValues {
  final String baseUrl;
  final String token;
  _AuthValues({
    required this.baseUrl,
    required this.token,
  });
}

class AppAuth {
  static AppAuth? _instance;
  static AppState currentState = AppState.Production;
  static late _AuthValues data;

  static const _productionUrl = 'https://currencies.gawdt.com';
  static const _testUrl = 'https://currencies.gawdt.com';
  static const _devUrl = 'https://currencies.gawdt.com';

  static const _productionToken = '';
  static const _testToken = '';
  static const _devToken = '';

  AppAuth._internal();

  static AppAuth get instance {
    _instance ??= AppAuth._internal();
    return _instance!;
  }

  static init() {
    switch (currentState) {
      case AppState.Dev:
        {
          data = _AuthValues(baseUrl: _devUrl, token: _devToken);
          return;
          // statements;
        }

      case AppState.Test:
        {
          data = _AuthValues(baseUrl: _testUrl, token: _testToken);
          return;

          //statements;
        }
      case AppState.Production:
        {
          data = _AuthValues(baseUrl: _productionUrl, token: _productionToken);

          return;

          //statements;
        }

      default:
        {
          return '';
          //statements;
        }
    }
  }

  static isTestMode() {
    return currentState == AppState.Dev || currentState == AppState.Test;
  }
}
