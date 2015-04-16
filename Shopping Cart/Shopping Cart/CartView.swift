//
//  CartView.swift
//  Shopping Cart
//
//  Created by Office-UpperSky-Hackintosh on 3/11/15.
//  Copyright (c) 2015 UpperSky. All rights reserved.
//

import UIKit



//protol to retrieve info between views
protocol writeValueBackDelegate{
    
    func writeValueBack(sum: Float, count: Int)
    
}

class CartView: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var cartCount : Int = 0
    var cartSum : Float = 0.0
    var productsList:NSMutableArray = []
    var addedProducts:NSMutableArray = []
    
    var delegate : writeValueBackDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // println(addedProducts)

        
        // Do any additional setup after loading the view.

    }
    
    override func viewDidAppear(animated: Bool) {
        //println(addedProducts)
          //  println(cartCount)
            //println(cartSum)
        
        //advice
        if addedProducts.count > 0 {
            var alert = UIAlertController(title: "Advice", message: "Slide left over the row to delete the product", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func buttonBack(sender: UIButton) {
        
        delegate?.writeValueBack(cartSum,count: cartCount)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedProducts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ProductCell = tableView.dequeueReusableCellWithIdentifier("cellDetail") as ProductCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let name = (addedProducts[indexPath.row]["name"] as? String)
        cell.nameLabel.text =  name
        
        let price = (addedProducts[indexPath.row]["price"] as Int)
        cell.priceLabel.text = "\(price)"
        
        let stock = (addedProducts[indexPath.row]["stock"] as Int)
        cell.stockLabel.text = "\(stock)"
        
       
        
        return cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let stock : Int = (addedProducts[indexPath.row]["stock"] as Int)
        let name = addedProducts[indexPath.row]["name"] as String
        let price = addedProducts[indexPath.row]["price"] as Float
        cartSum -= price
        cartCount -= 1
        
       
        let indexFound = exist(name)
        if indexFound != -1{
            let stockList : Int = productsList[indexFound]["stock"] as Int
            //println(stockList)
            productsList[indexFound].setValue(stockList + 1, forKey: "stock")
        }else{
            //println(addedProducts.count," **")
            var prodc : NSMutableDictionary  = ["name":name, "price": price, "stock": 1]
            productsList.addObject(prodc)
            //println(addedProducts[indexPath.row]["stock"])
            //println(productsList.count, " -")
        }
        
        if stock == 1 {
            //delete in cart
            addedProducts.removeObjectAtIndex(indexPath.row)
        }else{
            //decreaase in cart
            addedProducts[indexPath.row].setValue(stock - 1, forKey: "stock")
        }
        
        tableView.reloadData()
    }
    
    //true if the current product exist in the original list
    func exist(pName : String)-> Int{
        var rsl = -1
        
        for i in 0...productsList.count-1{
            let product: AnyObject = productsList.objectAtIndex(i)
            if(product["name"] as String == pName){
                //println(product["name"] as String," - ",pName)
                rsl = i
                break
            }
        }
        
        return rsl
    }

}



