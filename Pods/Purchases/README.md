[![RevenueCat](https://s3.amazonaws.com/www.revenuecat.com/assets/images/logo_red200.png)](https://www.revenuecat.com)
## Purchases.framework

[![Version](https://img.shields.io/cocoapods/v/Purchases.svg?style=flat)](https://cocoapods.org/pods/Purchases)
[![License](https://img.shields.io/cocoapods/l/Purchases.svg?style=flat)](http://cocoapods.org/pods/Purchases)


Purchases is a client for the [RevenueCat](https://www.revenuecat.com/) subscription and purchase tracking system. It is an open source framework that provides a wrapper around `StoreKit` and the RevenueCat backend to make implementing iOS in app purchases easy.


## Installation

*Purchases* is available through [CocoaPods](https://cocoapods.org/) and [Carthage](https://github.com/Carthage/Carthage)

### CocoaPods
```
pod "Purchases"
```

### Carthage
```
github "revenuecat/purchases-ios"
```

## Getting Started

#### 1. Create a RevenueCat Account

Go to [RevenueCat](http://www.revenuecat.com), create an account, and obtain an API key for your application.

#### 2. In your app instantiate an `RCPurchases` object with your secret.

```swift
import Purchases

self.purchases = RCPurchases(apiKey: "myappapikey",
                             appUserID: "uniqueidforuser")!
```

```obj-c
#import <Purchases/Purchases.h>

RCPurchases *purchases = [[RCPurchases alloc] initWithAPIKey:@"myappAPIKey"
                                                   appUserID:@"uniqueidforuser"];
```

#### 3. Create a delegate to handle new purchases and purchaser info.

```swift
self.purchases.delegate = self

func purchases(_ purchases: RCPurchases,
          completedTransaction transaction: SKPaymentTransaction,
          withUpdatedInfo purchaserInfo: RCPurchaserInfo) {
  DispatchQueue.main.async {
    self.handleNewPurchaserInfo(info: purchaserInfo)
  }
}

func purchases(_ purchases: RCPurchases,
                   failedTransaction transaction: SKPaymentTransaction,
                   withReason failureReason: Error) {
  DispatchQueue.main.async {
    displayErrorMessage((failureReason as! NSError).localizedDescription)
  }
}

func purchases(_ purchases: RCPurchases, receivedUpdatedPurchaserInfo purchaserInfo: RCPurchaserInfo) {
  DispatchQueue.main.async {
    handleNewPurchaserInfo(info: purchaserInfo)
  }
}
```

```obj-c
purchases.delegate = delegateObject;

- (void)purchases:(RCPurchases *)purchases
    completedTransaction:(SKPaymentTransaction *)transaction
         withUpdatedInfo:(RCPurchaserInfo *)purchaserInfo {
         [self saveNewPurchaserInfo:purchaserInfo];
}

- (void)purchases:(RCPurchases *)purchases 
failedTransaction:(SKPaymentTransaction *)transaction 
       withReason:(NSError *)failureReason {
       [self displayErrorMessage:failureReason.localizedDescription];
}

- (void)purchases:(RCPurchases *)purchases receivedUpdatedPurchaserInfo:(RCPurchaserInfo *)purchaserInfo {
  [self saveNewPurchaserInfo:purchaserInfo]; 
}

```

#### 4. Fetch products
```swift

productIDs = /* */

self.purchases.products(withIdentifiers: productIDs) { (products) in
  if producst.count == 0 {
    displayErrorMessage:("Error fetching products")
  } else {
    let mySubscriptionProduct = products[0]
    displayProduct(mySubscriptionProduct);
  }
}

```

```obj-c

NSSet *myProductIDs = [NSSet setWithArray:@["com.myapp.subscription_product"]];

[self.purchases productsWithIdentifiers:myProductIDs completion:^(NSArray<SKProduct *> * _Nonnull products) {
  if (products.count == 0) {
    [self displayErrorMessage:@"Error fetching products"];
  } else {
    SKProduct *mySubscriptionProduct = products[0];
    [self displayProduct:mySubscriptionProduct];
  }
}]

```

#### 5. Make a purchase
```swift
self.purchases.makePurchase(mySubscriptionProduct)
```

```obj-c
[purchases makePurchase:mySubscriptionProduct];
```

#### 7. Handle user information updates
The latest purchaser information can come at any time, be prepared to receive it

```swift
func purchases(_ purchases: RCPurchases,
               receivedUpdatedPurchaserInfo purchaserInfo: RCPurchaserInfo) {
    DispatchQueue.main.async {
      self.handleNewPurchaserInfo(info: purchaserInfo)
    }
}
```

```obj-c
- (void)purchases:(RCPurchases *)purchases receivedUpdatedPurchaserInfo:(RCPurchaserInfo *)purchaserInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self handleNewPurchaserInfo:purchaserInfo];
    });
}
```

#### 6. Make $$$

That's it. RevenueCat will handle all purchase verification and purchase tracking for you so you can focus on building your app.
