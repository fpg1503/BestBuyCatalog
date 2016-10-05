import XCTest
@testable import BestBuyCatalog

class ProductDecodingTests: XCTestCase {

    func testDecodeProduct() {
        let dictionary: [String: Any?] = ["sku":4870904,"productId":4870904,"name":"Nikon - D5 DSLR Camera Dual CF (Body Only) - Black","source":"bestbuy","type":"HardGood","startDate":"2016-01-05","new":false,"active":true,"lowPriceGuarantee":true,"activeUpdateDate":"2016-10-03T18:37:08","regularPrice":6499.99,"salePrice":6499.99,"clearance":false,"onSale":false,"planPrice":nil,"priceWithPlan":[],"priceRestriction":nil,"priceUpdateDate":"2016-01-06T00:00:37","digital":false,"preowned":false,"carrierPlans":[],"technologyCode":nil,"carrierModelNumber":nil,"earlyTerminationFees":[],"outletCenter":nil,"secondaryMarket":nil,"frequentlyPurchasedWith":[],"accessories":[],"relatedProducts":[],"techSupportPlans":[],"salesRankShortTerm":nil,"salesRankMediumTerm":nil,"salesRankLongTerm":nil,"bestSellingRank":nil,"url":"https://api.bestbuy.com/click/-/4870904/pdp","spin360Url":nil,"mobileUrl":"https://api.bestbuy.com/click/-/4870904/pdp","affiliateUrl":nil,"addToCartUrl":"https://api.bestbuy.com/click/-/4870904/cart","affiliateAddToCartUrl":nil,"linkShareAffiliateUrl":"","linkShareAffiliateAddToCartUrl":"","upc":"018208015580","productTemplate":"Digital_Cameras","categoryPath":[["id":"cat00000","name":"Best Buy"],["id":"abcat0400000","name":"Cameras & Camcorders"],["id":"abcat0401000","name":"Digital Cameras"],["id":"abcat0401005","name":"Digital SLR Cameras"],["id":"pcmcat180000050013","name":"DSLR Body Only"]],"lists":[],"customerReviewCount":nil,"customerReviewAverage":nil,"customerTopRated":false,"format":nil,"freeShipping":true,"freeShippingEligible":true,"inStoreAvailability":true,"inStoreAvailabilityText":"Store Pickup:","inStoreAvailabilityUpdateDate":"2016-10-03T18:37:08","itemUpdateDate":"2016-10-08T09:39:37","onlineAvailability":true,"onlineAvailabilityText":"Shipping: Usually ships in 1 business day","onlineAvailabilityUpdateDate":"2016-10-03T18:37:08","releaseDate":"2016-04-25","shippingCost":0.00,"shipping":[["ground":"","secondDay":0.00,"nextDay":31.92,"vendorDelivery":""]],"shippingLevelsOfService":[["serviceLevelId":4,"serviceLevelName":"Two Day","unitShippingPrice":0.00],["serviceLevelId":5,"serviceLevelName":"One Day","unitShippingPrice":31.92]],"specialOrder":false,"shortDescription":"20.8-megapixel FX-format CMOS sensorISO 100-102,400, expandable to 3,280,000Shooting speeds up to 12 fps153 focus points (99 cross-type)4K UHD video recording","class":"DSLR DIGITAL SLR","classId":363,"subclass":"DSLR CAMERAS","subclassId":205,"department":"PHOTO/COMMODITIES","departmentId":5,"buybackPlans":[],"protectionPlans":[],"productFamilies":[],"description":nil,"manufacturer":"Nikon","modelNumber":"1558","image":"http://img.bbystatic.com/BestBuy_US/images/products/4870/4870904_sa.jpg","largeFrontImage":"http://img.bbystatic.com/BestBuy_US/images/products/4870/4870904_sa.jpg","mediumImage":"http://img.bbystatic.com/BestBuy_US/images/products/4870/4870904fp.gif","thumbnailImage":"http://img.bbystatic.com/BestBuy_US/images/products/4870/4870904_s.gif","largeImage":"http://img.bbystatic.com/BestBuy_US/images/products/4870/4870904_sb.jpg","alternateViewsImage":nil,"angleImage":nil,"backViewImage":"http://img.bbystatic.com/BestBuy_US/images/products/4870/4870904_ba.jpg","energyGuideImage":nil,"leftViewImage":nil,"accessoriesImage":nil,"remoteControlImage":nil,"rightViewImage":nil,"topViewImage":nil,"condition":"New","inStorePickup":true,"friendsAndFamilyPickup":false,"homeDelivery":false,"quantityLimit":3,"fulfilledBy":"BestBuy.com","bundledIn":[],"color":"Black","depth":"3.7 inches","dollarSavings":0.00,"percentSavings":"0.0","tradeInValue":"","height":"6.3 inches","orderable":"Available","weight":"3.1 pounds","shippingWeight":"6.72","width":"6.3 inches","warrantyLabor":"1 year","warrantyParts":"1 year","longDescription":"The Nikon D5 digital SLR CF camera body takes up to 200 photos per burst with 12 fps. It can record video at 4K UHD and has the widest native ISO range in a full-range DSLR. The 20.8MP FX-format CMOS sensor improves the quality and speed of the Nikon D5 digital SLR CF camera body.","includedItemList":[["includedItem":"Fluorine-coated finder eyepiece (DK-17F), eyepiece adapter (DK-27)"],["includedItem":"Nikon D5 DSLR Camera Dual CF (Body Only)"],["includedItem":"Owner's manual"],["includedItem":"Rechargeable Li-ion battery(EN-EL18a), battery charger (MH-26a), battery chamber cover (BL-6)"],["includedItem":"Strap (AN-DC15), body cap (BF-1B ), accessory shoe cover (BS-3)"],["includedItem":"USB cable (UC-E22), USB and HDMI Cable Clips"]],"marketplace":false,"listingId":nil,"sellerId":nil,"shippingRestrictions":nil,"displayType":"LCD touch screen","screenSizeIn":3.2]

        let decodedProduct = Product(dictionary: dictionary)
        let createdProduct = Product(sku: 4870904, name: "Nikon - D5 DSLR Camera Dual CF (Body Only) - Black", regularPrice: 6499.99, salePrice: 6499.99, onSale: false, url: URL(string: "https://api.bestbuy.com/click/-/4870904/pdp"), shortDescription: "20.8-megapixel FX-format CMOS sensorISO 100-102,400, expandable to 3,280,000Shooting speeds up to 12 fps153 focus points (99 cross-type)4K UHD video recording", longDescription: "The Nikon D5 digital SLR CF camera body takes up to 200 photos per burst with 12 fps. It can record video at 4K UHD and has the widest native ISO range in a full-range DSLR. The 20.8MP FX-format CMOS sensor improves the quality and speed of the Nikon D5 digital SLR CF camera body.", manufacturer: "Nikon", thumbnailImageURL: URL(string: "http://img.bbystatic.com/BestBuy_US/images/products/4870/4870904_s.gif"), imageURL: URL(string:"http://img.bbystatic.com/BestBuy_US/images/products/4870/4870904_sa.jpg"))

        XCTAssertEqual(decodedProduct, createdProduct)
    }

    func testDecodeProdcutEmpty() {
        let dictionary: [String: AnyObject] = [:]

        let decodedProduct = Product(dictionary: dictionary)

        XCTAssertNil(decodedProduct)
    }
    
}
