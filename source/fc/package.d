/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module fc;

import bindbc.fontconfig.config;
import bindbc.fontconfig.codegen;

alias FcBool = int;

enum{
	FC_MAJOR     = fcVersion.major,
	FC_MINOR     = fcVersion.minor,
	FC_REVISION  = fcVersion.patch,
}

enum FC_VERSION	= (FC_MAJOR*  10000) + (FC_MINOR*  100) + FC_REVISION;

enum FC_CACHE_VERSION_NUMBER = 9;
enum FC_CACHE_VERSION = "9";

enum{
	FcFalse    = 0,
	FcTrue     = 1,
	FcDontCare = 2,
}

enum{
	FC_FAMILY                     = "family",
	FC_STYLE                      = "style",
	FC_SLANT                      = "slant",
	FC_WEIGHT                     = "weight",
	FC_SIZE                       = "size",
	FC_ASPECT                     = "aspect",
	FC_PIXEL_SIZE                 = "pixelsize",
	FC_SPACING                    = "spacing",
	FC_FOUNDRY                    = "foundry",
	FC_ANTIALIAS                  = "antialias",
	FC_HINTING                    = "hinting",
	FC_HINT_STYLE                 = "hintstyle",
	FC_VERTICAL_LAYOUT            = "verticallayout",
	FC_AUTOHINT                   = "autohint",
	deprecated FC_GLOBAL_ADVANCE  = "globaladvance",
	FC_WIDTH                      = "width",
	FC_FILE                       = "file",
	FC_INDEX                      = "index",
	FC_FT_FACE                    = "ftface",
	deprecated FC_RASTERISER      = "rasterizer",
	deprecated FC_RASTERIZER      = "rasterizer",
	FC_OUTLINE                    = "outline",
	FC_SCALABLE                   = "scalable",
	FC_COLOUR                     = "color",
	FC_COLOR                      = "color",
	FC_VARIABLE                   = "variable",
	deprecated FC_SCALE           = "scale",
	FC_SYMBOL                     = "symbol",
	FC_DPI                        = "dpi",
	FC_RGBA                       = "rgba",
	FC_MINSPACE                   = "minspace",
	deprecated FC_SOURCE          = "source",
	FC_CHARSET                    = "charset",
	FC_LANG                       = "lang",
	FC_FONTVERSION                = "fontversion",
	FC_FULLNAME                   = "fullname",
	FC_FAMILYLANG                 = "familylang",
	FC_STYLELANG                  = "stylelang",
	FC_FULLNAMELANG               = "fullnamelang",
	FC_CAPABILITY                 = "capability",
	FC_FONTFORMAT                 = "fontformat",
	FC_EMBOLDEN                   = "embolden",
	FC_EMBEDDED_BITMAP            = "embeddedbitmap",
	FC_DECORATIVE                 = "decorative",
	FC_LCD_FILTER                 = "lcdfilter",
	FC_FONT_FEATURES              = "fontfeatures",
	FC_FONT_VARIATIONS            = "fontvariations",
	FC_NAMELANG                   = "namelang",
	FC_PRGNAME                    = "prgname",
	deprecated FC_HASH            = "hash",
	FC_POSTSCRIPT_NAME            = "postscriptname",
	FC_FONT_HAS_HINT              = "fonthashint",
	FC_ORDER                      = "order",
	FC_DESKTOP_NAME               = "desktop",
	FC_NAMED_INSTANCE             = "namedinstance",
	FC_FONT_WRAPPER               = "fontwrapper",
}

enum{
	FC_CACHE_SUFFIX     = ".cache-" ~ FC_CACHE_VERSION,
	FC_DIR_CACHE_FILE   = "fonts.cache-" ~ FC_CACHE_VERSION,
	FC_USER_CACHE_FILE  = ".fonts.cache-" ~ FC_CACHE_VERSION,
}

enum{
	FC_CHARWIDTH    = "charwidth",
	FC_CHAR_WIDTH   = FC_CHARWIDTH,
	FC_CHAR_HEIGHT  = "charheight",
	FC_MATRIX       = "matrix",
}

