//
//  UrlConfig.h
//  test
//
//  Created by 家瓷网 on 2017/3/28.
//  Copyright © 2017年 test. All rights reserved.
//

#ifndef UrlConfig_h
#define UrlConfig_h





//#define kBaseURL        @"http://hqapi.jiaciwang.com/api"  //正式环境
//#define kIMAGE        @"http://hqapi.jiaciwang.com/file/v1/download-"//图片前缀   正式环境

//#define kBaseURL        @"http://192.168.1.215:38003/api"
//#define kIMAGE        @"http://192.168.1.215:38003/file/v1/download-"//图片前缀

#define kBaseURL        @"http://192.168.1.211:38003/api"
#define kIMAGE        @"http://192.168.1.211:38003/file/v1/download-"//图片前缀

//#define kLogin        @"http://ssl.jiaciwang.com/oauth/token"//登录  正式环境

#define kLogin        @"http://192.168.1.211:18003/oauth/token"//登录

#define kEditPassword        @"/ucenter/ucenter-change-pwd"//修改密码
#define kSendCode        @"/ucenter/ucenter-find-pwd-send-code-app"//发送验证码
#define kCheckCode        @"/ucenter/ucenter-mobile-verification-code-check-app"//校验验证码
#define kResetPassword        @"/ucenter/ucenter-find-pwd-reset-app"//重置密码
#define kCheckLogState        @"/property/franchisee-status"//验证登录状态


#define kCategory        @"/property/property-list-category-recommend-app"//顶部分类
#define kHomeGoods        @"/property/property-list-goods-recommend-app"//首页商品列表
#define kGoodsDetail        @"/property/property-detail-sku-info"//商品详情
#define kShopCarAmount        @"/property/franchisee-shopping-cart-count"//购物车商品数量

#define kBrandCategory        @"/property/franchisee-category-list-app"//品牌商品分类
#define kChildCategory        @"/property/franchisee-child-category-list-app"//子级分类

#define kGoodsList        @"/property/property-list-app"//商品列表可关键字查询

#define kAddShopCar        @"/property/franchisee-shopping-cart-add"//添加到购物车
#define kShopCarList        @"/property/franchisee-shopping-cart-list-app"//购物车列表
#define kShopRemove        @"/property/franchisee-shopping-cart-remove"//删除购物车商品
#define kShopToOrder        @"/property/franchisee-order-confirmation"//购物车商品下单
#define kShopOrderbyid        @"/property/franchisee-shopping-cart-list-by-id"//下单后确认订单
#define kOrderCashier        @"/property/franchisee-order-cashier-desk"//收银台信息
#define kShopCarBuyNow        @"/property/franchisee-shopping-cart-buy-now"//立即购买
#define kEditShopCarAmount        @"/property/franchisee-shopping-cart-change-amount"//修改购物车商品数量

#define kShopWalletOrderbyid        @"/property/franchisee-order-info-affirm-app"//下单后确认订单(带资金池)


#define kMessageList        @"/property/franchisee-notice-list"//消息列表
#define kMessageDetail        @"/property/franchisee-notice-detail.json"//消息详情
#define kMessageDelete        @"/property/franchisee-notice-remove.json"//删除消息
#define kNotReadMessage        @"/property/franchisee-notice-unreaded-num"//未读消息


#define kMine        @"/property/property-mine-index-app"//我的主页
#define kFeedback        @"/property/property-app-feedback"//意见反馈
#define kHelpCenter        @"/property/property-help-center-list-app.json"//帮助中心列表
#define kAreaDistrict        @"/property/franchisee-agency-area"//加盟商代理区域
#define kAppVersion        @"/property/property-app-version"//App版本信息

#define kAddressList        @"/property/franchisee-shipping-address-list"//地址列表
#define kAdd_Address        @"/property/franchisee-shipping-address-add"//添加收货地址
#define kEditAddress        @"/property/franchisee-shipping-address-edit"//编辑收货地址
#define kSingleAddress        @"/property/franchisee-shipping-address-find-one"//获取单条收货地址
#define kRemoveAddress        @"/property/franchisee-shipping-address-remove"//删除
#define kDefaultAddress        @"/property/franchisee-shipping-address-set-default"//设置默认
#define kPronvinceCity        @"/ucenter/sys-area-list"//获取地址省市区

#define kMyOrders        @"/property/franchisee-order-list-app"//我的订单列表
#define kMyOrderDetail        @"/property/franchisee-order-details"//我的订单详情

#define kCloudStorageList        @"/property/franchisee-cloud-storage-list-app"//云库存商品列表
#define kCloudStorageOrderDetail        @"/property/franchisee-cloud-storage-order-datail"//云库存货权明细
#define kCloudStorageSaleList        @"/property/franchisee-cloud-storage-sold-list-app"//云库存销售明细

#define kSendShopList        @"/property/franchisee-shipment-order-list-app"//发货订单列表
#define kSendShopListDetail        @"/property/franchisee-shipment-order-detail-app"//发货订单明细
#define kSureGetGoods        @"/property/franchisee-shipment-order-confirm-receipt"//确认收货
#define kLogisticsInfo        @"/property/franchisee-shipment-order-logistics-info"//物流信息
#define kReadySendList        @"/property/franchisee-shipment-pitch-on-list-app"//准备发货列表
#define kBillInfo        @"/property/franchisee-dispatch-bill-info-app"//发货单信息
#define kBillCommit        @"/property/franchisee-dispatch-bill-submit"//发货单提交

#define kwalletRecord        @"/property/franchisee-finance-fun-record-list-app"//资金池交易记录
#define kwalletRecordDetail        @"/property/franchisee-finance-fun-record-detail"//资金池交易记录明细
#define kwithdrawList        @"/property/franchisee-finance-withdraw-list-app"//提现管理记录
#define kwithdrawInfo        @"/property/franchisee-finance-withdraw-init-app"//提现管理初始信息
#define kwithdrawApply        @"/property/franchisee-finance-withdraw-apply"//提现申请


//#define kGoodsDetailHtml        @"http://hqapi.jiaciwang.com/goods-detail.html?goodsId="//商品详情h5  正式环境
//#define kHelpCenterHtml        @"http://hqapi.jiaciwang.com/goods-helpcenter.html?helpId="//帮助中心h5  正式环境
//#define kAboutJiaci        @"http://hqapi.jiaciwang.com/goods-about_us.html"//关于家瓷网  正式环境

#define kGoodsDetailHtml        @"http://192.168.1.211:38003/goods-detail.html?goodsId="//商品详情h5
#define kHelpCenterHtml        @"http://192.168.1.211:38003/goods-helpcenter.html?helpId="//帮助中心h5
#define kAboutJiaci        @"http://192.168.1.211:38003/goods-about_us.html"//关于家瓷网

#endif /* UrlConfig_h */
