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
        
        
        let apiToContact = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        // This code will call the iTunes top 25 movies endpoint listed above
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                        
                        // Grab the array of JSON objects representing each movie
                        let allMoviesJSONData = json["feed"]["entry"].arrayValue
                        
                        // Turn the allMoviesData array into Movie structs!
                        var allMovies: [Movie] = []
                        
                        for data in allMoviesJSONData  {
                            
                            allMovies.append(Movie(json: data))
                        }
            
                    

            
                    let randomIndex = Int(arc4random_uniform(UInt32(allMovies.count)))
                        print(allMovies[randomIndex])
                    
                    //lets populate a movie
                        self.movieTitleLabel.text  = allMovies[randomIndex].name
                        self.rightsOwnerLabel.text = allMovies[randomIndex].rightsOwner
                        self.releaseDateLabel.text = allMovies[randomIndex].releaseDate
                        self.priceLabel.text =  String(allMovies[randomIndex].price)
                    
                   if allMovies[randomIndex].imageLink != nil  {
                        self.loadPoster(urlString : allMovies[randomIndex].imageLink!)
                    }

                        
                    
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
        UIApplication.shared.openURL(URL(string: "http://itunes.apple.com/us/movie/")!)
    }
    

}
