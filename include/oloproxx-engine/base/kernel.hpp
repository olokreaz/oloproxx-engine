//    Copyright 2024 olokreZ ( Долгополов Василий Васильевич | Dolgopolov Vasily Vasilievich )
//
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//
//        http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

#pragma once

#define LOGT( ... ) SPDLOG_LOGGER_TRACE( this->m_logger, __VA_ARGS__ );
#define LOGI( ... ) SPDLOG_LOGGER_INFO( this->m_logger, __VA_ARGS__ );
#define LOGD( ... ) SPDLOG_LOGGER_DEBUG( this->m_logger, __VA_ARGS__ );
#define LOGW( ... ) SPDLOG_LOGGER_WARN( this->m_logger, __VA_ARGS__ );
#define LOGE( ... ) SPDLOG_LOGGER_ERROR( this->m_logger, __VA_ARGS__ );
#define LOGC( ... ) SPDLOG_LOGGER_CRITICAL( this->m_logger, __VA_ARGS__ );

namespace base {

}    // namespace base
