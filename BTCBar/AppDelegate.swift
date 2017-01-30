//
//  AppDelegate.swift
//  BTCBar
//
//  Created by Tejas Prakash on 1/23/17.
//  Copyright © 2017 tejasp. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)

    @IBOutlet weak var btcUSD: NSMenuItem!
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared().terminate(self)

    }
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        statusItem.menu = statusMenu
        
        let urlString = "https://api.coindesk.com/v1/bpi/currentprice.json"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let usdValue = parsedData["bpi"] as! [String:Any]
                    let USDrate = usdValue["USD"] as! [String: Any]
                    let rate = USDrate["rate"]
                    let rrate = rate as! String
                    print("USD rate is " + rrate)
                    self.btcUSD.title = rrate
                    
                   
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
       
 
        
        
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

