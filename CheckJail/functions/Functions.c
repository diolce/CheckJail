//
//  CheckFunctions.c
//  CheckJail
//
//  Created by diolce on 8/12/20.
//

#include "Functions.h"
#include <stdio.h>
#include <netinet/in.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <mach-o/dyld.h>
#include <stdlib.h>
#include <sys/stat.h>

void primary()
{
    /* do the main work */
    printf("I'm the primary function, I'm doin' work.\n");

    /* also get some help from the helper function */
    //helper();
}

bool hasInjectedDyld(void)
{
    uint32_t count = _dyld_image_count();
    char* evilLibs[] = {"Substrate", "cycript"};
    for(uint32_t i = 0; i < count; i++)
    {
        const char *dyld = _dyld_get_image_name(i);
        int slength = (int)strlen(dyld);
        int j;
        for(j = slength - 1; j>= 0; --j)
        if(dyld[j] == '/') break;
        char *name = strndup(dyld + ++j, slength - j);
        for(int x=0; x < sizeof(evilLibs) / sizeof(char*); x++)
        {
            if(strstr(name, evilLibs[x]) || strstr(dyld, evilLibs[x]))
            {
                free(name);
                return true;
            }
        }
        
        free(name);
    }
    
    return false;
}


bool isPortOpenInSystem(short port)
{
    struct sockaddr_in addr;
    int sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    if (bind(sock,  (struct sockaddr *) &addr, sizeof(addr)) < 0) {
        if (errno == EADDRINUSE) {
            return true;
        }
    }
    close(sock);
    return false;
}

bool isJailbreakSymLink(const char *checkPath)
{
    struct stat s;
    if (lstat(checkPath, &s) == 0) {
        if (S_ISLNK(s.st_mode) == 1) {
            return true;
        }
    }
    return false;
}

bool checkJailbreakFile(const char *checkPath)
{
    struct stat s;
    if (stat(checkPath, &s) == 0)
    {
        return true;
    }
    return false;
}


bool isFork(void) {
    int resultFork = fork(); // Simulator allows fork
    if (resultFork >= 0) {
        return true;
    } else {
        return false;
    }
}


bool checkPermissions(const char *path) {
    if (access(path, R_OK|W_OK) > 0)
    {
        return true;
    }
    return false;
}
