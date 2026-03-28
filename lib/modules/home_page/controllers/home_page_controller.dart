import 'package:get/get.dart';
import 'package:jotun/core/net/response/base_response.dart';
import 'package:jotun/modules/favorites/services/favorites_service.dart';
import 'package:jotun/modules/home_page/model/response/campaign.dart';
import '../../distribution_centres/model/response/distribution_centres.dart';
import '../../distribution_centres/services/distribution_centres_service.dart';
import '../model/response/products.dart';
import '../services/home_page_service.dart';
import '../presentation/home_page_state.dart';

class HomePageController extends GetxController {
  final _service = HomePageService();
  Rx<HomePageState> pageState = HomePageState.loading.obs;
  static late Campaign campaign;
  var hasCampaign=false.obs;
  late BaseResponse baseResponse;
  late Products products;
  late Distributors distributors;
  var noDistributors=false.obs;
  List<Product> newProducts=[],mostProducts=[];


  @override
  void onReady() async{
    super.onReady();
    pageState.value=HomePageState.loading;
    await getCurrentCampaign();
    await getProducts();
    await getDistributors();
    pageState.value=HomePageState.initial;
  }

  getCurrentCampaign() async{
    baseResponse=await _service.getCurrentCampaign();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        print(baseResponse.data);
        campaign=Campaign.fromJson(baseResponse.data);
        print(campaign);
        if(campaign!=null) {
          if(campaign.description!=null||campaign.description!.isNotEmpty){
            hasCampaign(true);
          }
        }else{
          hasCampaign(false);
        }

      }
    }
  }
  getProducts() async{
    baseResponse=await _service.getProducts();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        print(baseResponse.data);
        products=Products.fromJson(baseResponse.data);
        fetchProducts();
      }
    }
  }

  fetchProducts(){
    newProducts.clear();
    mostProducts.clear();
    for(Product product in products.product!){
      if(product.isNew==1){
        newProducts.add(product);
      }if(product.isSuper==1){
        mostProducts.add(product);
      }
    }
    update();
  }


  Future<bool> updateFavorite(id,isFavourite) async{
    isFavourite.value=!isFavourite.value;
    FavoritesService service=FavoritesService();
    baseResponse=await service.updateFavorite(id);
    if(baseResponse!=null){
      if(baseResponse.status==200){
        if(baseResponse.success==true){

          getProducts();
          return true;
        }
      }else{
        isFavourite.value=!isFavourite.value;
      }
    }
    return false;
  }

  getDistributors() async{

    BaseResponse distributorsBaseResponse=await DistributionCentresService().getDistributors();
    if(distributorsBaseResponse!=null){
      if(distributorsBaseResponse.status==200){
        distributors=Distributors.fromJson(distributorsBaseResponse.data);
        if(distributors==null||distributors.distributors!.isEmpty||distributors.distributors==null){
          noDistributors(true);
        }
      }
    }
  }
}
