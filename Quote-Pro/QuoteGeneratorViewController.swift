

import UIKit

protocol SaveQuoteDelegate
{
    func saveQuote(quote : Quote)
}

class QuoteGeneratorViewController: UIViewController
{
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    weak var myQuoteView: QuoteView!
    var quote : Quote?
    var delegate : SaveQuoteDelegate?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.quote = Quote()
        setup()
    }
    
    private func setup()
    {
        let quoteView = QuoteView()
        add(quoteView: quoteView, to: self.view)
        myQuoteView = quoteView
    }
    
    private func add(quoteView: QuoteView, to view: UIView) {
        quoteView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quoteView)
        quoteView.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        quoteView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        quoteView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        quoteView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    //MARK: - Actions
    
    @IBAction func generatePhoto(_ sender: UIButton)
    {
        
        WebService.shared.generatePhoto()
        
        DispatchQueue.main.async {
            let quote : Quote = WebService.quote
            self.myQuoteView.myImageView.image = quote.image
            self.quote?.image = quote.image
        }
        
    }
    
    @IBAction func generateQuote(_ sender: UIButton)
    {
        WebService.shared.generateQuote()
        
        DispatchQueue.main.async {
            let quote : Quote = WebService.quote
            self.myQuoteView.quoteLabel.text = quote.quote
            self.myQuoteView.authorLabel.text = quote.author
            self.quote?.author = quote.author
            self.quote?.quote = quote.quote
            
        }
    }
    
    

    
    @IBAction func saveQuoteImage(_ sender: UIButton)
    {
        if let delegate = delegate {
            delegate.saveQuote(quote: self.quote!)
        }
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }
    
    
}
