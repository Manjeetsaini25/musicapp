import 'dart:convert';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/core/failure/Failure.dart';
import 'package:client/features/auth/model/user_modal.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref){
  return AuthRepository();
}


class AuthRepository{
  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required email,
    required password
  }) async{
    try{
      final response = await http.post(
      Uri.parse(
      '${ServerConstant.serverURL}/auth/signup',
    ),
    headers: {
      'Content-Type':'application/json'
    },
    body: jsonEncode({
      'name':name,
      'email':email,
      'password':password
    },
    )
    );
    final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
    if(response.statusCode != 201){
      return Left(AppFailure(responseBody['detail']));
    }
    return Right(UserModel.fromMap(responseBody));
    }catch (e){
      return Left(AppFailure(e.toString()));
    }
  }
  Future<Either<AppFailure,UserModel>> login(
    {
      required String email,
      required String password
    }
  ) async {
    try{
      final response = await http.post(
      Uri.parse(
      '${ServerConstant.serverURL}/auth/login',
    ),
    headers: {
      'Content-Type':'application/json'
    },
    body: jsonEncode({
      'email':email,
      'password':password
    },
    )
    );
    final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(AppFailure(resBodyMap['detail']));
      }

      return Right(
        UserModel.fromMap(resBodyMap['user']).copyWith(token: resBodyMap['token'])
        );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> getCurrentUserData(String token) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ServerConstant.serverURL}/auth/',
        ),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(AppFailure(resBodyMap['detail']));
      }

      return Right(
        UserModel.fromMap(resBodyMap).copyWith(
          token: token,
        ),
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}