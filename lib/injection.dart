import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_pet/injection.config.dart';

final getIt = GetIt.I;

@InjectableInit(initializerName: r'$initGetIt')
void configureDependencies() => $initGetIt(getIt);
