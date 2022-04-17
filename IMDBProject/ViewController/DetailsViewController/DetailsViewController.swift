//
//  DetailsViewController.swift
//  IMDBProject
//
//  Created by Yakup Demir on 15.04.2022.
//

import SDWebImage
import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet var owerviewLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    var id: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        getMovie(id: id)
        mainImageView.contentMode = .scaleAspectFill
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    private func getMovie(id: Int) {
        MovieManager.instance.getMovie(id: id, apiKey: Utils.instance.getApiKey()) { status, result in

            guard status else {
                AlertManager.instance.showErrorMessage(title: "Hata", messsage: "Bir hata meydana geldi", complation: nil)
                return
            }
            var imagePath = ""
            if let posterPath = result.backdrop_path {
                imagePath = posterPath
            }
            DispatchQueue.main.async {
                self.title = result.title
                self.titleLabel.text = result.title
                self.owerviewLabel.text = result.overview
                self.ratingLabel.text = "\(String(result.vote_average ?? 0.0))/10"
                self.releaseDateLabel.text = result.release_date?.formatDateString()
                let imageUrl = Utils.instance.imageBaseUrl() + imagePath
                self.mainImageView.sd_setImage(with: URL(string: imageUrl))
            }
        }
    }
}
