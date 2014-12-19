//
//  AppDelegate.swift
//  iTunesKiller
//
//  Created by Silas J. Matson on 12/18/14.
//  

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSWorkspace.sharedWorkspace().notificationCenter.addObserver(self, selector: "appLaunchedInSharedWorkspace:", name: NSWorkspaceDidLaunchApplicationNotification, object: nil);
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        NSWorkspace.sharedWorkspace().notificationCenter.removeObserver(self);
    }
    
    func appLaunchedInSharedWorkspace(notif: NSNotification!) {
        var appName = notif.userInfo!["NSApplicationName"] as String;

        if (appName == "iTunes") {
            // Kill iTunes
            var iTunesInstance = notif.userInfo!["NSWorkspaceApplicationKey"] as NSRunningApplication;
            
            killProgram(iTunesInstance);
        }
        // We don't care
    }
    
    func killProgram(iTunesInstance: NSRunningApplication) {
        if (iTunesInstance.terminate()) {
            NSLog("Success! iTunes tried to be annoying and failed!");
        } else {
            NSLog("iTunes doesn't want to be killed. Let's nuke it!");
            
            if (iTunesInstance.forceTerminate()) {
                NSLog("Finally. Killed the sucker.");
            } else {
                NSLog("This iTunes crap is a zombie. Maybe try a `kill -9`?");
            }
        }

    }


}

