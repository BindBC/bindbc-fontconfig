/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module fc.freetype;

import bindbc.fontconfig.config;
import bindbc.fontconfig.codegen;

import fc;
import bindbc.freetype;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{uint}, q{FcFreeTypeCharIndex}, q{FT_Face face, dchar ucs4}},
		{q{FcCharSet*}, q{FcFreeTypeCharSetAndSpacing}, q{FT_Face face, FcBlanks* blanks, int* spacing}},
		{q{FcCharSet*}, q{FcFreeTypeCharSet}, q{FT_Face face, FcBlanks* blanks}},
		{q{FcResult}, q{FcPatternGetFTFace}, q{const(FcPattern)* p, const(byte)* object, int n, FT_Face* f}},
		{q{FcBool}, q{FcPatternAddFTFace}, q{FcPattern* p, const(byte)* object, const FT_Face f}},
		{q{FcPattern*}, q{FcFreeTypeQueryFace}, q{const FT_Face face, const(char)* file, uint id, FcBlanks* blanks}},
	];
	return ret;
}()));

static if(!bindbc.fontconfig.config.staticBinding):
import bindbc.loader;

mixin(makeDynloadFns("FontconfigFreeType", makeLibPaths(["fontconfig"]), [__MODULE__]));
