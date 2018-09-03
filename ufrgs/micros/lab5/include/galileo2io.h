#ifndef GALILEO2IO_H
#define GALILEO2IO_H
#ifdef __cplusplus
extern "C"
{
#endif
extern char * pgets(char *s,int size,const char path[]);
extern int pputs(const char path[],const char s[]);
#ifdef __cplusplus
};
#endif
#endif