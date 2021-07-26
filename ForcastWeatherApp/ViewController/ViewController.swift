//
//  ViewController.swift
//  ForcastWeatherApp
//
//  Created by Hamed Amiry on 18.12.2020.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, searchWeatherDelegate {
    
    var viewModel = WeatherViewModel()
    var nameOfCity: String?
    var celsiusAndFahrenheit: Bool = true
    var newsummaryhourly = [String]()
    var newTimeHourly = [Int]()
    var newIcondHourly = [String]()
    var newTempHourly = [Double]()

    @IBOutlet weak var weatherSearchBar: UISearchBar! {
        didSet {
            weatherSearchBar.placeholder = "Enter The City Name Here..."
        }
    }
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.weatherSearchBar.delegate = self
        registerCell()
    }

    func changeBackgroundColorOfTableViewAndView() {
        tableView.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
    }
    func registerCell() {
        tableView.register(UINib(nibName: WeatherSupportingFile.dailyCellIdentifire, bundle: nil), forCellReuseIdentifier: WeatherSupportingFile.dailyCellIdentifire)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTotaleNumberOfDaily() ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var newCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherSupportingFile.dailyCellIdentifire) as? DailyWeatherTableViewCell {
            cell.summaryLabel.text = viewModel.getDailyDataSummary(at: indexPath.row)
            
            // this formula help me to convert Fahrenheit to Celsius and this is Conversion Formula.
            if self.celsiusAndFahrenheit {
            cell.highTempLabel.text = "High Temp " + String(format: "%.0f", (viewModel.getDailyDAtaHighTemp(at: indexPath.row) - 32)*0.5556 )  + "°C"
            
            // this formula help me to convert Fahrenheit to Celsius and this is Conversion Formula.
            cell.lowTemLabel.text = "Low Temp " + String(format: "%.0f", (viewModel.getDailyDataLowTemp(at: indexPath.row) - 32)*0.5556 )  + "°C"
            }else {
                 cell.highTempLabel.text = "High Temp " + "\(Int(viewModel.getDailyDAtaHighTemp(at: indexPath.row)))°"
                cell.lowTemLabel.text = "Low Temp  " + "\(Int(viewModel.getDailyDataLowTemp(at: indexPath.row)))°"
            }
           cell.timeLabel.text = cell.getDayForDate(Date(timeIntervalSince1970: Double(viewModel.getDailyDataTime(at: indexPath.row))))
           
            cell.iconImage.image = UIImage(named: viewModel.getDailyDataIcon(at: indexPath.row))
            cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
            
            newCell = cell
           }
        return newCell
    }
  
    func updateWeather() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        /////////////////////////////////////////////
            self.tableView.tableHeaderView = self.createTableHeader()
        }
    }
    ///////////////////////////////////
    func createTableHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        headerView.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        let currentView = UILabel(frame: CGRect(x: 5, y: 5, width: view.frame.size.width-20, height: view.frame.size.height/25))
        let currentTime = UILabel(frame: CGRect(x: 5, y: 5, width: view.frame.size.width-20, height: view.frame.size.height/25))
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerView.frame.size.height/3))
        let summarylabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/6))
        let templable = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summarylabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        let nameOfCityLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summarylabel.frame.size.height+templable.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/10))
        let forcastweatherlabel = UILabel (frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summarylabel.frame.size.height+templable.frame.size.height+nameOfCityLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/5))

        headerView.addSubview(currentTime)
        headerView.addSubview(forcastweatherlabel)
        headerView.addSubview(currentView)
        headerView.addSubview(nameOfCityLabel)
        headerView.addSubview(locationLabel)
        headerView.addSubview(summarylabel)
        headerView.addSubview(templable)
        currentTime.textAlignment = .right
        forcastweatherlabel.textAlignment = .left
        currentView.textAlignment = .left
        nameOfCityLabel.textAlignment = .center
        locationLabel.textAlignment = .center
        summarylabel.textAlignment = .center
        templable.textAlignment = .center

        currentView.text = " => Current Weather"
        currentView.textColor = UIColor(red: 128/255.0, green: 33/255.0, blue: 32/225.0, alpha: 1.0)
        currentView.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        currentTime.text = timezone()
        currentTime.textColor = UIColor(red: 128/255.0, green: 33/255.0, blue: 32/225.0, alpha: 1.0)
        currentTime.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        locationLabel.text = viewModel.gettimezone()
        locationLabel.font = UIFont(name: "AvenirNext-Heavy", size: 30.0)
        locationLabel.textColor = UIColor(red: 26/255.0, green: 75/255.0, blue: 22/225.0, alpha: 1.0)
        if self.celsiusAndFahrenheit {
        // this formula help me to convert Fahrenheit to Celsius and this is Conversion Formula.
        templable.text = String(format: "%.0f", (viewModel.getCurrentTemp() - 32)*0.5556 )  + "°C"
        }else {
            templable.text = "\(Int(viewModel.getCurrentTemp()))°F"
        }
        templable.font = UIFont(name: "Helvetica-Bold", size: 32)
        summarylabel.text = viewModel.getCurrentlySummery()
        summarylabel.font = UIFont(name: "AvenirNext-Heavy", size: 20.0)
        summarylabel.textColor = UIColor(red: 26/255.0, green: 75/255.0, blue: 22/225.0, alpha: 1.0)
        nameOfCityLabel.text = nameOfCity
        nameOfCityLabel.font = UIFont(name: "SnellRoundhand-Bold", size: 40.0)
        nameOfCityLabel.textColor = UIColor(red: 26/255.0, green: 75/255.0, blue: 22/225.0, alpha: 1.0)
        forcastweatherlabel.text = " => Forcast Weather"
        forcastweatherlabel.textColor = UIColor(red: 128/255.0, green: 33/255.0, blue: 32/225.0, alpha: 1.0)
        forcastweatherlabel.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        return headerView
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
        viewModel.updateWeatherForLocation(location: text)
        nameOfCity = text
        searchBar.resignFirstResponder()
         searchBar.text = ""
    }
    // This fuction is for current time of searched city.
    func timezone() -> String {
        let timezone = TimeZone.init(identifier: viewModel.gettimezone())// identifier with time zone we cant search correct time from Timezone of API.
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = timezone
        return formatter.string(from: date)
    }

}

