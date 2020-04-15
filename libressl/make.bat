@ECHO OFF

@ECHO Building for x64
cmake -G "Visual Studio 16 2019" -DUSE_STATIC_MSVC_RUNTIMES=ON -DLIBRESSL_APPS=OFF -DLIBRESSL_TESTS=OFF -A x64 -T v141_xp -S . -B build\x64 -Wno-dev
cmake --build build\x64 --config Release --clean-first
move /Y build\x64\ssl\Release\ssl*.lib output\x64
move /Y build\x64\tls\Release\tls*.lib output\x64
move /Y build\x64\crypto\Release\crypto*.lib output\x64

@ECHO Building for x86
cmake -G "Visual Studio 16 2019" -DUSE_STATIC_MSVC_RUNTIMES=ON -DLIBRESSL_APPS=OFF -DLIBRESSL_TESTS=OFF -A Win32 -T v141_xp -S . -B build\x86 -Wno-dev
cmake --build build\x86 --config Release --clean-first
move /Y build\x86\ssl\Release\ssl*.lib output\x86
move /Y build\x86\tls\Release\tls*.lib output\x86
move /Y build\x86\crypto\Release\crypto*.lib output\x86

:END

