//
//  ViewController.swift
//  SwitchTuistFinalTest
//
//  Created by Muzlive_Player on 2023/08/09.
//

import UIKit
import SnapKit

import RxSwift
import RxCocoa

import AssetsPickerViewController
import Photos

class ViewController: UIViewController {
    private let assetsViewControllerButton = UIButton()
    
    lazy var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setupView()
        setupLayout()
        setupAttribute()
        setupBinding()
    }
}

extension ViewController {
    private func setupView(){
        [
            assetsViewControllerButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupLayout() {
        assetsViewControllerButton.snp.makeConstraints {
            $0.height.width.equalTo(150)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupAttribute(){
        assetsViewControllerButton.backgroundColor = .red
        assetsViewControllerButton.setTitle("assetsVCButton", for: .normal)
    }
    
    private func setupBinding(){
        assetsViewControllerButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                let nextVC = self.setupAssetsPickerView()
                nextVC.modalPresentationStyle = .overFullScreen
                self.present(nextVC, animated: false)
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController {
    private func setupAssestConfig() -> AssetsPickerConfig {
        let predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        
        let options = PHFetchOptions()
        options.predicate = predicate
        
        let config = AssetsPickerConfig()
        config.albumIsShowEmptyAlbum = false
        config.assetFetchOptions = [.smartAlbum: options]
        config.assetsMaximumSelectionCount = 1
        return config
    }
    
    private func setupAssetsPickerView() -> AssetsPickerViewController {
        let picker = AssetsPickerViewController()
        picker.pickerConfig = setupAssestConfig()
        return picker
    }
}

