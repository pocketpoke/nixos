{
  python3Packages,
  fetchurl,
  lib,
}:
python3Packages.buildPythonPackage {
  pname = "patchright";
  version = "1.58.0";
  format = "wheel";
  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/ea/86/98d8f42d5186b6864144fb25e21da8aa7cffa5b9d1d76752276610b9ea58/patchright-1.58.0-py3-none-manylinux1_x86_64.whl";
    hash = "sha256-gyvuL+SM+dwHuzsPDQXu6SMgPzSM2YsUwsUV7s4yZzQ=";
  };
  propagatedBuildInputs = with python3Packages; [
    greenlet
    pyee
    typing-extensions
  ];
  doCheck = false;
  meta = with lib; {
    description = "Patched and undetected version of Playwright";
    homepage = "https://github.com/Kaliiiiiiiiii-Vinyzu/patchright-python";
    license = licenses.asl20;
  };
}
