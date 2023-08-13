//
//  MealDetailViewController.swift
//  Siloam Test
//
//  Created by Apple on 12/08/23.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    // MARK: - Variables
    
    lazy var mealDetailViewModel: MealDetailViewModel = {
        return MealDetailViewModel()
    }()
    var mealId: String = ""
    var mealName: String = ""
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // setup title
        self.title = mealName
        
        // initialize closure
        self.initializeClosures()
        
        // call detail api
        self.mealDetailViewModel.callMealDetailApi(mealId: self.mealId)
    }
    
    // MARK: - Initialize Closures
    
    func initializeClosures() {
        self.initializeShowHideTableViewClosure()
        self.initializeTableViewClosure()
        self.initializeShowHideCommonLoaderClosure()
    }
    
    func initializeShowHideTableViewClosure() {
        self.mealDetailViewModel.showHideTableViewClosure = { [weak self] isShow in
            guard let self = self else { return }
            self.tableView.isHidden = !isShow
        }
    }
    
    func initializeTableViewClosure() {
        self.mealDetailViewModel.reloadTableViewClosure = { [weak self] () in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func initializeShowHideCommonLoaderClosure() {
        self.mealDetailViewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let isLoading = self.mealDetailViewModel.isLoading
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
        let controller = UIStoryboard(name: StoryboardName.main, bundle: nil).instantiateViewController(withIdentifier: ControllerName.fullScreenImageViewController) as! FullScreenImageViewController
        controller.modalPresentationStyle = .overFullScreen
        controller.image = self.mealDetailViewModel.meals[0].mealThumbImage ?? ""
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.window?.layer.add(transition, forKey: nil)
        self.present(controller, animated: false, completion: nil)
    }
}

extension MealDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealDetailViewModel.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.mealImageDetailTableViewCell, for: indexPath) as! MealImageDetailTableViewCell
            cell.mealImageView.sd_setImage(with: URL(string: self.mealDetailViewModel.meals[indexPath.row].mealThumbImage ?? ""), placeholderImage: UIImage(named: CommonStrings.placehodlerImage))
            
            // Add tap gesture on image view
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.mealImageTapped(_:)))
            cell.mealImageView.isUserInteractionEnabled = true
            cell.mealImageView.addGestureRecognizer(tapGesture)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.mealNameDetailTableViewCell, for: indexPath) as! MealNameDetailTableViewCell
            if let name = self.mealDetailViewModel.meals[indexPath.row].mealName {
                cell.mealNameLabel.text = CommonStrings.mealName + name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
            if let category = self.mealDetailViewModel.meals[indexPath.row].mealCategory {
                cell.mealCategory.text = CommonStrings.mealCategory + category.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
            if let area = self.mealDetailViewModel.meals[indexPath.row].mealArea {
                cell.mealArea.text = CommonStrings.mealArea + area.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
            if let tags = self.mealDetailViewModel.meals[indexPath.row].mealTags {
                cell.mealTags.text = CommonStrings.mealTags + tags.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.mealInstructionsDetailTableViewCell, for: indexPath) as! MealInstructionsDetailTableViewCell
            if let instructions = self.mealDetailViewModel.meals[indexPath.row].mealInstuctions {
                cell.mealInstructionsLabel.text = instructions.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MealDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 200 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 200 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 35 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.mealDetailHeaderCell) as! MealDetailHeaderCell
            cell.headerLabel.text = CommonStrings.instructions
            return cell.contentView
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

class MealImageDetailTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var mealImageView: UIImageView!
}

class MealNameDetailTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealCategory: UILabel!
    @IBOutlet weak var mealArea: UILabel!
    @IBOutlet weak var mealTags: UILabel!
}

class MealInstructionsDetailTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var mealInstructionsLabel: UILabel!
}

class MealDetailHeaderCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var headerLabel: UILabel!
}
