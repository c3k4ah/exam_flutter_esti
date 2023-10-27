// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class Failure extends Equatable {
  final String message;
  const Failure({this.message = "Une erreur s'est produit"});

  @override
  List<Object?> get props => [message];
}

class InternetFailure extends Failure {
  const InternetFailure({super.message = 'Veuillez verifier votre connexion'});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message = 'Une erreur s\'est produite'});
}

Failure authError(String code) {
  switch (code) {
    case 'user-not-found':
      return Failure(message: 'user_not_found'.tr);
    case 'wrong-password':
      return Failure(message: 'wrong_password'.tr);
    case 'invalid-email':
      return Failure(message: 'invalid_email'.tr);
    case 'weak-password':
      return Failure(message: 'weak_password'.tr);
    case 'email-already-in-use':
      return Failure(message: 'email_already_in_use'.tr);
    case 'too-many-requests':
      return Failure(message: 'too_many_requests'.tr);
    case 'operation-not-allowed':
      return Failure(message: 'operation_not_allowed'.tr);
    case 'account-exists-with-different-credential':
      return Failure(message: 'account_already_exists_with_same_email'.tr);
    default:
      return Failure(message: 'unknown_error'.tr);
  }
}
