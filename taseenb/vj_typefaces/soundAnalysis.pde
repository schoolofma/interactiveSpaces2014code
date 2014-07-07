class SoundAnalysis
{
  // Object minim qui représente l'interface
  // avec la carte audio
  Minim minim;

  // Object qui capte l'entrée miro
  AudioInput entreeMicro;

  // Niveau micro
  float niveauMicro;

  // Analyse spectracle
  FFT fft;
  boolean useAvg = false;

  SoundAnalysis(PApplet p)
  {
    setup(p);
  }

  SoundAnalysis(PApplet p, int nbBands)
  {
    setup(p);
    fft.linAverages(nbBands);
    useAvg = true;
  }

  void setup(PApplet p)
  {
    // Initialise la libraire Minim
    minim = new Minim(p);
    entreeMicro = minim.getLineIn(Minim.STEREO, 512);

    fft = new FFT(entreeMicro.bufferSize(), entreeMicro.sampleRate());
  }

  void update()
  {
    niveauMicro = entreeMicro.mix.level();
    fft.forward(entreeMicro.mix.toArray());
  }

  float getMicroLevel()
  {
    return niveauMicro;
  }
  
  float getFFTLevel(int i)
  {
    if (i < getFFTSize())
    {
      return fft.getBand(i);
    }
    else
    {
      println("L'index de bande FFT ["+i+"] n'est pas valide");
      return 0.0f;
    }
  }

  void drawFFT(float s)
  {
    rectMode(CORNER);
    float bandWidth = float(width)/float(getFFTSize());
    float x=0;
    for (int i = 0; i < getFFTSize(); i++)
    {
      // draw the line for frequency band i, scaling it by 4 so we can see it a bit better
      if (useAvg)
      {
        noStroke();
        fill(0);
        rect(x,height,bandWidth,height-fft.getBand(i)*s);
        x+=bandWidth;
      }
      else
      {
        x = i;
        stroke(0);
        line(x, height, x, height - fft.getBand(i)*s);
      }
    }
  }

  int getFFTSize()
  {
    return (useAvg ? fft.avgSize() : fft.specSize());
  }
}

