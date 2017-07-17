//
//  ViewController.swift
//  API-Sandbox
//
//  Created by Dion Larson on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class ViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var rightsOwnerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // Do any additional setup after loading the view, typically from a nib.
       // exerciseOne()
       // exerciseTwo()
       // exerciseThree()
        
//        Creates a request to apiToContact
//        Validates the request to ensure it worked
//        Passes the JSON response to a closure
//        In the closure we handle success and failure with a switch statement
//        If successful, we create a JSON object from the response's result's value
//        After that, you can work with it just like you did on the previous exercises!
        
        let apiToContact = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        // This code will call the iTunes top 25 movies endpoint listed above
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    let countMovies = json["feed"]["entry"].count
                    let randomNumber = arc4random_uniform(UInt32(countMovies))
                    
                    let selectedMovie = json["feed"]["entry"][Int(randomNumber)]
                    
                    guard let movieTitle = selectedMovie["im.name"]["label"].string else {
                        return
                    }
                    guard let rightOwner = selectedMovie["rights"]["label"].string else {
                        return
                    }
                    guard let releaseDate = selectedMovie["im:releaseDate"]["label"].string else {
                        return
                    }
                    guard let price = selectedMovie["im:price"]["attributes"]["amount"].string else {
                        return
                    }
                    
                    self.movieTitleLabel.text = movieTitle
                    self.rightsOwnerLabel.text = rightOwner
                    self.releaseDateLabel.text = releaseDate
                    self.priceLabel.text = price
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Updates the image view when passed a url string
    func loadPoster(urlString: String) {
        posterImageView.af_setImage(withURL: URL(string: urlString)!)
    }
    
    @IBAction func viewOniTunesPressed(_ sender: AnyObject) {
        
    }
    
}

