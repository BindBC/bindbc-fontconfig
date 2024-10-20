
# BindBC-Fontconfig
This project provides a set of both static and dynamic bindings to [Fontconfig](https://www.freedesktop.org/wiki/Software/fontconfig/). They are compatible with `@nogc` and `nothrow`, and can be compiled with BetterC compatibility.

| Table of Contents |
|-------------------|
|[License](#license)|
|[Fontconfig documentation](#fontconfig-documentation)|
|[Quickstart guide](#quickstart-guide)|
|[Configurations](#configurations)|
|[Library versions](#library-versions)|

## License

BindBC-Fontconfig&mdash;as well as every other binding in the [BindBC project](https://github.com/BindBC)&mdash;is licensed under the [Boost Software License](https://www.boost.org/LICENSE_1_0.txt).

Bear in mind that you still need to abide by [Fontconfig's license](https://gitlab.freedesktop.org/fontconfig/fontconfig/-/blob/main/COPYING) if you use it through these bindings.

## Fontconfig documentation
This readme describes how to use BindBC-Fontconfig, *not* Fontconfig itself.

## Quickstart guide
To use BindBC-Fontconfig in your dub project, add it to the list of `dependencies` in your dub configuration file. The easiest way is by running `dub add bindbc-fontconfig` in your project folder. The result should look something like this:

Example __dub.json__
```json
"dependencies": {
	"bindbc-fontconfig": "~>1.0",
},
```
Example __dub.sdl__
```sdl
dependency "bindbc-fontconfig" version="~>1.0"
```

If you want to use Fontconfig's FreeType 2 support, you'll have to add the submodule `:freetype` as a dependency as well:

Example __dub.json__
```json
"dependencies": {
	"bindbc-fontconfig": "~>1.0",
	"bindbc-fontconfig:freetype": "~>1.0",
},
```
Example __dub.sdl__
```sdl
dependency "bindbc-fontconfig" version="~>1.0"
dependency "bindbc-fontconfig:freetype" version="~>1.0"
```

By default, BindBC-Fontconfig is configured to compile as a dynamic binding that is not BetterC-compatible. If you prefer static bindings or need BetterC compatibility, they can be enabled via `subConfigurations` in your dub configuration file. For configuration naming & more details, see [Configurations](#configurations).

Example __dub.json__
```json
"subConfigurations": {
	"bindbc-fontconfig": "staticBC",
},
```
Example __dub.sdl__
```sdl
subConfiguration "bindbc-fontconfig" "staticBC"
```

If you need to use versions of Fontconfig newer than 1.15.0, then you will have to add the appropriate version identifier to `versions` in your dub configuration. For a list of library version identifiers, see [Library versions](#library-versions).

If you're using static bindings, then you will also need to add the name of the Fontconfig library to `libs`.

Example __dub.json__
```json
"versions": [
	"Fc_1_16_0",
],
"libs": [
	"fontconfig",
],
```
Example __dub.sdl__
```sdl
versions "Fc_`1_16_0"
libs "fontconfig"
```

**If you're using static bindings**: `import bindbc.fontconfig` in your code, and then you can use all of Fontconfig just like you would in C. That's it!
```d
import bindbc.fontconfig;

void main(){
	FcConfig* config = FcConfigCreate();
	
	//etc.
	
	FcConfigDestroy(config);
}
```

**If you're using dynamic bindings**: you need to load each library you need with the appropriate load function. `loadFontconfig` for Fontconfig, or `loadFontconfigFreeType` for Fontconfig FreeType.

For most use cases, it's best to use BindBC-Loader's [error handling API](https://github.com/BindBC/bindbc-loader#error-handling) to see if there were any errors while loading the library. This information can be written to a log file before aborting the program.

The load function will also return a member of the `LoadMsg` enum, which can be used for debugging:

* `noLibrary` means the library couldn't be found.
* `badLibrary` means there was an error while loading the library.
* `success` means that the library was loaded without any errors.

Here's a simple example using only the load function's return value:

```d
import bindbc.fontconfig;
import bindbc.loader;

/*
This code attempts to load the Fontconfig shared library using
well-known variations of the library name for the host system.
*/
LoadMsg ret = loadFontconfig();
if(ret != LoadMsg.success){
	/*
	Error handling. For most use cases, it's best to use the error handling API in
	BindBC-Loader to retrieve error messages for logging and then abort.
	If necessary, it's possible to determine the root cause via the return value:
	*/
	if(ret == LoadMsg.noLibrary){
		//The Fontconfig shared library failed to load
	}else if(ret == LoadMsg.badLibrary){
		//One or more symbols failed to load.
	}
}

/*
This code attempts to load Fontconfig using a user-supplied file name.
Usually, the name and/or path used will be platform specific, as in this
example which attempts to load `fontconfig.dll` from the `libs` subdirectory,
relative to the executable, only on Windows.
*/
version(Windows) loadFontconfig("libs/fontconfig.dll");
```

[The error handling API](https://github.com/BindBC/bindbc-loader#error-handling) in BindBC-Loader can be used to log error messages:
```d
import bindbc.fontconfig;

/*
Import the sharedlib module for error handling. Assigning an alias ensures that the
function names do not conflict with other public APIs. This isn't strictly necessary,
but the API names are common enough that they could appear in other packages.
*/
import loader = bindbc.loader.sharedlib;

bool loadLib(){
	LoadMsg ret = loadFontconfig();
	if(ret != LoadMsg.success){
		//Log the error info
		foreach(info; loader.errors){
			/*
			A hypothetical logging function. Note that `info.error` and
			`info.message` are `const(char)*`, not `string`.
			*/
			logError(info.error, info.message);
		}
		
		//Optionally construct a user-friendly error message for the user
		string msg;
		if(ret == LoadMsg.noLibrary){
			msg = "This application requires the Fontconfig library.";
		}else{
			const(char)* version_ = FcGetVersion();
			msg = "Your Fontconfig version is too low: "~
				itoa(version_ / 10_000)~"."~
				itoa(version_ / 100 % 100)~"."~
				itoa(version_       % 100)~
				". Please upgrade to 1.16.0+.";
		}
		//A hypothetical message box function
		showMessageBox(msg);
		return false;
	}
	return true;
}
```

## Configurations
BindBC-Fontconfig has the following configurations:

|      ┌      |  DRuntime  |   BetterC   |
|-------------|------------|-------------|
| **Dynamic** | `dynamic`  | `dynamicBC` |
| **Static**  | `static`   | `staticBC`  |

For projects that don't use dub, if BindBC-Fontconfig is compiled for static bindings then the version identifier `BindFc_Static` must be passed to your compiler when building your project.

> [!NOTE]\
> The version identifier `BindBC_Static` can be used to configure all of the _official_ BindBC packages used in your program. (i.e. those maintained in [the BindBC GitHub organisation](https://github.com/BindBC)) Some third-party BindBC packages may support it as well.

### Dynamic bindings
The dynamic bindings have no link-time dependency on Fontconfig, so the Fontconfig shared library must be manually loaded at runtime from the shared library search path of the user's system.
On Windows, this is typically handled by distributing the Fontconfig DLLs with your program.
On other systems, it usually means installing the Fontconfig shared library through a package manager.

The function `isFontconfigLoaded` returns `true` if any version of the shared library has been loaded and `false` if not. `unloadFontconfig` can be used to unload a successfully loaded shared library.

### Static bindings
Static _bindings_ do not require static _linking_. The static bindings have a link-time dependency on either the shared _or_ static Fontconfig library. On Windows, you can link with the static library or, to use the DLLs, the import library. On other systems, you can link with either the static library or directly with the shared library.

When linking with the shared (or import) library, there is a runtime dependency on the shared library just as there is when using the dynamic bindings. The difference is that the shared library are no longer loaded manually&mdash;loading is handled automatically by the system when the program is launched. Attempting to call `loadFontconfig` with the static bindings enabled will result in a compilation error.

Static linking requires Fontconfig's development packages be installed on your system. The [Fontconfig releases](https://www.freedesktop.org/software/fontconfig/release/) provide the library's source code. You can also install them via your system's package manager. For example, on Debian-based Linux distributions `sudo apt install libfontconfig-dev` will install both the development and runtime packages for the Fontconfig library.

When linking with the static library, there is no runtime dependency on Fontconfig.

## Library Versions

| Version |Version identifier|
|---------|------------------|
| 1.15.0  | (none; default)  |
