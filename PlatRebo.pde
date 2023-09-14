//FLAN
class PlatRebo
{
  FBox platRebo;
  
  PlatRebo(float _w, float _h)
  {
    platRebo = new FBox(_w, _h);
  }
  
  void inicializar(float _x, float _y)
  {
    platRebo.setPosition(_x, _y);
    platRebo.setStatic(true);
    platRebo.setRestitution(2);
    platRebo.attachImage(platRebot);
    
  }
}
