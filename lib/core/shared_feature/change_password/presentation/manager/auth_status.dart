import 'change_password_state.dart';

enum AuthStatus {
  authenticated,
  noAuthAvailable,
  notAuthenticated,
  error,
  deviceLockOnly
}

class AuthResult extends ChangePasswordState {
  final AuthStatus status;
  final String? errorMessage;
  final bool hasDeviceLock;

  const AuthResult({
    required this.status,
    this.errorMessage,
    this.hasDeviceLock = false,
  });

  factory AuthResult.authenticated() =>
      const AuthResult(status: AuthStatus.authenticated);
  factory AuthResult.noAuthAvailable() =>
      const AuthResult(status: AuthStatus.noAuthAvailable);
  factory AuthResult.notAuthenticated() =>
      const AuthResult(status: AuthStatus.notAuthenticated);
  factory AuthResult.error(String message) =>
      AuthResult(status: AuthStatus.error, errorMessage: message);
  factory AuthResult.deviceLockOnly() => const AuthResult(
        status: AuthStatus.deviceLockOnly,
        hasDeviceLock: true,
      );
}
