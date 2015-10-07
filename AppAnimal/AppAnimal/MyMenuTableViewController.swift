//
//  MyMenuTableViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny Nazarov on 29.09.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class MyMenuTableViewController: UITableViewController {
    
    var selectedMenuItem : Int = 0
    var listaTelas = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        listaTelas = ["Caes","Gatos","Passaros","Outros","Videoteca","Cadastrar","Mapa"]
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTelas.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL")
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        let nomeTela = listaTelas[indexPath.row]
        
        cell!.textLabel?.text = nomeTela
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ControllerPrincipal")
            destViewController.title = "Cachorro"
            break
        case 1:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ControllerPrincipal")
            destViewController.title = "Gato"
            break
        case 2:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ControllerPrincipal")
            destViewController.title = "Passaro"
            break
        case 3:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ControllerPrincipal")
            destViewController.title = "Outros"
            break
        case 4:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ControllerPrincipal")
            destViewController.title = "Videos"
            break
        case 5:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ControllerCadastro")
            break
        
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MapaPet")
            destViewController.title = "Mapa"
            break
        }
        sideMenuController()?.setContentViewController(destViewController)
    }
}
