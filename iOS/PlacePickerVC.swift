//
//  PlacePickerVC.swift
//  GooglePlaces
//
//  Created by Mac-Vishal on 07/07/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

import UIKit
import GooglePlacePicker
import DialogBox
import RSLoadingView

class PlacePickerVC: UIViewController {
    
    var locationManager = CLLocationManager()

    @IBOutlet var lblName:UILabel!
    @IBOutlet var lblAddress:UILabel!
    @IBOutlet var lblLatitude:UILabel!
    @IBOutlet var lblLongitude:UILabel!
    @IBOutlet var indicatorView:UIActivityIndicatorView!
    
    @IBOutlet var viewContainer:UIView!
    @IBOutlet weak var placePhoto: UIImageView!
    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var lblAddressTitle: UILabel!
    
    @IBOutlet weak var lblBalance: UILabel!
    var selectedPlace:GMSPlace?
    var zip: String?
    var country: String?
    var street: String?
    
    var balance: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadingView = RSLoadingView()
        loadingView.mainColor = UIColor.green
        loadingView.show(on: view)
        
        //Authorization
        locationManager.requestAlwaysAuthorization()
        
        let tapDescription = UITapGestureRecognizer(target: self, action: #selector(PlacePickerVC.tapDescriptionFunction))
        lblName.isUserInteractionEnabled = true
        lblName.addGestureRecognizer(tapDescription)

        var tapAddress = UITapGestureRecognizer(target: self, action: #selector(PlacePickerVC.tapAddressFunction))
        lblAddress.isUserInteractionEnabled = true
        lblAddress.addGestureRecognizer(tapAddress)
        
        tapAddress = UITapGestureRecognizer(target: self, action: #selector(PlacePickerVC.tapAddressFunction))
        placePhoto.isUserInteractionEnabled = true
        placePhoto.addGestureRecognizer(tapAddress)

        tapAddress = UITapGestureRecognizer(target: self, action: #selector(PlacePickerVC.tapAddressFunction))
        lblAddressTitle.isUserInteractionEnabled = true
        lblAddressTitle.addGestureRecognizer(tapAddress)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.getPlacePickerView()
        })
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        lblName.text = appDelegate.foodDescription
    }
    
    func getPlacePickerView() {
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//
//        //only apply the blur if the user hasn't disabled transparency effects
//        if !UIAccessibilityIsReduceTransparencyEnabled() {
//            view.backgroundColor = .clear
//
//
//            //always fill the view
//            blurEffectView.frame = self.view.bounds.offsetBy(dx: 0, dy: -20)
//            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//            view.clipsToBounds = false
//            view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
//        } else {
//            view.backgroundColor = .black
//        }
        
        let loadingView = RSLoadingView()
        loadingView.mainColor = UIColor.green
        loadingView.show(on: view)
        
        //return
        
        let json: [String: Any] =
        [
            "address": self.street!,
            "latitude": self.lblLatitude.text!,
            "longitude": self.lblLongitude.text!,
            "country": self.country!,
            "zipcode": self.zip!,
            "description": self.lblName.text!,
            "status": "Available"
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://lit-sierra-23258.herokuapp.com/givers.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
//            DispatchQueue.main.async {
                //blurEffectView.removeFromSuperview()
                
                RSLoadingView.hide(from: self.view)
                self.showSuccessDialog()
            })
        }
        
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showFoodDescriptionView() {
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    
    func tapDescriptionFunction(sender:UITapGestureRecognizer) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "FoodDescriptionVC")
//        self.present(controller, animated: true, completion: nil)
        
