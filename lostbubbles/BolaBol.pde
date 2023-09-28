/*class BolaBol
{
  FCircle bolaBol;
  Boolean vivo;


  BolaBol(float _r)
  {
    bolaBol = new FCircle(_r);
  }

  void inicializar(float _x, float _y)
  {

    bolaBol.setPosition(_x, _y);
    //bolaBol.setDensity(20);
    //bolaBol.attachImage(bbolgrand);
    vivo = true;

    
  }
  //BOLAS
class Bolas extends FBox
{
    Boolean vivo;

  
  Bolas(float _w, float _h){
   
    super(_w, _h);
  }
  
  void inicializar(float _x, float _y){

    setPosition(_x, _y);
    setName ("Bolas");
    setStatic(true);
    vivo = true;

  }

  
  
    void matar()
  {
    vivo = false;
  }

}*/

class Bolas extends FBox
{

  Boolean vivo;
  
  Bolas(float _w, float _h)
  {
    super(_w, _h);
  }
  
  void inicializar(float _x, float _y)
  {
      vivo = true;
      
    setName("Bolas");
    setPosition(_x, _y);

  }
  
  void matar()
  {
    vivo = false;
  }

}
