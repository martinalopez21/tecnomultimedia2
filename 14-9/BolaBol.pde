class BolaBol
{
  FCircle bolaBol;

  BolaBol(float _r)
  {
    bolaBol = new FCircle(_r);
  }

  void inicializar(float _x, float _y)
  {

    bolaBol.setPosition(_x, _y);
    //bolaBol.setDensity(20);
    //bolaBol.attachImage(bbolgrand);
    
  }
}
