import 'failure.dart';

class GoogleAuthFailure extends Failure {
  const GoogleAuthFailure(
      {super.message =
          'Impossible de se connecter à google\n Veuillez verifier votre connexion internet'});
}
