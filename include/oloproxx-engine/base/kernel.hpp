#pragma once

#define MACRO_INTERFACE_NAME( name )                                                                                                                 \
public:                                                                                                                                              \
	static constexpr const char* InterfaceName( ) noexcept                                                                                       \
	{                                                                                                                                            \
		return #name;                                                                                                                        \
	}                                                                                                                                            \
                                                                                                                                                     \
private:

#include <string_view>

namespace engine::kernel
{
	template< class T > constexpr bool	       InterfaceEnable = false;
	template< class T > constexpr std::string_view InterfaceName   = "None";
} // namespace engine::kernel

#define MACRO_CREATE_API_CLASS( classname, ... )                                                                                                     \
	class classname;                                                                                                                             \
	template<> constexpr bool	      engine::kernel::InterfaceEnable< class classname > = true;                                             \
	template<> constexpr std::string_view engine::kernel::InterfaceName< class classname >	 = #classname;                                       \
	class API			      classname
