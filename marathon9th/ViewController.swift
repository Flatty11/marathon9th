//
//  ViewController.swift
//  marathon9th
//
//  Created by Илья on 7/27/23.
//

import UIKit

class ViewController: UIViewController {

    let cellId = "UICollectionViewCell"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Коллекция"
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            collectionView.heightAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.75, height: collectionView.frame.width )
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .systemIndigo
        cell.layer.cornerRadius = 8
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionView.layoutMargins.left, bottom: 0, right: collectionView.layoutMargins.right)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let target = targetContentOffset.pointee
        let centerXY = CGPoint(x: target.x + collectionView.bounds.width / 2, y: target.y + collectionView.bounds.height / 2)
        guard let indexPath = collectionView.indexPathForItem(at: centerXY) else { return }
        guard let cellAttributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        let insets = collectionView.contentInset
        let cellSize = cellAttributes.frame.size
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0

        let newX = round((target.x - insets.left) / (cellSize.width + spacing)) * (cellSize.width + spacing) + insets.left
        targetContentOffset.pointee = CGPoint(x: newX, y: target.y)

        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
    }
}




