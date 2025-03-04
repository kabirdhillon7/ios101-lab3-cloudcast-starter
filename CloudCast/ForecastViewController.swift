//
//  ForecastViewController.swift
//  CloudCast
//
//  Created by Kabir Dhillon on 3/1/25.
//

// Import the UIKit framework
// You're almost always going to need this when your referencing UI elements in your file
import UIKit

// Class declaration, including the name of the class and its subclass (UIViewController)
class ForecastViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var percipitationLabel: UILabel!
    
    // MARK: Properties
    private var forecasts = [WeatherForecast]() // tracks all the possible forecasts
    private var selectedForecastIndex = 0
    
    // MARK: Init
    // Function override for the view controller
    // This is fired when the view has finished loading for the first time
    override func viewDidLoad() {
        // Some functions require you to call the super class implementation
        // Always read the online documentation to know if you need to
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let fakeData = WeatherForecast(temperature: 25.0, date: Date(), weatherCode: .partlyCloudy)
//        configure(with: fakeData)
        
        forecasts = createMockData()
        configure(with: forecasts[selectedForecastIndex])
        
        addGradient()
    }
    
    // MARK: Methods
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
//                                UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
        gradientLayer.colors = [
            UIColor(red: 0.68, green: 0.85, blue: 0.90, alpha: 1.00).cgColor, // #ADD8E6 - Light blue (pale sky)
            UIColor(red: 0.94, green: 0.87, blue: 0.96, alpha: 1.00).cgColor  // #EFDBF5 - Pale lavender
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func configure(with forecast: WeatherForecast) {
        forecastImageView.image = forecast.weatherCode.image
        descriptionLabel.text = forecast.weatherCode.description
        temperatureLabel.text = "\(forecast.temperature)°F"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: forecast.date)
        windLabel.text = "\(forecast.wind) mph"
        percipitationLabel.text = "\(forecast.percipitation)%"
    }
    
    // Returns an array of fake WeatherForecast data models to show
    private func createMockData() -> [WeatherForecast] {
        // This is just using the Calendar API to get a few random dates
        let today = Date()
        var dateComponents = DateComponents()
        dateComponents.day = 1
        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: today)!
        let dayAfterTomorrow = Calendar.current.date(byAdding: dateComponents, to: tomorrow)!
        // Create a few mock data to show
        let mockData1 = WeatherForecast(windSpeed: 3.3,
                                        weatherCode: .violentRainShowers,
                                        precipitation: 33.3,
                                        temperature: 59.5,
                                        date:today,
                                        wind: 2.8,
                                        percipitation: 23.3)
        let mockData2 = WeatherForecast(windSpeed: 3.7,
                                        weatherCode: .fog,
                                        precipitation: 13.3,
                                        temperature: 65.5,
                                        date: tomorrow,
                                        wind: 3.3,
                                        percipitation: 33.3)
        let mockData3 = WeatherForecast(windSpeed: 2.8,
                                        weatherCode: .partlyCloudy,
                                        precipitation: 23.3,
                                        temperature: 49.5,
                                        date: dayAfterTomorrow,
                                        wind: 12.2,
                                        percipitation: 20.5)
        return [mockData1, mockData2, mockData3]
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        selectedForecastIndex = max(0, selectedForecastIndex - 1) // don't go lower than 0 index
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    
    
    @IBAction func didTapForwardButton(_ sender: Any) {
        selectedForecastIndex = min(forecasts.count - 1, selectedForecastIndex + 1) // don't go higher than the number of forecasts
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
