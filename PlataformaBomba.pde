//BOMBA
class PlataformaBomba extends FBox
{

  
  PlataformaBomba(float _w, float _h){
   
    super(_w, _h);
  }
  
  void inicializar(float _x, float _y){

    setPosition(_x, _y);
    setName ("plataforma");
    setStatic(true);
  }
}
