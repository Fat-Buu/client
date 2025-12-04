// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoginViewModel)
const loginViewModelProvider = LoginViewModelFamily._();

final class LoginViewModelProvider
    extends $AsyncNotifierProvider<LoginViewModel, User> {
  const LoginViewModelProvider._({
    required LoginViewModelFamily super.from,
    required LoginService super.argument,
  }) : super(
         retry: null,
         name: r'loginViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$loginViewModelHash();

  @override
  String toString() {
    return r'loginViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LoginViewModel create() => LoginViewModel();

  @override
  bool operator ==(Object other) {
    return other is LoginViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$loginViewModelHash() => r'e6cfcb4288b6545400c865399a6d8dc3bee00707';

final class LoginViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          LoginViewModel,
          AsyncValue<User>,
          User,
          FutureOr<User>,
          LoginService
        > {
  const LoginViewModelFamily._()
    : super(
        retry: null,
        name: r'loginViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LoginViewModelProvider call({required LoginService loginService}) =>
      LoginViewModelProvider._(argument: loginService, from: this);

  @override
  String toString() => r'loginViewModelProvider';
}

abstract class _$LoginViewModel extends $AsyncNotifier<User> {
  late final _$args = ref.$arg as LoginService;
  LoginService get loginService => _$args;

  FutureOr<User> build({required LoginService loginService});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(loginService: _$args);
    final ref = this.ref as $Ref<AsyncValue<User>, User>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User>, User>,
              AsyncValue<User>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
