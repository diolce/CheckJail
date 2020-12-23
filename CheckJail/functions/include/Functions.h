//
//  CheckFunctions.h
//  CheckJail
//
//  Created by diolce on 8/12/20.
//

#ifndef Functions_h
#define Functions_h

#include <stdio.h>
#include <stdbool.h>


/* Forward declare the primary workhorse function */
void primary(void);

bool hasInjectedDyld(void);
/* Also define a helper function */
bool isPortOpenInSystem(short port);
bool isJailbreakSymLink(const char *checkPath);
bool checkJailbreakFile(const char *checkPath);
bool isFork(void); //Hacer comprobacion de simulador
bool checkPermissions(const char *path);

#endif /* Functions_h */
