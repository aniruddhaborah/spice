//
//  AppDelegate.swift
//  Spice
//
//  Created by Aniruddha Borah on 2019-05-06.
//  Copyright © 2019 Impy. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    var apps: [NSRunningApplication]?
    
    @objc func printQuote(_ sender: Any?) {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain"
        
        print("\(quoteText) — \(quoteAuthor)")
    }
    
    func constructMenu() {
        let menu = NSMenu()
        apps?.forEach({ (app) in
            menu.addItem(NSMenuItem(title: app.localizedName ?? "App", action: #selector(AppDelegate.printQuote(_:)), keyEquivalent: "P"))
            menu.addItem(NSMenuItem.separator())
        })
        
        menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        runningApplications()
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(printQuote(_:))
        }
        constructMenu()
    }
    
    func runningApplications() {
        let workspace = NSWorkspace.shared
        apps = workspace.runningApplications.filter { (app) -> Bool in
            return app.activationPolicy == .regular
        };
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

