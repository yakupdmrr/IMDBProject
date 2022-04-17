//
//  MainViewController.swift
//  IMDBProject
//
//  Created by Yakup Demir on 15.04.2022.
//

import SDWebImage
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    private var upComingMovieList = [Movie]()
    private var nowPlayingMovieList = [Movie]()
    private var imdbMoviewUpcomingListViewModel: ImdbListViewModel?
    private var imdbMoviewNowPlayingListViewModel: ImdbListViewModel?
    private lazy var chosenMovie = Movie()
    private let refreshControl = UIRefreshControl()
    private var pageIndex = 1
    private var totalCount : Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        collectionView.delegate = self
        collectionView.dataSource = self

        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        collectionView.register(UINib(nibName: "MainSliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sliderCell")

        getMovieUpcomingData(false,index: pageIndex)

        getNowPlayingMovieData()
        refreshing()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }

    private func refreshing() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc func refreshTableView(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.pageIndex = 1
            self.imdbMoviewUpcomingListViewModel?.movieList.removeAll(keepingCapacity: false)
            self.getMovieUpcomingData(false,index: self.pageIndex)
            self.tableView.reloadData()
        }
    }

    // MARK: Get Upcoming Movie Data

    private func getMovieUpcomingData(_ isPaging : Bool ,index: Int) {
        MovieManager.instance.getUpcomingMovie(page: index, apiKey: Utils.instance.getApiKey()) { status,result in
            
            guard status else {
                AlertManager.instance.showErrorMessage(title : "Hata", messsage: "Bir hata meydana geldi",complation: nil)
                return
            }
            
            if let totalPages = result.total_pages {
                self.totalCount = totalPages
            }
            
            if let resultData = result.results {
                
                if isPaging {
                    self.upComingMovieList.append(contentsOf: resultData)
                }else {
                    self.upComingMovieList = resultData
                }
                self.imdbMoviewUpcomingListViewModel = ImdbListViewModel(movieList: self.upComingMovieList)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
                if !self.upComingMovieList.isEmpty {
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }

    // MARK: Get Now Playing Movie Data

    private func getNowPlayingMovieData() {
        MovieManager.instance.getNowPlayingMovie(apiKey: Utils.instance.getApiKey()) { status,result in
            
            guard status else {
                AlertManager.instance.showErrorMessage(title : "Hata", messsage: "Bir hata meydana geldi",complation: nil)
                return
            }
            if let resultData = result.results {
                self.nowPlayingMovieList = resultData
                self.imdbMoviewNowPlayingListViewModel = ImdbListViewModel(movieList: self.nowPlayingMovieList)
                
                DispatchQueue.main.async {
                    self.pageControl.numberOfPages = self.imdbMoviewNowPlayingListViewModel?.numberOfSection() ?? 0
                    self.collectionView.reloadData()
                }
            }
        }
    }

    private func gotoDetailVc(viewModel: ImdbListViewModel, indexPath: Int) {
        let vc: DetailsViewController = DetailsViewController.loadFromNib()
        chosenMovie = viewModel.movieList[indexPath]
        vc.id = chosenMovie.id ?? 0
        pushVC(controller: vc)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imdbMoviewUpcomingListViewModel?.numberOfSection() ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = imdbMoviewUpcomingListViewModel {
            gotoDetailVc(viewModel: viewModel, indexPath: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell

        let movie = imdbMoviewUpcomingListViewModel?.movieAtIndex(indexPath.row)

        var imagePath = ""
        if let posterPath = movie?.poster_path {
            imagePath = posterPath
        }

        var year = ""
        if let releaseYear = movie?.release_date {
            year = String(releaseYear.prefix(4))
        }
        var title = ""
        if let movieTitle = movie?.title {
            title = movieTitle
        }

        let imageUrl = Utils.instance.imageBaseUrl() + imagePath
        cell.xDimage.sd_setImage(with: URL(string: imageUrl))
        cell.titleLabel.text = "\(title) (\(year))"
        cell.dateLabel.text = movie?.release_date.formatDateString()
        
        cell.descriptionLabel.text = movie?.overview
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let arrayCount = imdbMoviewUpcomingListViewModel?.numberOfSection() else {return}
        if indexPath.row == (arrayCount-1), pageIndex <= totalCount {
            pageIndex += 1
            getMovieUpcomingData(true,index: pageIndex)
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imdbMoviewNowPlayingListViewModel?.numberOfSection() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! MainSliderCollectionViewCell

        let movie = imdbMoviewNowPlayingListViewModel?.movieAtIndex(indexPath.row)

        var imagePath = ""
        if let posterPath = movie?.backdrop_path {
            imagePath = posterPath
        }

        let imageUrl = Utils.instance.imageBaseUrl() + imagePath
        
        var title = ""
        if let movieTitle = movie?.title {
            title = movieTitle
        }
        
        var year = ""
        if let releaseYear = movie?.release_date {
            year = String(releaseYear.prefix(4))
        }

        cell.slideTitleLabel.text = "\(title) (\(year))"
        cell.slideOwerViewLabel.text = movie?.overview
        cell.imageView.sd_setImage(with: URL(string: imageUrl))

        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = imdbMoviewNowPlayingListViewModel {
            gotoDetailVc(viewModel: viewModel, indexPath: indexPath.row)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 260)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
