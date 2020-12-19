//
//  testJailbreak.c
//  CheckJail
//
//  Created by Diego Olmo Cejudo on 7/12/20.
//

#include "testJailbreak.h"


bool checkPort(int port) {
    if port == 22 {
        return true;
    } else {
        return false;
    }
}
