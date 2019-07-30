ii//
//  ViewController.swift
//  cameraProject
//
//  Created by 星みちる on 2019/07/18.
//  Copyright © 2019 星みちる. All rights reserved.
//

import UIKit

//UIImagePickerControllerDeligate:カメラとかアルバムの約束事が入っている
class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
//カメラを起動する処理
    @IBAction func runCamera(_ sender: UIButton) {
    //1.カメラの仕様許可が得られているかチェック
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //カメラが許可されている場合
            
//2.カメラの画面作成 （カメラもしくはアルバム用の画面を作成）
            let cameraPicker = UIImagePickerController()
    cameraPicker.sourceType = .camera //カメラ用に設定
            cameraPicker.delegate = self //おまじない
        
            //3.カメラの画面を表示
        present(cameraPicker,animated: true,completion: nil)
        
            //present:画面を表示するためのメソッド
//            第一引数：表示したい画面
//            第二引数：アニメーションするかしないか
//            第３引数：画面表示後にしたい処理
            
        }
    }
    //アルバムを表示する処理
    @IBAction func showAlbum(_ sender: UIButton) {
        //1,フォトライブラリの使用許可が得られているかチェック
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            //フォトライブラリが許可されている場合
            //2.フォトライブラリの画面作成
        let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            //3.フォトライブラリの画面を作成
            present(imagePicker,animated: true,completion: nil)
            
        }
    
    //didfiで出る、カメラもしくは写真選択が終わった時に実行される処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage{
           
            //撮影or選択された写真を取得して、変数ぴpickedImageに入れる。
            //もしも写真が存在しない場合は、このif文は実行されない
            //引数infoの中から、写真が取り出せたらtrue、取り出せなかったらfalse
            
            //撮影or選択された写真を画面のImageviewに設定
            imageView.image = pickedImage
        }
//     カメラの画面を閉じる
       picker.dismiss(animated: true, completion: nil)
        }
    }
//    写真を保存する処理
    @IBAction func savePhoto(_ sender: UIButton) {
//    1.画面に表示されている画像を取得する
    let image = imageView.image
        
//        2.取得した画像をフォトライブラリに保存するiis
    //画像がnilじゃなければ
        if image != nil{
            //フォトライブラリに画像を保存する
        UIImageWriteToSavedPhotosAlbum(image!, self , #selector(didFinishSavePhoto(_:didFinishSavingWithError:contextInfo:)) , nil )
        
        }
        
    }
    
    //写真が保存された時に実行される処理
    @objc func didFinishSavePhoto(_ image: UIImage,
                                  didFinishSavingWithError error: NSError!,
                                  contextInfo: UnsafeMutableRawPointer) {
        
    print("保存しました")
        
        //保存が終わったら次の画面にいきたいときは
        //performsegueで遷移する
        
    }
    

    
}

