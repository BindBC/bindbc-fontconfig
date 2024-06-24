/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module bindbc.fontconfig.config;

public import bindbc.common.types: va_list;
public import bindbc.common.versions: Version;

enum staticBinding = (){
	version(BindBC_Static)              return true;
	else version(BindFc_Static) return true;
	else return false;
}();

enum cStyleEnums = (){
	version(Fc_D_Enums_Only) return false;
	else return true;
}();

enum dStyleEnums = (){
	version(Fc_C_Enums_Only) return false;
	else return true;
}();

enum fcVersion = (){
	version(none)          return Version(2,17,0);
	else version(none)     return Version(2,16,0);
	else                   return Version(2,15,0);
}();
