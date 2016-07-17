//
//  WeatherTableViewController.swift
//  SwinjectSimpleExample
//
//  Created by koogawa on 2016/07/17.
//  Copyright © 2016年 koogawa. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    var weatherFetcher: WeatherFetcher?

    private var cities = [City]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        weatherFetcher?.fetch {
            if let cities = $0 {
                self.cities = cities
            }
            else {
                // Show an error message.
            }
        }
    }

    // MARK: UITableViewDataSource
    override func tableView(
        tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        return cities.count
    }

    override func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "Cell", forIndexPath: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = city.weather
        return cell
    }
}
