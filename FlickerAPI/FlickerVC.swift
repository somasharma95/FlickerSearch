//
//  FlickerVC.swift
//  FlickerAPI
//
//  Created by Soma Sharma on 16/06/21.
//

import UIKit

private let reuseIdentifier = "FlickrCell"

private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    


class FlickerVC: UIViewController {
    @IBOutlet var viewLayout: FlickerVL!
    var viewModel:FlickrViewModel = FlickrViewModel()
    var searchText:String = "welcome"
    var page = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func getData(search:String) {
        viewModel.getphotos(search, page: page) { [weak self] result in
            if result {
                DispatchQueue.main.async {
                    self?.viewLayout.collectionView.reloadData()
                }
              
    
            }
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInsets
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        viewLayout.collectionView.collectionViewLayout = layout
    }

    private func returnImageUrl(indexPath:IndexPath) -> String {
        let data = viewModel.photoData[indexPath.item]
        return viewModel.configureImageUrl(data: data)
    }
  

}

extension FlickerVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
        let width = UIScreen.main.bounds.width
        return CGSize(width: (width / 2) - 30, height: (width / 2) - 30)
        case 1:
            return CGSize(width: 100, height: 100)
        default:
            return CGSize.zero
        }
}
}

extension FlickerVC : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getRows(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell  : FlickrCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FlickrCell
            cell.imageUrl = returnImageUrl(indexPath: indexPath)
            return cell
        case 1:
            let cell:LoaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoaderCollectionViewCell", for: indexPath) as! LoaderCollectionViewCell
            page += 10
            getData(search: searchText)
            return cell
        default:
            return UICollectionViewCell()
        }
       
    }
}

extension FlickerVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text , !text.isEmpty else {return false}
        searchText = text
        getData(search: searchText )
        self.view.endEditing(true)
        return true
    }
    
     
}
