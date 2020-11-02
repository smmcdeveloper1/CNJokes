//
//  ViewController.swift
//  CNJokes
//
//  Created by SMMC on 01/11/2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var explicitJokesExcluded = true
    private let jokesManager = JokesManager()
    var jokes = [Value]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchJokes()
    }
    
    // MARK: - Private Methods
    private func fetchJokes()
    {
        jokesManager.fetchJokes(self.explicitJokesExcluded) {  [weak self] (result) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
               switch result {
                 case .success(let model):
                    self.updateView(with: model)
                 case .failure(let error):
                    print("error: ",error.localizedDescription)
               }
            }
        }
    }
    
    private func updateView(with model: JokesModel) {
        jokes = []
        jokes = model.jokes
        self.tableView.reloadData()
    }
    
    private func getMessageAlert() -> String {
        if self.explicitJokesExcluded {
            return Constants.Content.addExplicitJokesMessage
        }
        
        return Constants.Content.excludeExplicitJokesMessage
    }
    
    // MARK: - IBAction Methods
    @IBAction func changeJokes(_ sender: Any) {
        let message = getMessageAlert()
        let dialogMessage = UIAlertController(title: Constants.Content.tittleMessage, message:message, preferredStyle: .alert)
        
        let action = UIAlertAction(title:  Constants.Content.accept, style: .default, handler: { [weak self] _  in
            guard let `self` = self else { return }
            
            self.explicitJokesExcluded = !self.explicitJokesExcluded
            self.fetchJokes()
        })
        
        let cancel = UIAlertAction(title: Constants.Content.cancel, style: .cancel, handler: nil)
        
        dialogMessage.addAction(action)
        dialogMessage.addAction(cancel)
     
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
// MARK: - UITableViewDataSource Methods
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
       
        return jokes.count
    }

    func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let message = jokes[indexPath.row]
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.identifiers.TableViewCellidentifier,
                for: indexPath
            )

            cell.textLabel?.text = message.joke.replacingOccurrences(of: "&quot;", with: "\"")
            
            return cell
     }
}

