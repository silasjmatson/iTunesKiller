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
        var shouldKill = false;
        
        if (appName == "iTunes" || appName == "Photos") {
            shouldKill = true;
        }
        if (shouldKill) {
            var instance = notif.userInfo!["NSWorkspaceApplicationKey"] as NSRunningApplication;
            
            self.killProgram(instance);
        }
    }
    
    func killProgram(instance: NSRunningApplication) {
        if (instance.terminate()) {
            NSLog("Success! \(instance.localizedName!) tried to be annoying and failed!");
        } else {
            NSLog("\(instance.localizedName!) doesn't want to be killed. Let's nuke it!");
            
            if (instance.forceTerminate()) {
                NSLog("Finally. Killed the sucker.");
            } else {
                NSLog("This \(instance.localizedName!) crap is a zombie. Maybe try a `kill -9`?");
            }
        }

    }


}

