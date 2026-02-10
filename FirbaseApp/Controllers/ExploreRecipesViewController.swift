//
//  ExploreRecipesViewController.swift
//  FirbaseApp
//
//  Created by Tardes on 10/2/26.
//

import UIKit

class ExploreRecipesViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    private var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self

        Task {
            recipes = await ApiManager.getAllrecipes()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe_cell", for: indexPath) as! RecipeCell
        
        cell.configure(with: recipes[indexPath.row])
        
        return cell
    }
}
