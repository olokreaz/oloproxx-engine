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

#ifndef BASE_TYPES_H
#define BASE_TYPES_H

#include <ctime>

enum class TRISTATE
{
	NONE,
	SOME,
	ALL,
};

typedef void *IOHANDLE;

typedef int (*FS_LISTDIR_CALLBACK)(const char *name, int is_dir, int dir_type, void *user);

typedef struct
{
	const char *m_pName;
	time_t m_TimeCreated; // seconds since UNIX Epoch
	time_t m_TimeModified; // seconds since UNIX Epoch
} CFsFileInfo;

typedef int (*FS_LISTDIR_CALLBACK_FILEINFO)(const CFsFileInfo *info, int is_dir, int dir_type, void *user);

/**
 * @ingroup Network-General
 */
typedef struct NETSOCKET_INTERNAL *NETSOCKET;

enum
{
	/**
	 * The maximum bytes necessary to encode one Unicode codepoint with UTF-8.
	 */
	UTF8_BYTE_LENGTH = 4,

	IO_MAX_PATH_LENGTH = 512,

	NETADDR_MAXSTRSIZE = 1 + (8 * 4 + 7) + 1 + 1 + 5 + 1, // [XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX]:XXXXX

	NETTYPE_LINK_BROADCAST = 4,

	NETTYPE_INVALID = 0,
	NETTYPE_IPV4 = 1,
	NETTYPE_IPV6 = 2,
	NETTYPE_WEBSOCKET_IPV4 = 8,

	NETTYPE_ALL = NETTYPE_IPV4 | NETTYPE_IPV6 | NETTYPE_WEBSOCKET_IPV4,
	NETTYPE_MASK = NETTYPE_ALL | NETTYPE_LINK_BROADCAST,
};

/**
 * @ingroup Network-General
 */
typedef struct NETADDR
{
	unsigned int type;
	unsigned char ip[16];
	unsigned short port;

	bool operator==(const NETADDR &other) const;
	bool operator!=(const NETADDR &other) const { return !(*this == other); }
} NETADDR;
#endif // BASE_TYPES_H
