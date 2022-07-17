pragma solidity 0.8.11;
import './StringUtils.sol';

contract OAT {
    
    // mapping (address=>uint[]) public onwerrarting;
    uint[] array;
     struct Owner
    {
         string name;
         address Addr;
         string  password ;
         string addres;
         string pnumber;
         uint[] rating;
         address[] tenantAddresses;

    }

    mapping (address=>Owner) private  OwnerDetails;
//    mapping(address=>mapping(address=>string)) public OwnerRating;
   
  

   function setOwner(string memory name,string memory password,string memory addr, string memory pnumber, address wAddress) public{/// this method is used to set the owner details

        Owner memory o1 = OwnerDetails[wAddress];
        if (StringUtils.equal(o1.name,""))
        {
            address[] memory add;
            uint[] memory rating;
           OwnerDetails[wAddress]=Owner(name,wAddress,password,addr,pnumber,rating,add);  
        }
        else
        {
            revert("Owner Already Exists") ; 
        }


    }

  

    function getSecureOwnerDetails(address add) public view returns (Owner memory)/////gives out secure details of owner to website(front-end) by excluding password data.
    {
        Owner memory o1  = OwnerDetails[add];
        Owner memory o2;
        o2.name = o1.name;
        o2.pnumber = o1.pnumber;
        o2.tenantAddresses=o1.tenantAddresses;
        o2.rating=o1.rating;
        return o2;
    }

    struct tenant
    {
         address add;
         string name;
         string password;
         string pnumber;
         uint[] rating;
         address [] OwnerAddresses;
      
    }

    mapping (address=>tenant)private TenantDetails;
    //  mapping(address=>mapping(address=>string)) public TenantRating;

     function setTenant(string memory name, string memory phoneNo, address add,string memory password) public/// used to set tenant details.
    {
        tenant memory t1 = TenantDetails[add];
        if (StringUtils.equal(t1.name,""))
        {
            address[] memory addr;
            uint[] memory rating;
        TenantDetails[add]=  tenant(add,name,password,phoneNo,rating,addr);
        
            
        }
        else
        {
            revert("Tenant Already Exists") ;
        }

         
    }

function getSecureTenantDetails(address add) public view returns(tenant memory)/////this method will provide details of a tenant excluding the password for frontend purpose.
    {
        tenant memory t1 = TenantDetails[add];
        tenant memory  t2;
        t2.name = t1.name;
        t2.pnumber = t1.pnumber;
        t2.OwnerAddresses=t1.OwnerAddresses;
        t2.rating=t1.rating;
        return t2;
    }

modifier checkOwner(address oAddr){
     if(!StringUtils.equal(OwnerDetails[oAddr].name,"")){
        _;
    }else{
        revert("Tenant is Not Registered");
    }

}
modifier checkTenant(address tAddr){
    if(!StringUtils.equal(TenantDetails[tAddr].name,"")){
        _;
    }else{
        revert("Tenant is Not Registered");
    }

}

    
    function GiveHouse(address ownerAddr , address tenantAddr, string memory password)public checkOwner(ownerAddr) checkTenant(tenantAddr) returns(string memory){
      require(StringUtils.equal(OwnerDetails[ownerAddr].password, password),"Owner wrong password");
    OwnerDetails[ownerAddr].tenantAddresses.push(tenantAddr);
    TenantDetails[tenantAddr].OwnerAddresses.push(ownerAddr);


}
mapping(address=>mapping(address=>uint)) public rateAOwner;
mapping(address=>mapping(address=>uint))public indexTenantRating;

function rateOwner(address owner, address tenant, uint rating)public {
    uint k=0;
    for(uint i=0;i<OwnerDetails[owner].tenantAddresses.length;i++){
        if(tenant==OwnerDetails[owner].tenantAddresses[i]){
            k=1;
        }
    }
    if(k==1){
        if(rateAOwner[tenant][owner]==0){
        indexTenantRating[owner][tenant]=OwnerDetails[owner].rating.length;
        OwnerDetails[owner].rating.push(rating);
        rateAOwner[tenant][owner]=rating;

    }else{
        OwnerDetails[owner].rating[indexOwnerRating[owner][tenant]]=rating;
        rateAOwner[tenant][owner]=rating;
    }

    }else{
        revert("Invalid tenant!!!");
    }
    
    

}
mapping(address=>mapping(address=>uint))public rateATenant;
mapping(address=>mapping(address=>uint))public indexOwnerRating;

function rateTenant(address tenant, address owner, uint rating) public {
uint k=0;
for(uint i=0;i<TenantDetails[tenant].OwnerAddresses.length;i++){
    if(owner==TenantDetails[tenant].OwnerAddresses[i]){
        k=1;
    }
}
if(k==1){

if(rateATenant[owner][tenant]==0){
        indexOwnerRating[tenant][owner]=TenantDetails[owner].rating.length;
        TenantDetails[tenant].rating.push(rating);
         rateATenant[owner][tenant]=rating;

    }else{
        TenantDetails[tenant].rating[indexOwnerRating[tenant][owner]]=rating;
        rateATenant[owner][tenant]=rating;
    }

}else{
    revert("Invalid Owner!!!");
}
       
}





}

