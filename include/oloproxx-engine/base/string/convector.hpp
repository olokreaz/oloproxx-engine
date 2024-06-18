#pragma once
#include <algorithm>
#include <codecvt>
#include <locale>
#include <ranges>

namespace utils
{
	inline std::wstring string_to_wstring( const std::string& str )
	{
		std::wstring_convert< std::codecvt_utf8< wchar_t >, wchar_t > converter;
		return converter.from_bytes( str );
	}

	inline std::string wstring_to_string( const std::wstring& wstr )
	{
		std::wstring_convert< std::codecvt_utf8< wchar_t >, wchar_t > converter;
		return converter.to_bytes( wstr );
	}

	template< typename CharT > std::basic_string< CharT > to_upper( const std::basic_string< CharT >& str )
	{
		std::basic_string< CharT > result = str;
		std::ranges::transform( result, result.begin( ), ::toupper );
		return result;
	}

	template< typename CharT > inline std::basic_string< CharT > to_lower( const std::basic_string< CharT >& str )
	{
		std::basic_string< CharT > result = str;
		std::ranges::transform( result, result.begin( ), ::tolower );
		return result;
	}

} // namespace utils
