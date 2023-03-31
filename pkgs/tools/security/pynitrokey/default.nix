{ python3Packages, lib, nrfutil, libnitrokey }:

with python3Packages;

buildPythonApplication rec {
  pname = "pynitrokey";
  version = "0.4.35";
  format = "flit";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-j36AQGhSJJ8T5izRCHg/VMUtCbKcFUZctspIS/uHsK0=";
  };

  propagatedBuildInputs = [
    certifi
    cffi
    click
    cryptography
    ecdsa
    frozendict
    fido2
    intelhex
    nkdfu
    python-dateutil
    pyusb
    requests
    spsdk
    tqdm
    urllib3
    tlv8
    typing-extensions
    protobuf
  ];

  nativeBuildInputs = [
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "cryptography"
    "python-dateutil"
    "spsdk"
    "typing_extensions"
    "protobuf"
  ];

  # libnitrokey is not propagated to users of pynitrokey
  # It is only usable from the wrapped bin/nitropy
  makeWrapperArgs = [
    "--set LIBNK_PATH ${lib.makeLibraryPath [ libnitrokey ]}"
  ];

  # no tests
  doCheck = false;

  pythonImportsCheck = [ "pynitrokey" ];

  meta = with lib; {
    description = "Python client for Nitrokey devices";
    homepage = "https://github.com/Nitrokey/pynitrokey";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ frogamic ];
    mainProgram = "nitropy";
  };
}
