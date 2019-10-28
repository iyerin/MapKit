//
//  SecondViewController.swift
//  SuperPuperApp
//
//  Created by Ihor YERIN on 6/2/18.
//  Copyright © 2018 Ihor YERIN. All rights reserved.
//

import UIKit

struct Object {
    let name: String
    let sub: String
    let lat: Double
    let lon: Double
}

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var LocationsListTableView: UITableView!
    var objects = [Object]()
    var chosen = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = self.view.frame
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        objects.append(Object(name: "Lukianovka", sub: "my favorite metro", lat: 50.462522, lon: 30.481639))
        objects.append(Object(name: "UnitFactory", sub: "free ping-pong", lat: 50.468988, lon: 30.462290))
        objects.append(Object(name: "Home", sub: "sweet home", lat: 50.395320, lon: 30.501846))
    }
    
    var tableView = UITableView()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = objects[indexPath.section].name
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosen = indexPath.section
        performSegue(withIdentifier: "AliPerehod", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? FirstViewController {
            dest.myObj = objects[chosen]
        }
    }
}
