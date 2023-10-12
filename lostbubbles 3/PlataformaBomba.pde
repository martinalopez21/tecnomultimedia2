//BOMBA
class PlataformaBomba extends FBox
{
   Boolean vivo;

  
  PlataformaBomba(float _w, float _h){
   
    super(_w, _h);
  }
  
  void inicializar(float _x, float _y){

    vivo = true;

    setPosition(_x, _y);
    setName ("plataformaBomba");
    setStatic(true);
  }
  
  void matar()
  {
    vivo = false;
  }
}
