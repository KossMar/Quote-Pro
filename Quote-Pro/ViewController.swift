

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SaveQuoteDelegate
{

    

    @IBOutlet weak var tableView: UITableView!
    var quotesArray : Array<Quote> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc : QuoteGeneratorViewController = segue.destination as! QuoteGeneratorViewController
        vc.delegate = self;
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue)
    {
        
    }
    
    // MARK: - TableView protocol
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return quotesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let quote : Quote = quotesArray[indexPath.row]
        let cell : QuoteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as! QuoteTableViewCell
        cell.authorLabel.text = quote.author
        cell.quoteLabel.text = quote.quote
        cell.quoteImageView.image = quote.image
        cell.quoteImageView.contentMode = .scaleAspectFill
        

        return cell
    }

    // Delegate Method
    
    func saveQuote(quote: Quote) {
        // add quote to an array and reload tableView
        self.quotesArray.append(quote)
        print(quotesArray.count)
    }
    
}

