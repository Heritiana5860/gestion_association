import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/errors/failure.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/login_params.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/repositories/auth_login_repository.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/usecases/auth_login_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthLoginRepository extends Mock implements AuthLoginRepository {}

void main() {
  late AuthLoginUseCase usecase;
  late MockAuthLoginRepository mockRepository;

  // setUp() s'exécute avant chaque test _> un mock "propre" à chaque fois
  setUp(() {
    mockRepository = MockAuthLoginRepository();
    usecase = AuthLoginUseCase(repository: mockRepository);
  });

  const tParams = LoginParams(username: "beto", password: "123456");
  const tSession = AuthSessionEntity(
    refresh: 'fake_access_token',
    access: 'fake_refresh_token',
    username: 'beto',
    firstName: 'TORO Beto',
  );

  test("should return AuthSessionEntity when login is successful", () async {
    // ARRANGE : on programme le mock
    when(
      () => mockRepository.login(tParams),
    ).thenAnswer((invocation) async => const Right(tSession));

    // ACT : on appel usecase
    final result = await usecase.call(tParams);

    // ASSERT
    expect(result, const Right(tSession));
    // Vérifie que le repository a bien été appelé avec CES params précis
    verify(() => mockRepository.login(tParams)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when login fails', () async {
    const tFailure = ServerFailure(
      message: 'Identifiants invalides',
      statusCode: 401,
    );

    // ARRANGE
    when(
      () => mockRepository.login(tParams),
    ).thenAnswer((invocation) async => const Left(tFailure));

    // ACT
    final result = await usecase.call(tParams);

    // ASSERT
    expect(result, const Left(tFailure));
    verify(() => mockRepository.login(tParams)).called(1);
  });
}
