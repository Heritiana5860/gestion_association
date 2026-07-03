import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_register_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_register_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/usecases/auth_register_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRegisterRepository extends Mock
    implements AuthRegisterRepository {}

void main() {
  late MockAuthRegisterRepository mockRegister;
  late AuthRegisterUsecase registerUsecase;

  setUp(() {
    mockRegister = MockAuthRegisterRepository();
    registerUsecase = AuthRegisterUsecase(repository: mockRegister);
  });

  const tRegisterEntity = AuthRegisterEntity(
    fullName: "TORO Beto",
    username: "beto",
    password: "123456",
  );
  const tSession = AuthSessionEntity(
    refresh: 'fake_access_token',
    access: 'fake_refresh_token',
    username: 'beto',
    firstName: 'TORO Beto',
  );

  test("should return AuthSessionEntity when register succesful", () async {
    // ARRANGE
    when(
      () => mockRegister.register(tRegisterEntity),
    ).thenAnswer((_) async => const Right(tSession));

    // ACT
    final result = await registerUsecase.call(tRegisterEntity);

    // ASSERT
    expect(result, const Right(tSession));
    verify(() => mockRegister.register(tRegisterEntity)).called(1);
    verifyNoMoreInteractions(mockRegister);
  });

  test("should return Failure when register fails", () async {
    const tFailure = ServerFailure(
      message: "Erreur lors de la création d'un compte",
      statusCode: 401,
    );

    // ARRANGE
    when(
      () => mockRegister.register(tRegisterEntity),
    ).thenAnswer((_) async => const Left(tFailure));

    // ACT
    final result = await registerUsecase.call(tRegisterEntity);

    // ASSERT
    expect(result, const Left(tFailure));
    verify(() => mockRegister.register(tRegisterEntity)).called(1);
  });
}
