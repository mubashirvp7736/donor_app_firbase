class DonorModel{

String? name;
int? phone;
String? group;
String?image;
String? id;

DonorModel({
  this.id,
  required this.name,
  required this.phone,
  required this.group,
   this.image
});

factory DonorModel.fromJson(Map<String,dynamic>json,id){
  return DonorModel(
    id: id,
    name: json["name"], 
    phone: json["phone"], 
    group: json["group"],
    image: json["image"]
    );
}
 Map<String,dynamic>toJson(){

  return{
    'id':id,
    "name":name,
    "phone":phone,
    "group":group,
    "image":image
  };
 }

}