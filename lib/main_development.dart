import 'app/app.dart';
import 'bootstrap.dart';
import 'utils/service_locator.dart';

void main() {
  setUpServicesLocator();
  bootstrap(() => const App());
}
