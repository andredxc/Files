#ifndef LIBGALILEO2_H
#define LIBGALILEO2_H

#ifdef __cplusplus
extern "C"
{
#endif

    extern int pputs(const char *path, const char *string);
    extern char* pgets(char* string, int size, const char* path);

#ifdef __cplusplus
};
#endif

#endif
