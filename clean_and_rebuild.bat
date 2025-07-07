@echo off
echo Limpando projeto Flutter...
flutter clean
echo.
echo Obtendo dependências...
flutter pub get
echo.
echo Limpando cache do Gradle...
cd android
gradlew clean
cd ..
echo.
echo Projeto limpo e pronto para reconstruir!
echo Execute 'flutter run' para testar.
pause 