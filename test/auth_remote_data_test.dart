import 'package:dio/dio.dart';
import 'package:flutter_batch_4_project/data/remote_data/auth_remote_data.dart';
import 'package:flutter_batch_4_project/data/remote_data/network_service/network_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_test.mocks.dart';

@GenerateMocks([NetworkService])
void main() {

  late MockNetworkService mockNetworkService;
  late AuthRemoteData authRemoteData;

  setUp(() {
    mockNetworkService = MockNetworkService();
    authRemoteData = AuthRemoteDataImpl(mockNetworkService);
  });

  group('AuthRemoteData::postLogion()', () {
    
    test("Login Sucess and return User Data", () async {
      final email = "admin@gmail.com";
      final password = "123456";
      final path = "/api/auth/login";

      final mockResponseData = {
        "data": {
          "user": {
            "name": "Admin",
            "email": "admin@gmail.com"
          },
          "access_token": "random_access_token"
        }
      };

      final mockResponse = Response(
        requestOptions: RequestOptions(
          path: path,
        ),
        statusCode: 200,
        data: mockResponseData
      );

      // Membuat skenario untuk proses Login berhasil
      when(mockNetworkService.post(
        url: path,
        data: anyNamed('data')
      )).thenAnswer((_) async => mockResponse);

      // Pemanggilan fungsi Login
      final result = await authRemoteData.postLogin(email, password);

      // Memastikan data yang ada dalam Model sesuai dengan resposne json
      expect(result.accessToken, "random_access_token");
      expect(result.user?.name, "Admin");
      expect(result.user?.email, "admin@gmail.com");

      // Memastikan fungsi Login memanggil enpdpoint dan payload data yang sesuai
      verify(mockNetworkService.post(
        url: path,
        data: {
          "email": email,
          "password": password
        },
      )).called(1);

    });

    test("Login failed", () {
      final email = "admin@gmail.com";
      final password = "123456";
      final path = "/api/auth/login";

      when(mockNetworkService.post(
        url: path,
        data: anyNamed("data")
      )).thenThrow(Exception("Login Failed"));

      expect(() => authRemoteData.postLogin(email, password), throwsException);

      verify(mockNetworkService.post(
        url: path,
        data: {
          "email": email,
          "password": password
        },
      )).called(1);
    });

  });

}