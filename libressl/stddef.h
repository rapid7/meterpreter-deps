/*
 * Public domain
 * stddef.h compatibility shim
 */

#include_next <stddef.h>
#include <stdint.h>
#ifndef SIZE_MAX
#define SIZE_MAX UINT32_MAX
#endif
