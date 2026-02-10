//
//  ExploreRecipesViewController.swift
//  FirbaseApp
//
//  Created by Tardes on 10/2/26.
//

import UIKit
import UIScrollView_InfiniteScroll

class ExploreRecipesViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    private var recipes: [Recipe] = []
    private let TOTAL_RESULTS = 50

    override func viewDidLoad() {
        super.viewDidLoad()

        ApiManager.resetPagination()
        tableView.dataSource = self

        Task {
            let firstPage = await ApiManager.getRecipes()

            await MainActor.run {
                if firstPage == nil { return }

                self.recipes = firstPage!.recipes
                self.tableView.reloadData()
            }
        }

        tableView.setShouldShowInfiniteScrollHandler { [self] _ -> Bool in
            return recipes.count < TOTAL_RESULTS
        }

        tableView.addInfiniteScroll { tableView in
            Task {
                let nextPage = await ApiManager.getRecipes()

                if nextPage == nil { return }

                await MainActor.run {
                    if nextPage!.recipes.count == nextPage!.total {
                        tableView.finishInfiniteScroll()
                        return
                    }

                    self.recipes.append(contentsOf: nextPage!.recipes)
                    tableView.reloadData()
                    tableView.finishInfiniteScroll()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "recipe_cell",
                for: indexPath
            ) as! RecipeCell

        cell.configure(with: recipes[indexPath.row])

        return cell
    }
}
