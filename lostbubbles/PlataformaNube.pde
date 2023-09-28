/*//NUBE
class PlataformaNube
{
  FBox platnube;
  
  PlataformaNube(float _w, float _h)
  {
    platnube = new FBox(_w, _h);
  }
  
  void inicializar(float _x, float _y)
  {
    platnube.setPosition(_x, _y);
    platnube.setStatic(true);
    platnube.setRestitution(2);   
    platnube.attachImage (platNube);
  }
  
}*/
//NUBE
class PlataformaNube extends FBox
{
   Boolean vivo;
  
  PlataformaNube(float _w, float _h){
   
    super(_w, _h);
  }
  
  void inicializar(float _x, float _y){
    
    vivo = true;

    setPosition(_x, _y);
    setName ("plataformaNube");
    setStatic(true);
  }
  
    void matar()
  {
    vivo = false;
  }
}
