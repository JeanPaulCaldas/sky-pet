import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.I;

@InjectableInit(initializerName: r'$initGetIt')
void configureDependencies() => $initGetIt(getIt);
