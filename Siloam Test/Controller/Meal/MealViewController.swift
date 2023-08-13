//
//  MealViewController.swift
//  Siloam Test
//
//  Created by Apple on 12/08/23.
//

import UIKit
import SDWebImage

class MealViewController: UIViewController {
    
    // MARK: - Variables
    
    lazy var mealViewModel: MealViewModel = {
        return MealViewModel()
    }()
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // setup title
        self.title = CommonStrings.meals
        
        // setup search bar
        self.setupSearchBar()
        
        // initialize closure
        self.initializeClosures()
    }
    
    // MARK: - Setup search bar
    
    func setupSearchBar() {
        self.searchBar.barTintColor = UIColor.clear
        self.searchBar.backgroundColor = UIColor.clear
        self.searchBar.isTranslucent = true
        self.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.searchBar.searchTextField.borderStyle = .none
        self.searchBar.searchTextField.layer.cornerRadius = 10
        self.searchBar.searchTextField.backgroundColor = .white
    }
    
    // MARK: - Initialize Closures
    
    func initializeClosures() {
        self.initializeShowHideTableViewClosure()
        self.initializeTableViewClosure()
        self.initializeShowHideCommonLoaderClosure()
    }
    
    func initializeShowHideTableViewClosure() {
        self.mealViewModel.showHideTableViewClosure = { [weak self] isShow in
            guard let self = self else { return }
            self.tableView.isHidden = !isShow
            self.noDataLabel.isHidden = isShow
        }
    }
    
    func initializeTableViewClosure() {
        self.mealViewModel.reloadTableViewClosure = { [weak self] () in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func initializeShowHideCommonLoaderClosure() {
        self.mealViewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let isLoading = self.mealViewModel.isLoading 
                if isLoading {
                    Loader().show()
                }else {
                    Loader().hide()
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @objc func mealImageTapped(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self.tableView)
        if let indexPath = self.tableView.indexPathForRow(at: location)/*, let cell = self.tableView.cellForRow(at: indexPath) as? MealsTableViewCell*/ {
            let controller = UIStoryboard(name: StoryboardName.main, bundle: nil).instantiateViewController(withIdentifier: ControllerName.fullScreenImageViewController) as! FullScreenImageViewController
            controller.modalPresentationStyle = .overFullScreen
            controller.image = self.mealViewModel.meals[indexPath.row].mealThumbImage ?? ""
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromBottom
            self.view.window?.layer.add(transition, forKey: nil)
            self.present(controller, animated: false, completion: nil)
        }
    }
}

extension MealViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.mealViewModel.callMealListApi(searchText: searchText)
    }
}

extension MealViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealViewModel.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.mealsTableViewCell, for: indexPath) as! MealsTableViewCell
        if let name = self.mealViewModel.meals[indexPath.row].mealName {
            cell.mealNameLabel.text = CommonStrings.mealName + name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        cell.mealImageView.sd_setImage(with: URL(string: self.mealViewModel.meals[indexPath.row].mealThumbImage ?? ""), placeholderImage: UIImage(named: CommonStrings.placehodlerImage))
        
        // Add tap gesture on image view
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.mealImageTapped(_:)))
        cell.mealImageView.isUserInteractionEnabled = true
        cell.mealImageView.addGestureRecognizer(tapGesture)
        
        if let category = self.mealViewModel.meals[indexPath.row].mealCategory {
            cell.mealCategory.text = CommonStrings.mealCategory + category.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        if let area = self.mealViewModel.meals[indexPath.row].mealArea {
            cell.mealArea.text = CommonStrings.mealArea + area.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        if let tags = self.mealViewModel.meals[indexPath.row].mealTags {
            cell.mealTags.text = CommonStrings.mealTags + tags.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        return cell
    }
}

extension MealViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mealDetailController = UIStoryboard(name: StoryboardName.main, bundle: nil).instantiateViewController(withIdentifier: ControllerName.mealDetailController) as? MealDetailViewController {
            mealDetailController.mealId = self.mealViewModel.meals[indexPath.row].mealId ?? ""
            mealDetailController.mealName = self.mealViewModel.meals[indexPath.row].mealName ?? ""
            self.navigationController?.pushViewController(mealDetailController, animated: true)
        }
    }
}

class MealsTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealCategory: UILabel!
    @IBOutlet weak var mealArea: UILabel!
    @IBOutlet weak var mealTags: UILabel!
}