mixin(makeEnumBind(q{FcWeight}, members: (){
	EnumMember[] ret = [
		{{q{thin},        q{FC_WEIGHT_THIN}},        q{0}},
		{{q{extraLight},  q{FC_WEIGHT_EXTRALIGHT}},  q{40}, aliases: [{q{ultraLight}, q{FC_WEIGHT_ULTRALIGHT}}]},
		{{q{light},       q{FC_WEIGHT_LIGHT}},       q{50}},
		{{q{demiLight},   q{FC_WEIGHT_DEMILIGHT}},   q{55}, aliases: [{q{semiLight}, q{FC_WEIGHT_SEMILIGHT}}]},
		{{q{book},        q{FC_WEIGHT_BOOK}},        q{75}},
		{{q{regular},     q{FC_WEIGHT_REGULAR}},     q{80}, aliases: [{q{normal}, q{FC_WEIGHT_NORMAL}}]},
		{{q{medium},      q{FC_WEIGHT_MEDIUM}},      q{100}},
		{{q{demiBold},    q{FC_WEIGHT_DEMIBOLD}},    q{180}, aliases: [{q{semiBold}, q{FC_WEIGHT_SEMIBOLD}}]},
		{{q{bold},        q{FC_WEIGHT_BOLD}},        q{200}},
		{{q{extraBold},   q{FC_WEIGHT_EXTRABOLD}},   q{205}, aliases: [{q{ultraBold}, q{FC_WEIGHT_ULTRABOLD}}]},
		{{q{black},       q{FC_WEIGHT_BLACK}},       q{210}, aliases: [{q{heavy}, q{FC_WEIGHT_HEAVY}}]},
		{{q{extraBlack},  q{FC_WEIGHT_EXTRABLACK}},  q{215}, aliases: [{q{ultraBlack}, q{FC_WEIGHT_ULTRABLACK}}]},
	];
	return ret;
}()));

