/*
 * issetugid implementation for Linux
 * Public domain
 */

#include <unistd.h>

int issetugid(void)
{
	return 1;
}
