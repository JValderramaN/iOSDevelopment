//
//  ViewController.swift
//  Shopping Cart
//
//  Created by Office-UpperSky-Hackintosh on 3/11/15.
//  Copyright (c) 2015 UpperSky. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,writeValueBackDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonCart: UIBarButtonItem!
    @IBOutlet weak var sumlabel: UILabel!
    
    var cartCount : Int = 0
    var cartSum : Float = 0.0
    var productsList:NSMutableArray = []
    var addedProducts:NSMutableArray = []
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let cartVC: CartView = segue.destinationViewController as CartView
            cartVC.addedProducts = self.addedProducts
            cartVC.cartSum = self.cartSum
            cartVC.cartCount = self.cartCount
            cartVC.productsList = self.productsList
            cartVC.delegate = self
    }
    
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        buttonCart.title = "Cart \(cartCount)"
        sumlabel.text = "$ \(cartSum)"
        
        println(productsList.count, " +")
        //println(cartCount)
        //println(cartSum)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPList()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ProductCell = tableView.dequeueReusableCellWithIdentifier("cellDetail") as ProductCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.nameLabel.text = productsList[indexPath.row]["name"] as? String
        
        let price = (productsList[indexPath.row]["price"] as Int)
        cell.priceLabel.text = "\(price)"
        
        let stock = (productsList[indexPath.row]["stock"] as Int)
        cell.stockLabel.text = "\(stock)"
        
        cell.buttonBuy.addTarget(self, action: "addToCart:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    func addToCart(sender: UIButton){
        
        cartCount += 1
        
        buttonCart.title = "Cart \(cartCount)"
        
        let point = tableView.convertPoint(CGPoint(), fromView: sender)
        let index : NSIndexPath = tableView.indexPathForRowAtPoint(point)!
        
        let name : String = (productsList[index.row]["name"] as String)
        
        let stock : Int = (productsList[index.row]["stock"] as Int)
        
        let price : Float = (productsList[index.row]["price"] as Float)
        cartSum += price
        sumlabel.text = "$ \(cartSum)"
        
        
        var product : NSMutableDictionary  = ["name":name, "price": price, "stock": 1,"index":index.row]
        
       // producto["name"] = " ghasd"
        
        addProduct(product)
        
        if(stock == 1){
            productsList.removeObjectAtIndex(index.row)
            
        }else{
            productsList[index.row].setValue(stock - 1, forKey: "stock")
        }
        
        tableView.reloadData()
    }
    
    func addProduct(p : NSMutableDictionary){
        
       
        
        var sw : Bool = false
        for product in addedProducts{
            if(product["name"] as String == p["name"] as String){
                let stock : Int = (product["stock"] as Int)
                product.setValue(stock + 1, forKey: "stock")
                sw = true
                break
            }
        }
        
        if(!sw){
            addedProducts.addObject(p)
        }
    }
    
    func loadPList(){
        var pathToPList:NSString = NSBundle.mainBundle().pathForResource("dummyDataProducts", ofType: "plist")!
        productsList = NSMutableArray(contentsOfFile: pathToPList)!
        
        
        
        /*
        for albumInfo in productsList {
            println(albumInfo["stock"] as Int)
        }
        */
        
        //defaultAlbumPlist[19]["stock"] as Int - 1
        //productsList[19].setValue(20, forKey: "stock")
        
        //println(productsList[19]["stock"] as Int)
    }
    
    @IBAction func buttonCartTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showCart", sender: self)
    }
   
    func writeValueBack(sum : Float, count : Int){
        cartCount = count
        cartSum = sum
    }
    
}

