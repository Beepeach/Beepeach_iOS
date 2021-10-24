//
//  ViewController.swift
//  PageControl
//
//  Created by JunHeeJo on 10/24/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    private var colors: [UIColor] = [
        .blue, .red, .green, .gray, .yellow
    ]
    
    // MARK: @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: @IBAction
    @IBAction func changePage(_ sender: Any) {
        let page: Int = pageControl.currentPage
        let indexPath: IndexPath = IndexPath(item: page, section: 0)
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        initPageControl()
    }
    
    private func initPageControl() {
        pageControl.numberOfPages = colors.count
        pageControl.pageIndicatorTintColor = .red
        pageControl.currentPageIndicatorTintColor = .black
    }
}


// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = colors[indexPath.item]
        
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}


// MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        print(scrollView.contentOffset)
        let width = scrollView.bounds.size.width
        let page = x / width
        
        pageControl.currentPage = Int(page)
    }
}