        // Safe Present
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodDescriptionVC") as? FoodDescriptionVC
        {
            present(vc, animated: true, completion: nil)
        }
    }
    
    func tapAddressFunction(sender:UITapGestureRecognizer) {
        self.getPlacePickerView()
    }
    
    func showSuccessDialog() {
        var appearance = BoxAppearance()
        
        // Layout
        appearance.layout.backgroundColor = UIColor.init(red: 99.0/255.0, green: 157.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        appearance.layout.cornerRadius = 10.0
        appearance.layout.width = 300.0
        
        // Title
        appearance.title.textColor = UIColor.white
        appearance.title.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        // Message
        appearance.message.textColor = UIColor.white
        appearance.message.font = UIFont.systemFont(ofSize: 17.0)
        
        // Icon
        appearance.icon.type = BoxIconType.image
        appearance.icon.image.name = "logo3"
        appearance.icon.margin = "0|30|0|20"
        appearance.icon.position = BoxIconPosition.topCenter
        appearance.icon.size = CGSize(width: 116, height: 117)
        
        // Animation
        appearance.animation = BoxAnimationType.bounce
        
        // Button
        appearance.button.height = 40.0
        appearance.button.titleFont = UIFont.boldSystemFont(ofSize: 17.0)
        appearance.button.bottomPosition.cornerRadius = 20
        appearance.button.backgroundColor = UIColor.init(red: 99.0/255.0, green: 157.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        appearance.button.titleFont = UIFont.boldSystemFont(ofSize: 17.0)
        appearance.button.textColor = UIColor.white
        appearance.button.borderColor = UIColor.white
        appearance.button.borderWidth = 2.0
        appearance.button.containerMargin = "70|20|70|40"
        
        DialogBox.show(title: "Thank you", message: "You just help one more needy", boxApp: appearance, buttonTitle: "OK", buttonAppearance: nil, actionBlock: {
            
            // Action block
            
            //self.animateNumberChange()
            self.getNewBalance()
            
        })
    }
    
    func animateNumberChange() {
        guard let currentDisplayBalanceStr = lblBalance.text else {
            return;
        }

        guard let currentDisplayBalance = Int(currentDisplayBalanceStr) else {
            return;
        }
        
        if (currentDisplayBalance >= balance) {
            return;
        }
        
        let newDisplayBalance = currentDisplayBalance + 10;
        
        
        //if (currentCash <= 50) {
        //}
        
//        currentBtc = currentBtc - 0.01;
//        if (currentBtc >= 0) {
//            btcAmount.text = String(format: "%.2f", currentBtc)
//        }
        
        //if (currentCash < 50) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.lblBalance.text = String(format: "%d", newDisplayBalance)
                self.animateNumberChange()
            })
        //}
    }
}

extension PlacePickerVC : GMSPlacePickerViewControllerDelegate
{
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        
        selectedPlace = place
        self.viewContainer.isHidden = false
        self.indicatorView.isHidden = true
        RSLoadingView.hide(from: self.view)
        
        viewController.dismiss(animated: true, completion: nil)
        
        self.lblLocationName.text = place.name
        self.lblAddress.text = place.formattedAddress?.components(separatedBy: ", ")
            .joined(separator: "\n")
        self.lblLatitude.text = String(place.coordinate.latitude)
        self.lblLongitude.text = String(place.coordinate.longitude)
        
        if let addressComponents = place.addressComponents {
            for component in addressComponents {
                print(component.type)
                print(component.name)
                if component.type == "postal_code" {
                    print(component.name)
                    self.zip = component.name
                }
                if component.type == "country" {
                    print(component.name)
                    self.country = component.name
                }
                if component.type == "route" {
                    print(component.name)
                    self.street = component.name
                }
            }
        }
        
        self.loadFirstPhotoForPlace(placeID: place.placeID)
        //self.loadStreetViewPhoto(place: place)
        
        getBalance()
    }
    
    func getBalance() {
        let url = URL(string: "https://lit-sierra-23258.herokuapp.com/givers/get_current_lumnes.json")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data, error == nil else {
                            print(error?.localizedDescription ?? "No data")
                            return
                        }
                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                        if let responseJSON = responseJSON as? [String: Any] {
                            print(responseJSON)

                            if let strBalance = responseJSON["balance"] as? String {
                                let dBalance = Double(strBalance)
                                self.balance = Int(dBalance!)
                                DispatchQueue.main.async {
                                    self.lblBalance.text = String(format: "%d", self.balance)
                                }
                            }
                        }
        }
        
        task.resume()
    }
    
    func getNewBalance() {
        let url = URL(string: "https://lit-sierra-23258.herokuapp.com/givers/get_current_lumnes.json")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                
                if let strBalance = responseJSON["balance"] as? String {
                    let dBalance = Double(strBalance)
                    self.balance = Int(dBalance!)
                    DispatchQueue.main.async {
                        self.animateNumberChange()
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        
        viewController.dismiss(animated: true, completion: nil)
        
        self.viewContainer.isHidden = false
        self.indicatorView.isHidden = true
        RSLoadingView.hide(from: self.view)
    }
    
    func loadStreetViewPhoto(place: GMSPlace) {
        
        let streetViewPhotoUrl = "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=\(place.coordinate.latitude),\(place.coordinate.longitude)&fov=90&heading=235&pitch=10&key=AIzaSyDqqeqAMuXG6zjP73ebcUVKQBbaQIjjG8E"
        
        if let url = URL(string: streetViewPhotoUrl) {
            self.downloadImage(url: url)
        }
    }
    
    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
                self.placePhoto.isHidden = true
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto)
                }
                else {
                    self.placePhoto.isHidden = true
                    self.placePhoto.isUserInteractionEnabled = false
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
                self.placePhoto.isHidden = true
            } else {
                self.placePhoto.isHidden = false
                self.placePhoto.image = photo;
            }
        })
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.placePhoto.image = UIImage(data: data)
            }
        }
    }

}
