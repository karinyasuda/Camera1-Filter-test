//
//  ViewController.swift
//  Camera1
//
//  Created by Karin on 2016/04/06.
//  Copyright © 2016年 Karin. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //撮った写真を表示させるため
    @IBOutlet var cameraImage : UIImageView!
    @IBOutlet var saveButton : UIButton!
    @IBOutlet var selectButton : UIButton!
    @IBOutlet var takePhotoButton:UIButton!

    
    @IBOutlet var sepiaButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //写真を撮る　カメラの起動
    @IBAction func takePhoto(){
    
        //カメラの使用が可能かを調べる
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
        
            let imagepicker:UIImagePickerController = UIImagePickerController()
            imagepicker.delegate = self
            //カメラへのアクセス
            imagepicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagepicker, animated: true, completion: nil)
        
        }
            //難しければ、"error"とログを表示
        else{
            print("error")
        }
    
    }
    
    
    
    @IBAction func selectPhoto(){
        //フォトライブラリにアクセスが可能かを調べる
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            
            let imagepicker:UIImagePickerController = UIImagePickerController()
            imagepicker.delegate = self
            //カメラへのアクセス
            imagepicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagepicker, animated: true, completion: nil)
            
        }
            //難しければ、"error"とログを表示
        else{
            print("error")
        }
    }
    
    //imageviewに表示されているものをカメラロールに保存
    @IBAction func save (){
        var imageView:UIImage!
        imageView = cameraImage.image
        
        if imageView != nil{
            UIImageWriteToSavedPhotosAlbum(imageView, self, nil, nil)
        }
    }
    
    
    //撮影終了時に呼び出される
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if info [UIImagePickerControllerOriginalImage] != nil {
            
            cameraImage.image = (info[UIImagePickerControllerOriginalImage]  as? UIImage!)!
        }
        //閉じる処理？
        dismissViewControllerAnimated(true, completion: nil)
    }

 
    
    
    @IBAction func filter(sender: UIButton){
        
    
//    MARK:RGBColorFilter
//        CIImage *cameraImage = [CIImage imageWithCGImage:uiImage.CGImage]
        
        // カラーエフェクトを指定してCIFilterをインスタンス化.
        let myColorFilter = CIFilter(name: "CIColorCrossPolynomial")
        
        // イメージの!セット.
        myColorFilter!.setValue(CIImage(image: cameraImage.image!), forKey: kCIInputImageKey)
        
        let r: [CGFloat] = [0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        let g: [CGFloat] = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        let b: [CGFloat] = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        // モノクロ化するための値の調整.
        myColorFilter!.setValue(CIVector(values: r, count: 10), forKey: "inputRedCoefficients")
        myColorFilter!.setValue(CIVector(values: g, count: 10), forKey: "inputGreenCoefficients")
        myColorFilter!.setValue(CIVector(values: b, count: 10), forKey: "inputBlueCoefficients")

        // フィルターを通した画像をアウトプット.
        let myOutputImage : CIImage = myColorFilter!.outputImage!
        
        // 再びUIViewにセット.
        cameraImage.image = UIImage(CIImage: myOutputImage)
        
        // 再描画.
        cameraImage.setNeedsDisplay()
    
    
    
    //MARK:SepiaFilter
//        
//        
//        let mySepiaFilter = CIFilter(name: "CISepiaTone")
//        
//        mySepiaFilter!.setValue(cameraImage, forKey: kCIInputImageKey)
//        
//        mySepiaFilter!.setValue(1.0, forKey: kCIInputIntensityKey)
//        
//        let myOutputImage : CIImage = mySepiaFilter!.outputImage!
//        
//        cameraImage.image = UIImage(CIImage: myOutputImage)
        
//        cameraImage.setNeedsDisplay()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

