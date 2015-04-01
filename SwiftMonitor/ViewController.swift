//
//  ViewController.swift
//  SwiftMonitor
//
//  Created by Martin Nash on 2/27/15.
//  Copyright (c) 2015 Martin Nash. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    private var monitor: FolderMonitor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMonitorIfNot()
    }
    
    func createMonitorIfNot() {
        let url = NSURL(fileURLWithPath: "~/Desktop".stringByExpandingTildeInPath)!
        monitor = monitor ?? FolderMonitor(url: url, handler: {
            println("Found change")
        })
        println("Monitoring '\(url)'")
    }

    @IBAction func startMonitor(sender: AnyObject?) {
        createMonitorIfNot()
    }

    @IBAction func stopMonitor(sender: AnyObject?) {
        monitor = nil
    }


}

