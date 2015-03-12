-- Accidental Noise Library
-- premake4.lua

-- Set pat to lua library and headers
-- Alternatively, specify on the command-line
local lualib="C:/Users/Joshua/Documents/Projects/lua-5.2.4/src"
local luaheader="C:/Users/Joshua/Documents/Projects/lua-5.2.4/src"

solution "ANL"
	configurations {"Debug", "Release"}
	--platforms {"x32", "x64"}
	location "../build"
	
	configuration "Debug"
		defines { "DEBUG" }
		flags { "Symbols" }

	configuration "Release"
		defines { "NDEBUG" }
		flags "Optimize"
		
	configuration {}
	
	--[[project "toluapp"
		kind "StaticLib"
		location "../build/toluapp"
		targetdir "../build/toluapp"
		language "C"
		includedirs "ThirdParty/toluapp/include"
		includedirs(_OPTIONS["luaheader"] or luaheader)
		libdirs(_OPTIONS["lualib"] or lualib)
		files {"ThirdParty/toluapp/src/lib/*.h", "ThirdParty/toluapp/src/lib/*.c"} ]]
		
		project "tolua"
		kind "StaticLib"
		location "../build/tolua"
		targetdir "../build/tolua"
		language "C"
		includedirs "ThirdParty/tolua-5.2/include"
		includedirs(_OPTIONS["luaheader"] or luaheader)
		libdirs(_OPTIONS["lualib"] or lualib)
		files {"ThirdParty/tolua-5.2/src/lib/*.h", "ThirdParty/tolua-5.2/src/lib/*.c"}
	
	project "ANLLib"
		kind "StaticLib"
		location "../build/ANL"
		targetdir "../build/ANL"
		language "C++"
		if _ACTION=="gmake" then
			buildoptions "-std=c++11"
		end
		
		files {"VM/*.h", "VM/*.cpp", "Imaging/*.h", "Imaging/*.cpp", "Imaging/*.c", "templates/*.h", "vectortypes.h"}

	project "Framework"
		kind "ConsoleApp"
		location "../build/Bin"
		targetdir "../build/Bin"
		language "C++"
		if _ACTION=="gmake" then
			buildoptions "-std=c++11"
		end
		
		includedirs(_OPTIONS["luaheader"] or luaheader)
		includedirs "ThirdParty/tolua-5.2/include"
		includedirs "ThirdParty/oolua/include"
		libdirs(_OPTIONS["lualib"] or lualib)
		
		files {"Framework/*.cpp", "Bindings/bind_anl.cpp"}
		links {"ANLLib", "tolua", "lua"}

		
		
		