mixin(makeEnumBind(q{FcSlant}, members: (){
	EnumMember[] ret = [
		{{q{roman},    q{FC_SLANT_ROMAN}},    q{0}},
		{{q{italic},   q{FC_SLANT_ITALIC}},   q{100}},
		{{q{oblique},  q{FC_SLANT_OBLIQUE}},  q{110}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{FcWidth}, members: (){
	EnumMember[] ret = [
		{{q{ultraCondensed},  q{FC_WIDTH_ULTRACONDENSED}},  q{50}},
		{{q{extraCondensed},  q{FC_WIDTH_EXTRACONDENSED}},  q{63}},
		{{q{condensed},       q{FC_WIDTH_CONDENSED}},       q{75}},
		{{q{semiCondensed},   q{FC_WIDTH_SEMICONDENSED}},   q{87}},
		{{q{normal},          q{FC_WIDTH_NORMAL}},          q{100}},
		{{q{semiExpanded},    q{FC_WIDTH_SEMIEXPANDED}},    q{113}},
		{{q{expanded},        q{FC_WIDTH_EXPANDED}},        q{125}},
		{{q{extraExpanded},   q{FC_WIDTH_EXTRAEXPANDED}},   q{150}},
		{{q{ultraExpanded},   q{FC_WIDTH_ULTRAEXPANDED}},   q{200}},
	];
	return ret;
}()));

enum{
	FC_PROPORTIONAL  = 0,
	FC_DUAL          = 90,
	FC_MONO          = 100,
	FC_CHARCELL      = 110,
}

mixin(makeEnumBind(q{FcRGBA}, members: (){
	EnumMember[] ret = [
		{{q{UNKNOWN},  q{FC_RGBA_UNKNOWN}},  q{0}},
		{{q{RGB},      q{FC_RGBA_RGB}},      q{1}},
		{{q{BGR},      q{FC_RGBA_BGR}},      q{2}},
		{{q{VRGB},     q{FC_RGBA_VRGB}},     q{3}},
		{{q{VBGR},     q{FC_RGBA_VBGR}},     q{4}},
		{{q{NONE},     q{FC_RGBA_NONE}},     q{5}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{FcHint}, members: (){
	EnumMember[] ret = [
		{{q{none},    q{FC_HINT_NONE}},    q{0}},
		{{q{slight},  q{FC_HINT_SLIGHT}},  q{1}},
		{{q{medium},  q{FC_HINT_MEDIUM}},  q{2}},
		{{q{full},    q{FC_HINT_FULL}},    q{3}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{FcLCD}, members: (){
	EnumMember[] ret = [
		{{q{none},      q{FC_LCD_NONE}},     q{0}},
		{{q{default_},  q{FC_LCD_DEFAULT}},  q{1}},
		{{q{light},     q{FC_LCD_LIGHT}},    q{2}},
		{{q{legacy},    q{FC_LCD_LEGACY}},   q{3}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{FcType}, members: (){
	EnumMember[] ret = [
		{{q{unknown},  q{FcTypeUnknown}},  q{-1}},
		{{q{void_},    q{FcTypeVoid}}},
		{{q{integer},  q{FcTypeInteger}}},
		{{q{double_},  q{FcTypeDouble}}},
		{{q{string},   q{FcTypeString}}},
		{{q{bool_},    q{FcTypeBool}}},
		{{q{matrix},   q{FcTypeMatrix}}},
		{{q{charSet},  q{FcTypeCharSet}}},
		{{q{ftFace},   q{FcTypeFTFace}}},
		{{q{langSet},  q{FcTypeLangSet}}},
		{{q{range},    q{FcTypeRange}}},
	];
	return ret;
}()));

struct FcMatrix{
	double xx=1.0, xy=0.0, yx=0.0, yy=1.0;
}

struct FcCharSet;

struct FcObjectType{
	byte* object;
	FcType type;
}

struct FcConstant{
	const(char)* name;
	const(char)* object;
	int value;
}

mixin(makeEnumBind(q{FcResult}, members: (){
	EnumMember[] ret = [
		{{q{match},         q{FcResultMatch}}},
		{{q{noMatch},       q{FcResultNoMatch}}},
		{{q{typeMismatch},  q{FcResultTypeMismatch}}},
		{{q{noID},          q{FcResultNoId}}},
		{{q{outOfMemory},   q{FcResultOutOfMemory}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{FcValueBinding}, members: (){
	EnumMember[] ret = [
		{{q{weak},    q{FcValueBindingWeak}}},
		{{q{strong},  q{FcValueBindingStrong}}},
		{{q{same},    q{FcValueBindingSame}}},
		{{q{end},     q{FcValueBindingEnd}},  q{int.max}},
	];
	return ret;
}()));


struct FcPattern;

struct FcPatternIter{
	void* dummy1;
	void* dummy2;
}

struct FcLangSet;

struct FcRange;

struct FcValue{
	FcType type;
	union{
		const(char)* s;
		int i;
		FcBool b;
		double d;
		const(FcMatrix)* m;
		const(FcCharSet)* c;
		void* f;
		const(FcLangSet)* l;
		const(FcRange)* r;
	}
}

struct FcFontSet{
	int nFont;
	int sFont;
	alias nfont = nFont;
	alias sfont = sFont;
	FcPattern** fonts;
}

struct FcObjectSet{
	int nObject;
	int sObject;
	alias nobject = nObject;
	alias sobject = sObject;
	const(byte)** objects;
}

mixin(makeEnumBind(q{FcMatchKind}, aliases: [q{FcMatch}], members: (){
	EnumMember[] ret = [
		{{q{pattern},  q{FcMatchPattern}}, aliases: [{q{Begin}, q{FcMatchKindBegin}}]},
		{{q{font},     q{FcMatchFont}}},
		{{q{scan},     q{FcMatchScan}}},
		{{q{end},      q{FcMatchKindEnd}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{FcLangResult}, aliases: [q{FcLang}], members: (){
	EnumMember[] ret = [
		{{q{equal},               q{FcLangEqual}},               q{0}},
		{{q{differentCountry},    q{FcLangDifferentCountry}},    q{1}},
		{{q{differentTerritory},  q{FcLangDifferentTerritory}},  q{1}},
		{{q{differentLang},       q{FcLangDifferentLang}},       q{2}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{FcSetName}, aliases: [q{FcSet}], members: (){
	EnumMember[] ret = [
		{{q{system},       q{FcSetSystem}},       q{0}},
		{{q{application},  q{FcSetApplication}},  q{1}},
	];
	return ret;
}()));

struct FcConfigFileInfoIter{
	void* dummy1;
	void* dummy2;
	void* dummy3;
}

struct FcAtomic;

mixin(makeEnumBind(q{FcEndian}, members: (){
	EnumMember[] ret = [
		{{q{big},     q{FcEndianBig}}},
		{{q{little},  q{FcEndianLittle}}},
	];
	return ret;
}()));

struct FcConfig;

struct FcFileCache;

struct FcBlanks;

struct FcStrList;

struct FcStrSet;

struct FcCache;

enum FC_CHARSET_MAP_SIZE = 256 / 32;
enum FC_CHARSET_DONE = cast(dchar)-1;

pragma(inline,true) nothrow @nogc pure @safe{
	bool FcIsUpper(char c) => 0x41 <= c && c <= 0x5A;
	bool FcIsLower(char c) => 0x61 <= c && c <= 0x7A;
	char FcToLower(char c) => FcIsUpper(c) ? cast(char)(c - 0x41 + 0x61) : c;
}

enum FC_UTF8_MAX_LEN = 6;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{FcBlanks*}, q{FcBlanksCreate}, q{}},
		{q{void}, q{FcBlanksDestroy}, q{FcBlanks* b}},
		{q{FcBool}, q{FcBlanksAdd}, q{FcBlanks* b, dchar ucs4}},
		{q{FcBool}, q{FcBlanksIsMember}, q{FcBlanks* b, dchar ucs4}},
		{q{const(char)*}, q{FcCacheDir}, q{const(FcCache)* c}},
		{q{FcFontSet*}, q{FcCacheCopySet}, q{const(FcCache)* c}},
		{q{const(char)*}, q{FcCacheSubdir}, q{const(FcCache)* c, int i}},
		{q{int}, q{FcCacheNumSubdir}, q{const(FcCache)* c}},
		{q{int}, q{FcCacheNumFont}, q{const(FcCache)* c}},
		{q{FcBool}, q{FcDirCacheUnlink}, q{const(char)* dir, FcConfig* config}},
		{q{FcBool}, q{FcDirCacheValid}, q{const(char)* cacheFile}},
		{q{FcBool}, q{FcDirCacheClean}, q{const(char)* cacheDir, FcBool verbose}},
		{q{void}, q{FcCacheCreateTagFile}, q{FcConfig* config}},
		{q{FcBool}, q{FcDirCacheCreateUUID}, q{char* dir, FcBool force, FcConfig* config}},
		{q{FcBool}, q{FcDirCacheDeleteUUID}, q{const(char)* dir, FcConfig* config}},
		{q{char*}, q{FcConfigHome}, q{}},
		{q{FcBool}, q{FcConfigEnableHome}, q{FcBool enable}},
		{q{char*}, q{FcConfigGetFilename}, q{FcConfig* config, const(char)* url}},
		{q{char*}, q{FcConfigFilename}, q{const(char)* url}},
		{q{FcConfig*}, q{FcConfigCreate}, q{}},
		{q{FcConfig*}, q{FcConfigReference}, q{FcConfig* config}},
		{q{void}, q{FcConfigDestroy}, q{FcConfig* config}},
		{q{FcBool}, q{FcConfigSetCurrent}, q{FcConfig* config}},
		{q{FcConfig*}, q{FcConfigGetCurrent}, q{}},
		{q{FcBool}, q{FcConfigUptoDate}, q{FcConfig* config}},
		{q{FcBool}, q{FcConfigBuildFonts}, q{FcConfig* config}},
		{q{FcStrList*}, q{FcConfigGetFontDirs}, q{FcConfig* config}},
		{q{FcStrList*}, q{FcConfigGetConfigDirs}, q{FcConfig* config}},
		{q{FcStrList*}, q{FcConfigGetConfigFiles}, q{FcConfig* config}},
		{q{char*}, q{FcConfigGetCache}, q{FcConfig* config}},
		{q{FcBlanks*}, q{FcConfigGetBlanks}, q{FcConfig* config}},
		{q{FcStrList*}, q{FcConfigGetCacheDirs}, q{FcConfig* config}},
		{q{int}, q{FcConfigGetRescanInterval}, q{FcConfig* config}},
		{q{FcBool}, q{FcConfigSetRescanInterval}, q{FcConfig* config, int rescanInterval}},
		{q{FcFontSet*}, q{FcConfigGetFonts}, q{FcConfig* config, FcSetName set}},
		{q{FcBool}, q{FcConfigAppFontAddFile}, q{FcConfig* config, const(char)* file}},
		{q{FcBool}, q{FcConfigAppFontAddDir}, q{FcConfig* config, const(char)* dir}},
		{q{void}, q{FcConfigAppFontClear}, q{FcConfig* config}},
		{q{FcBool}, q{FcConfigSubstituteWithPat}, q{FcConfig* config, FcPattern* p, FcPattern* pPat, FcMatchKind kind}},
		{q{FcBool}, q{FcConfigSubstitute}, q{FcConfig* config, FcPattern* p, FcMatchKind kind}},
		{q{const(char)*}, q{FcConfigGetSysRoot}, q{const(FcConfig)* config}},
		{q{void}, q{FcConfigSetSysRoot}, q{FcConfig* config, const(char)* sysRoot}},
		{q{void}, q{FcConfigFileInfoIterInit}, q{FcConfig* config, FcConfigFileInfoIter* iter}},
		{q{FcBool}, q{FcConfigFileInfoIterNext}, q{FcConfig* config, FcConfigFileInfoIter* iter}},
		{q{FcBool}, q{FcConfigFileInfoIterGet}, q{FcConfig* config, FcConfigFileInfoIter* iter, char** name, char** description, FcBool* enabled}},
		{q{FcCharSet*}, q{FcCharSetCreate}, q{}},
		{q{void}, q{FcCharSetDestroy}, q{FcCharSet* fcs}},
		{q{FcBool}, q{FcCharSetAddChar}, q{FcCharSet* fcs, dchar ucs4}},
		{q{FcBool}, q{FcCharSetDelChar}, q{FcCharSet* fcs, dchar ucs4}},
		{q{FcCharSet*}, q{FcCharSetCopy}, q{FcCharSet* src}},
		{q{FcBool}, q{FcCharSetEqual}, q{const(FcCharSet)* a, const(FcCharSet)* b}},
		{q{FcCharSet*}, q{FcCharSetIntersect}, q{const(FcCharSet)* a, const(FcCharSet)* b}},
		{q{FcCharSet*}, q{FcCharSetUnion}, q{const(FcCharSet)* a, const(FcCharSet)* b}},
		{q{FcCharSet*}, q{FcCharSetSubtract}, q{const(FcCharSet)* a, const(FcCharSet)* b}},
		{q{FcBool}, q{FcCharSetMerge}, q{FcCharSet* a, const(FcCharSet)* b, FcBool* changed}},
		{q{FcBool}, q{FcCharSetHasChar}, q{const(FcCharSet)* fcs, dchar ucs4}},
		{q{dchar}, q{FcCharSetCount}, q{const(FcCharSet)* a}},
		{q{dchar}, q{FcCharSetIntersectCount}, q{const(FcCharSet)* a, const(FcCharSet)* b}},
		{q{dchar}, q{FcCharSetSubtractCount}, q{const(FcCharSet)* a, const(FcCharSet)* b}},
		{q{FcBool}, q{FcCharSetIsSubset}, q{const(FcCharSet)* a, const(FcCharSet)* b}},
		{q{dchar}, q{FcCharSetFirstPage}, q{const(FcCharSet)* a, dchar[FC_CHARSET_MAP_SIZE] map, dchar* next}},
		{q{dchar}, q{FcCharSetNextPage}, q{const(FcCharSet)* a, dchar[FC_CHARSET_MAP_SIZE] map, dchar* next}},
		{q{dchar}, q{FcCharSetCoverage}, q{const(FcCharSet)* a, dchar page, dchar* result}},
		{q{void}, q{FcValuePrint}, q{const FcValue v}},
		{q{void}, q{FcPatternPrint}, q{const(FcPattern)* p}},
		{q{void}, q{FcFontSetPrint}, q{const(FcFontSet)* s}},
		{q{FcStrSet*}, q{FcGetDefaultLangs}, q{}},
		{q{void}, q{FcDefaultSubstitute}, q{FcPattern* pattern}},
		{q{FcBool}, q{FcFileIsDir}, q{const(char)* file}},
		{q{FcBool}, q{FcFileScan}, q{FcFontSet* set, FcStrSet* dirs, FcFileCache* cache, FcBlanks* blanks, const(char)* file, FcBool force}},
		{q{FcBool}, q{FcDirScan}, q{FcFontSet* set, FcStrSet* dirs, FcFileCache* cache, FcBlanks* blanks, const(char)* dir, FcBool force}},
		{q{FcBool}, q{FcDirSave}, q{FcFontSet* set, FcStrSet* dirs, const(char)* dir}},
		{q{FcCache*}, q{FcDirCacheLoad}, q{const(char)* dir, FcConfig* config, char** cacheFile}},
		{q{FcCache*}, q{FcDirCacheRescan}, q{const(char)* dir, FcConfig* config}},
		{q{FcCache*}, q{FcDirCacheRead}, q{const(char)* dir, FcBool force, FcConfig* config}},
		{q{FcCache*}, q{FcDirCacheLoadFile}, q{const(char)* cacheFile, void* fileStat}},
		{q{void}, q{FcDirCacheUnload}, q{FcCache* cache}},
		{q{FcPattern*}, q{FcFreeTypeQuery}, q{const(char)* file, uint id, FcBlanks* blanks, int* count}},
		{q{uint}, q{FcFreeTypeQueryAll}, q{const(char)* file, uint id, FcBlanks* blanks, int* count, FcFontSet* set}},
		{q{FcFontSet*}, q{FcFontSetCreate}, q{}},
		{q{void}, q{FcFontSetDestroy}, q{FcFontSet* s}},
		{q{FcBool}, q{FcFontSetAdd}, q{FcFontSet* s, FcPattern* font}},
		{q{FcConfig*}, q{FcInitLoadConfig}, q{}},
		{q{FcConfig*}, q{FcInitLoadConfigAndFonts}, q{}},
		{q{FcBool}, q{FcInit}, q{}},
		{q{void}, q{FcFini}, q{}},
		{q{int}, q{FcGetVersion}, q{}},
		{q{FcBool}, q{FcInitReinitialize}, q{}, aliases: [q{FcInitReinitialise}]},
		{q{FcBool}, q{FcInitBringUptoDate}, q{}},
		{q{FcStrSet*}, q{FcGetLangs}, q{}},
		{q{char*}, q{FcLangNormalize}, q{const(char)* lang}, aliases: [q{FcLangNormalise}]},
		{q{const(FcCharSet)*}, q{FcLangGetCharSet}, q{const(char)* lang}},
		{q{FcLangSet*}, q{FcLangSetCreate}, q{}},
		{q{void}, q{FcLangSetDestroy}, q{FcLangSet* ls}},
		{q{FcLangSet*}, q{FcLangSetCopy}, q{const(FcLangSet)* ls}},
		{q{FcBool}, q{FcLangSetAdd}, q{FcLangSet* ls, const(char)* lang}},
		{q{FcBool}, q{FcLangSetDel}, q{FcLangSet* ls, const(char)* lang}},
		{q{FcLangResult}, q{FcLangSetHasLang}, q{const(FcLangSet)* ls, const(char)* lang}},
		{q{FcLangResult}, q{FcLangSetCompare}, q{const(FcLangSet)* lsa, const(FcLangSet)* lsb}},
		{q{FcBool}, q{FcLangSetContains}, q{const(FcLangSet)* lsa, const(FcLangSet)* lsb}},
		{q{FcBool}, q{FcLangSetEqual}, q{const(FcLangSet)* lsa, const(FcLangSet)* lsb}},
		{q{dchar}, q{FcLangSetHash}, q{const(FcLangSet)* ls}},
		{q{FcStrSet*}, q{FcLangSetGetLangs}, q{const(FcLangSet)* ls}},
		{q{FcLangSet*}, q{FcLangSetUnion}, q{const(FcLangSet)* a, const(FcLangSet)* b}},
		{q{FcLangSet*}, q{FcLangSetSubtract}, q{const(FcLangSet)* a, const(FcLangSet)* b}},
		{q{FcObjectSet*}, q{FcObjectSetCreate}, q{}},
		{q{FcBool}, q{FcObjectSetAdd}, q{FcObjectSet* os, const(char)* object}},
		{q{void}, q{FcObjectSetDestroy}, q{FcObjectSet* os}},
		{q{FcObjectSet*}, q{FcObjectSetVaBuild}, q{const(byte)* first, va_list va}},
		{q{FcObjectSet*}, q{FcObjectSetBuild}, q{const(byte)* first, ...}},
		{q{FcFontSet*}, q{FcFontSetList}, q{FcConfig* config, FcFontSet** sets, int nSets, FcPattern* p, FcObjectSet* os}},
		{q{FcFontSet*}, q{FcFontList}, q{FcConfig* config, FcPattern* p, FcObjectSet* os}},
		{q{FcAtomic*}, q{FcAtomicCreate}, q{const(char)* file}},
		{q{FcBool}, q{FcAtomicLock}, q{FcAtomic* atomic}},
		{q{char*}, q{FcAtomicNewFile}, q{FcAtomic* atomic}},
		{q{char*}, q{FcAtomicOrigFile}, q{FcAtomic* atomic}},
		{q{FcBool}, q{FcAtomicReplaceOrig}, q{FcAtomic* atomic}},
		{q{void}, q{FcAtomicDeleteNew}, q{FcAtomic* atomic}},
		{q{void}, q{FcAtomicUnlock}, q{FcAtomic* atomic}},
		{q{void}, q{FcAtomicDestroy}, q{FcAtomic* atomic}},
		{q{FcPattern*}, q{FcFontSetMatch}, q{FcConfig* config, FcFontSet** sets, int nSets, FcPattern* p, FcResult* result}},
		{q{FcPattern*}, q{FcFontMatch}, q{FcConfig* config, FcPattern* p, FcResult* result}},
		{q{FcPattern*}, q{FcFontRenderPrepare}, q{FcConfig* config, FcPattern* pat, FcPattern* font}},
		{q{FcFontSet*}, q{FcFontSetSort}, q{FcConfig* config, FcFontSet** sets, int nSets, FcPattern* p, FcBool trim, FcCharSet** csp, FcResult* result}},
		{q{FcFontSet*}, q{FcFontSort}, q{FcConfig* config, FcPattern* p, FcBool trim, FcCharSet** csp, FcResult* result}},
		{q{void}, q{FcFontSetSortDestroy}, q{FcFontSet* fs}},
		{q{FcMatrix*}, q{FcMatrixCopy}, q{const(FcMatrix)* mat}},
		{q{FcBool}, q{FcMatrixEqual}, q{const(FcMatrix)* mat1, const(FcMatrix)* mat2}},
		{q{void}, q{FcMatrixMultiply}, q{FcMatrix* result, const(FcMatrix)* a, const(FcMatrix)* b}},
		{q{void}, q{FcMatrixRotate}, q{FcMatrix* m, double c, double s}},
		{q{void}, q{FcMatrixScale}, q{FcMatrix* m, double sx, double sy}},
		{q{void}, q{FcMatrixShear}, q{FcMatrix* m, double sh, double sv}},
		{q{const(FcObjectType)*}, q{FcNameGetObjectType}, q{const(char)* object}},
		{q{const(FcConstant)*}, q{FcNameGetConstant}, q{const(char)* string}},
		{q{const(FcConstant)*}, q{FcNameGetConstantFor}, q{const(char)* string, const(char)* object}},
		{q{FcBool}, q{FcNameConstant}, q{const(char)* string, int* result}},
		{q{FcPattern*}, q{FcNameParse}, q{const(char)* name}},
		{q{char*}, q{FcNameUnparse}, q{FcPattern* pat}},
		{q{FcPattern*}, q{FcPatternCreate}, q{}},
		{q{FcPattern*}, q{FcPatternDuplicate}, q{const(FcPattern)* p}},
		{q{void}, q{FcPatternReference}, q{FcPattern* p}},
		{q{FcPattern*}, q{FcPatternFilter}, q{FcPattern* p, const(FcObjectSet)* os}},
		{q{void}, q{FcValueDestroy}, q{FcValue v}},
		{q{FcBool}, q{FcValueEqual}, q{FcValue va, FcValue vb}},
		{q{FcValue}, q{FcValueSave}, q{FcValue v}},
		{q{void}, q{FcPatternDestroy}, q{FcPattern* p}},
		{q{int}, q{FcPatternObjectCount}, q{const(FcPattern)* pat}},
		{q{FcBool}, q{FcPatternEqual}, q{const(FcPattern)* pa, const(FcPattern)* pb}},
		{q{FcBool}, q{FcPatternEqualSubset}, q{const(FcPattern)* pa, const(FcPattern)* pb, const(FcObjectSet)* os}},
		{q{dchar}, q{FcPatternHash}, q{const(FcPattern)* p}},
		{q{FcBool}, q{FcPatternAdd}, q{FcPattern* p, const(char)* object, FcValue value, FcBool append}},
		{q{FcBool}, q{FcPatternAddWeak}, q{FcPattern* p, const(char)* object, FcValue value, FcBool append}},
		{q{FcResult}, q{FcPatternGet}, q{const(FcPattern)* p, const(char)* object, int id, FcValue* v}},
		{q{FcResult}, q{FcPatternGetWithBinding}, q{const(FcPattern)* p, const(char)* object, int id, FcValue* v, FcValueBinding* b}},
		{q{FcBool}, q{FcPatternDel}, q{FcPattern* p, const(char)* object}},
		{q{FcBool}, q{FcPatternRemove}, q{FcPattern* p, const(char)* object, int id}},
		{q{FcBool}, q{FcPatternAddInteger}, q{FcPattern* p, const(char)* object, int i}},
		{q{FcBool}, q{FcPatternAddDouble}, q{FcPattern* p, const(char)* object, double d}},
		{q{FcBool}, q{FcPatternAddString}, q{FcPattern* p, const(char)* object, const(char)* s}},
		{q{FcBool}, q{FcPatternAddMatrix}, q{FcPattern* p, const(char)* object, const(FcMatrix)* s}},
		{q{FcBool}, q{FcPatternAddCharSet}, q{FcPattern* p, const(char)* object, const(FcCharSet)* c}},
		{q{FcBool}, q{FcPatternAddBool}, q{FcPattern* p, const(char)* object, FcBool b}},
		{q{FcBool}, q{FcPatternAddLangSet}, q{FcPattern* p, const(char)* object, const(FcLangSet)* ls}},
		{q{FcBool}, q{FcPatternAddRange}, q{FcPattern* p, const(char)* object, const(FcRange)* r}},
		{q{FcResult}, q{FcPatternGetInteger}, q{const(FcPattern)* p, const(char)* object, int n, int* i}},
		{q{FcResult}, q{FcPatternGetDouble}, q{const(FcPattern)* p, const(char)* object, int n, double* d}},
		{q{FcResult}, q{FcPatternGetString}, q{const(FcPattern)* p, const(char)* object, int n, char** s}},
		{q{FcResult}, q{FcPatternGetMatrix}, q{const(FcPattern)* p, const(char)* object, int n, FcMatrix** s}},
		{q{FcResult}, q{FcPatternGetCharSet}, q{const(FcPattern)* p, const(char)* object, int n, FcCharSet** c}},
		{q{FcResult}, q{FcPatternGetBool}, q{const(FcPattern)* p, const(char)* object, int n, FcBool* b}},
		{q{FcResult}, q{FcPatternGetLangSet}, q{const(FcPattern)* p, const(char)* object, int n, FcLangSet** ls}},
		{q{FcResult}, q{FcPatternGetRange}, q{const(FcPattern)* p, const(char)* object, int id, FcRange** r}},
		{q{FcPattern*}, q{FcPatternVaBuild}, q{FcPattern* p, va_list va}},
		{q{FcPattern*}, q{FcPatternBuild}, q{FcPattern* p, ...}},
		{q{char*}, q{FcPatternFormat}, q{FcPattern* pat, const(char)* format}},
		{q{FcRange*}, q{FcRangeCreateDouble}, q{double begin, double end}},
		{q{FcRange*}, q{FcRangeCreateInteger}, q{dchar begin, dchar end}},
		{q{void}, q{FcRangeDestroy}, q{FcRange* range}},
		{q{FcRange*}, q{FcRangeCopy}, q{const(FcRange)* r}},
		{q{FcBool}, q{FcRangeGetDouble}, q{const(FcRange)* range, double* begin, double* end}},
		{q{void}, q{FcPatternIterStart}, q{const(FcPattern)* pat, FcPatternIter* iter}},
		{q{FcBool}, q{FcPatternIterNext}, q{const(FcPattern)* pat, FcPatternIter* iter}},
		{q{FcBool}, q{FcPatternIterEqual}, q{const(FcPattern)* p1, FcPatternIter* i1, const(FcPattern)* p2, FcPatternIter* i2}},
		{q{FcBool}, q{FcPatternFindIter}, q{const(FcPattern)* pat, FcPatternIter* iter, const(char)* object}},
		{q{FcBool}, q{FcPatternIterIsValid}, q{const(FcPattern)* pat, FcPatternIter* iter}},
		{q{const(byte)*}, q{FcPatternIterGetObject}, q{const(FcPattern)* pat, FcPatternIter* iter}},
		{q{int}, q{FcPatternIterValueCount}, q{const(FcPattern)* pat, FcPatternIter* iter}},
		{q{FcResult}, q{FcPatternIterGetValue}, q{const(FcPattern)* pat, FcPatternIter* iter, int id, FcValue* v, FcValueBinding* b}},
		{q{int}, q{FcWeightFromOpenType}, q{int otWeight}},
		{q{double}, q{FcWeightFromOpenTypeDouble}, q{double otWeight}},
		{q{int}, q{FcWeightToOpenType}, q{int fcWeight}},
		{q{double}, q{FcWeightToOpenTypeDouble}, q{double fcWeight}},
		{q{char*}, q{FcStrCopy}, q{const(char)* s}},
		{q{char*}, q{FcStrCopyFilename}, q{const(char)* s}},
		{q{char*}, q{FcStrPlus}, q{const(char)* s1, const(char)* s2}},
		{q{void}, q{FcStrFree}, q{char* s}},
		{q{char*}, q{FcStrDowncase}, q{const(char)* s}},
		{q{int}, q{FcStrCmpIgnoreCase}, q{const(char)* s1, const(char)* s2}},
		{q{int}, q{FcStrCmp}, q{const(char)* s1, const(char)* s2}},
		{q{const(char)*}, q{FcStrStrIgnoreCase}, q{const(char)* s1, const(char)* s2}},
		{q{const(char)*}, q{FcStrStr}, q{const(char)* s1, const(char)* s2}},
		{q{int}, q{FcUtf8ToUcs4}, q{const(char)* srcOrig, dchar* dst, int len}},
		{q{FcBool}, q{FcUtf8Len}, q{const(char)* string, int len, int* nChar, int* wChar}},
		{q{int}, q{FcUcs4ToUtf8}, q{dchar ucs4, char[FC_UTF8_MAX_LEN] dest}},
		{q{int}, q{FcUtf16ToUcs4}, q{const(char)* srcOrig, FcEndian endian, dchar* dst, int len}},
		{q{FcBool}, q{FcUtf16Len}, q{const(char)* string, FcEndian endian, int len, int* nChar, int* wChar}},
		{q{char*}, q{FcStrBuildFilename}, q{const(char)* path, ...}},
		{q{char*}, q{FcStrDirname}, q{const(char)* file}},
		{q{char*}, q{FcStrBasename}, q{const(char)* file}},
		{q{FcStrSet*}, q{FcStrSetCreate}, q{}},
		{q{FcBool}, q{FcStrSetMember}, q{FcStrSet* set, const(char)* s}},
		{q{FcBool}, q{FcStrSetEqual}, q{FcStrSet* sa, FcStrSet* sb}},
		{q{FcBool}, q{FcStrSetAdd}, q{FcStrSet* set, const(char)* s}},
		{q{FcBool}, q{FcStrSetAddFilename}, q{FcStrSet* set, const(char)* s}},
		{q{FcBool}, q{FcStrSetDel}, q{FcStrSet* set, const(char)* s}},
		{q{void}, q{FcStrSetDestroy}, q{FcStrSet* set}},
		{q{FcStrList*}, q{FcStrListCreate}, q{FcStrSet* set}},
		{q{void}, q{FcStrListFirst}, q{FcStrList* list}},
		{q{char*}, q{FcStrListNext}, q{FcStrList* list}},
		{q{void}, q{FcStrListDone}, q{FcStrList* list}},
		{q{FcBool}, q{FcConfigParseAndLoad}, q{FcConfig* config, const(char)* file, FcBool complain}},
		{q{FcBool}, q{FcConfigParseAndLoadFromMemory}, q{FcConfig* config, const(char)* buffer, FcBool complain}},
	];
	return ret;
}()));

static if(!staticBinding):
import bindbc.loader;

mixin(makeDynloadFns("Fontconfig", makeLibPaths(["fontconfig"]), [__MODULE__]));
