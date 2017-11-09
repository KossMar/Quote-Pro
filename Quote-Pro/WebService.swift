

import Foundation
import UIKit

class WebService
{
    
    
    // MARK: - Properties
    static let shared = WebService()
    static let quote = Quote()
    
    // MARK: - Networking
    func generatePhoto()
    {
        let url = URL(string: "https://lorempixel.com/800/800/")!

        
        guard let data = try? Data.init(contentsOf: url)
            else {
            print("You fucked up, buddy! No data here")
                return
        }
            let image = UIImage.init(data: data)
            
            WebService.quote.image = image
        
    }

    
    func generateQuote()
    {
        
        let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en")!
        let request = NSMutableURLRequest(url: url)
        let sessionConfig : URLSessionConfiguration = URLSessionConfiguration.default
        let session : URLSession = URLSession.init(configuration: sessionConfig)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                print("no data returned from server \(error?.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("no response returned from server \(error)")
                return
            }
            
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                else {
                    print("data returned is not json, or not valid")
                    return
            }
            
            if let error = json["error"] as? String {
                // Show alert and display error. OR put error in UI somewhere
                print(error)
                return
            }
            
            
            guard let quoteTemp = json["quoteText"] as? String, let authorTemp = json["quoteAuthor"] as? String else {
                
                return
            }
            
            WebService.quote.quote = quoteTemp
            WebService.quote.author = authorTemp
            
        })
        
        task.resume()
    }
    
}
