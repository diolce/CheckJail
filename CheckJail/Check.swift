//
//  Check.swift
//  CheckJail
//
//  Created by diolce on 8/12/20.
//

import Foundation
import Functions
import UIKit

public class Check {
    #if !(TARGET_IPHONE_SIMULATOR)
    let paths = ["/private/var/stash".xorString(),
                 "/private/var/lib/apt".xorString(),
                 "/private/var/tmp/cydia.log".xorString(),
                 "/private/var/mobile/Library/SBSettings/Themes".xorString(),
                 "/Library/MobileSubstrate/MobileSubstrate.dylib".xorString(),
                 "/Library/MobileSubstrate/DynamicLibraries/Veency.plist".xorString(),
                 "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist".xorString(),
                 "/System/Library/LaunchDaemons/com.ikey.bbot.plist".xorString(),
                 "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist".xorString(),
                 "/var/cache/apt".xorString(),
                 "/var/lib/apt".xorString(),
                 "/var/log/syslog".xorString(),
                 "/var/tmp/cydia.log".xorString(),
                 "/usr/bin/sshd".xorString(),
                 "/etc/apt".xorString(),
                 "/bin/bash".xorString(),
                 "/usr/sbin/sshd".xorString(),
                 "/usr/libexec/ssh-keysign".xorString(),
                 "/usr/libexec/sftp-server".xorString(),
                 "/etc/ssh/sshd_config".xorString(),
                 "/bin/sh".xorString(),
                 "/Applications/Cydia.app".xorString(),
                 "/Applications/RockApp.app".xorString(),
                 "/Applications/Icy.app".xorString(),
                 "/Applications/WinterBoard.app".xorString(),
                 "/Applications/SBSettings.app".xorString(),
                 "/Applications/MxTube.app".xorString(),
                 "/Applications/IntelliScreen.app".xorString(),
                 "/Applications/FakeCarrier.app".xorString(),
                 "/Applications/blackra1n.app".xorString()]
    #else
    let paths = ["/private/var/stash".xorString(),
                 "/private/var/lib/apt".xorString(),
                 "/private/var/tmp/cydia.log".xorString(),
                 "/private/var/mobile/Library/SBSettings/Themes".xorString(),
                 "/Library/MobileSubstrate/MobileSubstrate.dylib".xorString(),
                 "/Library/MobileSubstrate/DynamicLibraries/Veency.plist".xorString(),
                 "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist".xorString(),
                 "/System/Library/LaunchDaemons/com.ikey.bbot.plist".xorString(),
                 "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist".xorString(),
                 "/var/cache/apt".xorString(),
                 "/var/lib/apt".xorString(),
                 "/var/log/syslog".xorString(),
                 "/var/tmp/cydia.log".xorString(),
                 "/usr/bin/sshd".xorString(),
                 "/etc/apt".xorString(),
                 "/Applications/Cydia.app".xorString(),
                 "/Applications/RockApp.app".xorString(),
                 "/Applications/Icy.app".xorString(),
                 "/Applications/WinterBoard.app".xorString(),
                 "/Applications/SBSettings.app".xorString(),
                 "/Applications/MxTube.app".xorString(),
                 "/Applications/IntelliScreen.app".xorString(),
                 "/Applications/FakeCarrier.app".xorString(),
                 "/Applications/blackra1n.app".xorString()]
    
    #endif
    
    let symlinks = ["/Library/Ringtones".xorString(),
                    "/Library/Wallpaper".xorString(),
                    "/usr/arm-apple-darwin9".xorString(),
                    "/usr/include".xorString(),
                    "/usr/libexec".xorString(),
                    "/usr/share".xorString(),
                    "/Applications".xorString()]
    
    let schemes = ["cydia://".xorString()]
    
    let pathsPermission = ["/".xorString()]
    
    public init () {}
    public func isPortOpen(port:Int) -> Bool {
        return isPortOpenInSystem(Int16(port))
    }
    
    //Check Injection
    public func isInjected() -> Bool {
        return hasInjectedDyld()
    }
    
    //Check forkings
    public func isForking() -> Bool {
        #if !(TARGET_IPHONE_SIMULATOR)
        return isFork()
        #else
        return false;
        #endif
    }
    
    //Check symlinks
    public func hasSymlinks() -> Bool {
        for symlink in symlinks {
            if isJailbreakSymLink(symlink.xorString()) {
                return true
            }
        }
        return false
    }
    
    //Check exists paths
    public func existsPaths() -> Bool {
        for path in paths {
            if FileManager.default.fileExists(atPath: path.xorString()) {
                return true
            }
        }
        return false
    }
    
    //Check files jailbreak
    public func hasFilesJailbreak() -> Bool {
        for path in paths {
            if checkJailbreakFile(path.xorString()) {
                return true
            }
        }
        return false
    }
    
    //Check permision for path
    public func hasPermissionsInRoot() -> Bool {
        for path in pathsPermission {
            if checkPermissions(path.xorString()) {
                return true
            }
        }
        return false
    }
    
    //Check write in system directories
    public func canWrite() -> Bool {
        //  Reading and writing in system directories (sandbox violation)
        let stringToWrite = "Jailbreak Test".xorString()
        let file = "/private/JailbreakTest.txt".xorString()
        do {
            try stringToWrite.xorString().write(toFile:file.xorString(), atomically:true, encoding:String.Encoding.utf8)
            // Device is jailbroken
            return true
        } catch {
            return false
        }
    }
    
    //Check scheme for cydia
    public func hasCydia() -> Bool {
        for scheme in schemes {
            if let url = URL(string: scheme.xorString()) {
                if UIApplication.shared.canOpenURL(url) {
                    return true
                }
            }
        }
        return false
    }
}


