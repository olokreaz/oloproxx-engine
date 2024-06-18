#pragma once
#include "kernel.hpp"
#include <engine/base/config.hpp>

#include <spdlog/async_logger.h>
#include <spdlog/sinks/daily_file_sink.h>
#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/spdlog.h>

#include <memory>
#include <string>

namespace engine::kernel
{
	template< class T > struct logging {
		static constexpr auto kName = [] { return std::string_view( typeid( T ).name( ) ).substr( sizeof "class" ); };
	};
} // namespace engine::kernel

namespace engine::logging
{
	class Logger
	{
		spdlog::sink_ptr _sink_cout;
		spdlog::sink_ptr _sink_file;

		void _init( )
		{
			if ( _sink_cout ) {
				_sink_cout = std::make_shared< spdlog::sinks::stdout_color_sink_mt >( );
				_sink_cout->set_pattern( config::logging::kPattern );
			}
			if ( _sink_file ) {
				using namespace config;
				_sink_file = std::make_shared< spdlog::sinks::daily_file_sink_mt >( std::string( config::logging::kDir ) +
														    app::kName + ".log",
												    23,
												    59 );
				_sink_file->set_pattern( config::logging::kPattern );
			}
		}

	public:
		static std::shared_ptr< spdlog::logger > create( std::string_view name, bool bDefault )
		{
			if ( auto ca = spdlog::get( name.data( ) ); ca ) return ca;
			auto logger = spdlog::create< spdlog::logger >( name.data( ) );
			logger->sinks( ).clear( );
			logger->sinks( ).push_back( instance( )->_sink_cout );
			logger->sinks( ).push_back( instance( )->_sink_file );

			logger->set_level( spdlog::level::trace );
			spdlog::register_logger( logger );

			if ( bDefault ) spdlog::set_default_logger( logger );

			return logger;
		}
		static auto instance( )
		{
			static Logger instance;
			return &instance;
		}
	}; // namespace engine::logging
} // namespace engine::logging
