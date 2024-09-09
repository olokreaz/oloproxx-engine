# Dependencies

This project, `oloproxx-engine`, relies on several third-party libraries. Most of them can be installed via [vcpkg](https://github.com/microsoft/vcpkg), while others require manual installation or linking to their SDKs.

## Installing Dependencies via vcpkg

To install the majority of the dependencies via vcpkg, run the following command:

```bash
vcpkg install glm fmt cpr ctre nlohmann-json scnlib ms-gsl functionalplus ipaddress libsigcpp leveldb ffmpeg spdlog vulkan glfw3 unofficial-gainput gtest
```

This command installs the following libraries:

- **glm**: A header-only C++ mathematics library for graphics software.
- **fmt**: A modern formatting library for C++.
- **cpr**: A simple HTTP client library for C++.
- **ctre**: Compile-time regular expressions for C++.
- **nlohmann-json**: A JSON library for C++.
- **scnlib**: A modern, type-safe, and extensible C++ input library.
- **ms-gsl**: Guidelines Support Library, including `stduuid`.
- **FunctionalPlus**: A functional programming library for C++.
- **ipaddress**: A C++ library to manipulate IP addresses.
- **libsigcpp**: A library that implements a typesafe callback system for standard C++.
- **leveldb**: A fast key-value storage library.
- **ffmpeg**: A complete, cross-platform solution to record, convert, and stream audio and video.
- **spdlog**: A very fast, header-only/compiled, C++ logging library.
- **vulkan**: A modern, low-level graphics API.
- **glfw3**: A multi-platform library for OpenGL, OpenGL ES, and Vulkan development.
- **unofficial-gainput**: A multi-platform input library for games.
- **gtest**: Google Test, a unit testing library for C++.

## Additional Dependencies

Some dependencies require manual installation or linking to their respective SDKs:

- **CMakeRC**: A CMake module required for the build. Manual setup is needed. [CMakeRC GitHub](https://github.com/vector-of-bool/cmrc)
- **alpaca**: A C++ serialization library. Requires manual setup. [alpaca GitHub](https://github.com/p-ranav/alpaca)
- **libassert**: A small assertion library for C++. Manual installation required. [libassert GitHub](https://github.com/david-grs/libassert)
- **frozen**: A header-only, constexpr alternative to std::unordered_map. Manual installation required. [frozen GitHub](https://github.com/serge-sans-paille/frozen)
- **Steamworks SDK**: Required for Steam integration. Download the SDK from [Steamworks SDK](https://partner.steamgames.com/doc/sdk).
- **Steam Audio SDK**: Required for advanced audio processing. Download the SDK from [Steam Audio](https://valvesoftware.github.io/steam-audio/).
- **FMOD SDK**: Required for audio implementation. Download the SDK from [FMOD](https://www.fmod.com/download).
- **UltraLight SDK**: Required for GUI rendering. Download the SDK from [UltraLight](https://ultralig.ht/).

## Setting Up the SDKs

After downloading the SDKs, ensure that you set the appropriate environment variables in your system:

```bash
export UL_SDK=<path_to_ultralight_sdk>
export STEAM_SDK=<path_to_steamworks_sdk>
export STEAM_AUDIO=<path_to_steam_audio_sdk>
export FMOD_SDK=<path_to_fmod_sdk>
```

These variables will be used by CMake during the build process to locate the necessary libraries and headers.

## Building the Project

Once all dependencies are installed and SDKs are set up, you can proceed with building the project:

```bash
cmake -S . -B build
cmake --build build
```

This will generate the necessary binaries in the `build` directory.

## Testing

To run tests, ensure that `GTest` is installed (as it is included in the vcpkg dependencies) and then use the following command:

```bash
ctest --output-on-failure
```

This will execute all tests defined in the project.

---

If you encounter any issues with the setup or have questions, please refer to the documentation of the respective libraries or SDKs linked above.
