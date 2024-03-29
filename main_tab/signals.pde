class Signal { //szum
  float signalS; // start of signal
  float signalE; // end of signal
  FloatList amp; // tablica przechowujaca X
  float[] time = new float[SAMPLE_NUMBER]; // tablica przechowujaca Y
  float ampl; // amplitude
  public Signal(float signalStart, float signalEnd, float amplitude) { //konstruktor
    signalS = signalStart;
    signalE = signalEnd;
    amp = new FloatList(SAMPLE_NUMBER);
    ampl = amplitude;
    for (int i = 0; i < SAMPLE_NUMBER; i++)
      amp.set(i, 0);
  }
  public Signal(float[] zT) {
    signalS = zT[0];
    signalE = zT[1];
    amp = new FloatList(SAMPLE_NUMBER);
    ampl = zT[2];
    for (int i = 0; i < SAMPLE_NUMBER; i++)
      amp.set(i, 0);
  }
  public Signal(float signalStart, float signalEnd, float[] X, float[] Y, float amplitude) {
    amp = new FloatList(SAMPLE_NUMBER);
    for (int i = 0; i < Y.length; i++) {
      amp.set(i, Y[i]);
      time[i] = X[i];
    }
    signalS = signalStart;
    signalE = signalEnd;
    ampl = amplitude;
  }
  public void calculate() {
  }
  public void setAmplitude(float a) {
    ampl = a;
  }
  public float getAmplitude() {
    return ampl;
  }
}

class ContinuosSignal extends Signal {
  public ContinuosSignal(float signalStart, float signalEnd, float amplitude) {
    super(signalStart, signalEnd, amplitude);
  }
  public ContinuosSignal(float[] zT) {
    super(zT);
  }
  public void calculate() {
    //int j = 0;
    //for (float i = signalS; i <= signalE; i += (signalE - signalS) / SAMPLE_NUMBER) {
    //  amp.set(j, random(-ampl, ampl));
    //  time[j] = i;
    //  j++;
    //}
    int j=0;
    float i=signalS;
    while (j<SAMPLE_NUMBER) {
      amp.set(j, random(-ampl, ampl));
      time[j] = i;
      j++;
      i+=(signalE-signalS)/SAMPLE_NUMBER;
    }
  }
}

class Gauss extends Signal { //szum gaussa
  float avg;
  float dev;
  public Gauss(float signalStart, float signalEnd, float amplitude, float average0, float devation1) {
    super(signalStart, signalEnd, amplitude);
    avg = average0;
    dev = devation1;
  }
  public Gauss(float zT[], float average0, float devation1) {
    super(zT);
    avg = average0;
    dev = devation1;
  }
  public void calculate() {
    int j = 0;
    for (float i = signalS; i <= signalE; i += (signalE - signalS) / SAMPLE_NUMBER) {
      if (j<SAMPLE_NUMBER) {
        float first = 1/(dev*sqrt(TWO_PI));
        float third = (-1 * pow((i - avg), 2)) / (2*pow(dev, 2));
        float second = pow(exp(1.0), third);
        amp.set(j, (first * second) + random(-ampl, ampl));
        time[j] = i;
        j++;
      }
    }
  }
}

class Sinusoidal extends Signal {
  float term;
  float per;
  public Sinusoidal(float signalStart, float signalEnd, float amplitude, float period) {
    super(signalStart, signalEnd, amplitude);
    term = signalE-signalS;
    per = period;
  }
  public Sinusoidal(float[] zT, float period) {
    super(zT);
    term = signalE-signalS;
    per = period;
  }
  public void calculate() {
    int j = 0;
    for (float i = signalS; i <= signalE; i += (signalE - signalS) / SAMPLE_NUMBER) {
      if(j<SAMPLE_NUMBER) {
      //okres podstawowy (T) –dla sygnału okresowego jest to minimalna wartość, dla której spełniona jest zależność: x(t)=x(t+kT)
      time[j] = i;
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      amp.set(j, ampl * sin((TWO_PI / (per)) * ((per + i) - signalS))); //<--- oryginalny
      //amp.set(j, 0.01*sin(PI*i)*cos(PI*i*i));
      //amp.set(j, 5*sin(TWO_PI*i/2)+sin(TWO_PI*i*0.25));
      //amp.set(j, 2*sin(i*per)+sin(10*i*per));
      //println(per);
      //amp.set(j, cos(i*i)-3*sin(PI*i/2));
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      j++;
      }
    }
  }
  public void setPeriod(float period) {
    per = period;
  }
  public float getPeriod() {
    return per;
  }
}

class RectifiedOneSinusoidal extends Sinusoidal {
  public RectifiedOneSinusoidal(float signalStart, float signalEnd, float amplitude, float period) {
    super(signalStart, signalEnd, amplitude, period);
  }
  public RectifiedOneSinusoidal(float[] zT, float period) {
    super(zT, period);
  }
  public void calculate() {
    int j = 0;
    //for (float i = signalS; i <= signalE; i += (signalE - signalS) / SAMPLE_NUMBER) {
    //  if(j<SAMPLE_NUMBER) {
    //  time[j] = i;
    //  amp.set(j, 0.5 * ampl * sin((TWO_PI / (per)) * ((per + i) - signalS)));// + abs(sin(TWO_PI / (term)) * (period - signalS)));
    //  if (amp.get(j) < 0) {
    //    amp.set(j, 0.0);
    //  }
    //  j++;
    //  }
    //}
    float i= signalS;
    while (j<SAMPLE_NUMBER) {
      if(i == 0) amp.set(j, 1);
      else amp.set(j, sin(i)*sin(i*i));
      time[j] = i;
      j++;
      i+=(signalE-signalS)/SAMPLE_NUMBER;
    }
  }
}

class RectifiedTwoSinusoidal extends Sinusoidal {
  public RectifiedTwoSinusoidal(float signalStart, float signalEnd, float amplitude, float period) {
    super(signalStart, signalEnd, amplitude, period);
  }
  public RectifiedTwoSinusoidal(float[] zT, float period) {
    super(zT, period);
  }
  public void calculate() {
    int j = 0;
    for (float i = signalS; i <= signalE; i += (signalE - signalS) / SAMPLE_NUMBER) {
      if(j<SAMPLE_NUMBER) {
      time[j] = i;
      amp.set(j, ampl * abs(sin((TWO_PI / (per)) * ((per + i) -signalS))));
      j++;
      }
    }
  }
}

class Rectangular extends Sinusoidal {
  float fillFactor; // wspolczynnik wypelnienia - stosunek czasu trwania wartości maksymalnej do okresu

  public Rectangular(float signalStart, float signalEnd, float amplitude, float period, float fF) {
    super(signalStart, signalEnd, amplitude, period);
    fillFactor = fF;
  }
  public Rectangular(float[] zT, float period, float fF) {
    super(zT, period);
    fillFactor = fF;
  }
  public void setFillFactor(float f) {
    fillFactor = f;
  }
  public void calculate() {
    int j=0;
    for (float i = signalS; i <= signalE; i += (signalE - signalS) / SAMPLE_NUMBER, j++) {
      if(j<SAMPLE_NUMBER) {
      time[j] = i;

      //if (i>okres*wsp_wyp && i<okres) {
      if (i % (per) >= per * fillFactor) {
        amp.set(j, 0.0);
      } else {
        amp.set(j, ampl);
      }
      }
    }
  }
}

class SymmetricalRectangular extends Sinusoidal {
  float fillFactor; // wspolczynnik wypelnienia - stosunek czasu trwania wartości maksymalnej do okresu
  float period; //okres podstawowy - czas trwania w sekundach

  public SymmetricalRectangular(float signalStart, float signalEnd, float amplitude, float period, float fF) {
    super(signalStart, signalEnd, amplitude, period);
    fillFactor = fF;
  }
  public SymmetricalRectangular(float[] zT, float period, float fF) {
    super(zT, period);
    fillFactor = fF;
  }
  public void setFillFactor(float f) {
    fillFactor = f;
  }
  public void calculate() {
    int j=0;
    for (float i = signalS; i <= signalE; i += (signalE - signalS) / SAMPLE_NUMBER, j++) {
      if(j<SAMPLE_NUMBER) {
      time[j] = i;
      if (i % (per) >= per * fillFactor) {
        amp.set(j, -ampl);
      } else {
        amp.set(j, ampl);
      }
      }
    }
  }
}

class Triangular extends Sinusoidal {
  float fillFactor; // wspolczynnik wypelnienia - stosunek czasu trwania wartości maksymalnej do okresu
  public Triangular(float signalStart, float signalEnd, float amplitude, float period, float fF) {
    super(signalStart, signalEnd, amplitude, period);
    fillFactor = fF;
  }
  public Triangular(float[] zT, float period, float fF) {
    super(zT, period);
    fillFactor = fF;
  }
  //public void calculate() {
  //  int j = 0;
  //  float step = signalE - signalS / (ampl - 1);
  //  //boolean yes = true;
  //  for (float i = signalS; i <= signalE; i += (signalE - signalS) / SAMPLE_NUMBER) {
  //    float period = i * step + signalS;
  //    float tac = ((period - signalS) / term) - floor((period - signalS) / term);
  //    time[j] = i;
  //    if (i % (per) >= per * fillFactor) {
  //      amp.set(j, (-tac / fillFactor * ampl));
  //    } else {
  //      amp.set(j, (tac / fillFactor * ampl) - (signalE - signalS) * 2 );
  //    }
  //    j++;
  //  }
  public void setFillFactor(float f) {
    fillFactor = f;
  }
  public void calculate() {
    int j=0;
    for (float i = signalS; i <= signalE; i += (signalE - signalS) / SAMPLE_NUMBER, j++) {
      if(j<SAMPLE_NUMBER) {
      time[j] = i;
      if (i % (per) >= per * fillFactor) {
        amp.set(j, map(i%per, per * fillFactor, per, ampl, 0));
      } else {
        amp.set(j, map(i%per, 0, per * fillFactor, 0, ampl));
      }
      }
    }
  }
}

class UnitStroke extends Sinusoidal {
  public UnitStroke(float signalStart, float signalEnd, float amplitude, float period) {
    super(signalStart, signalEnd, amplitude, period);
  }
  public UnitStroke(float[] zT, float period) {
    super(zT, period);
  }
  public void calculate() {
    int j = 0;
    for (float i = signalS; i <= signalE; i += (signalE - signalS) / SAMPLE_NUMBER) {
      if(j<SAMPLE_NUMBER) {
      time[j] = i;
      if (per < i) { // od signalS do momentu kiedy period = signalS
        amp.set(j, ampl);
      } else if ((per == i)) { // period = signalS+signalE / 2
        amp.set(j, ampl * 0.5);
      } else {
        amp.set(j, 0.0);
      }
      j++;
      }
    }
  }
}



class Discreet {
  float freq;
  FloatList amp;
  float[] time = new float[SAMPLE_NUMBER];
  float ampl;
  public Discreet(float f, float amplitude) {
    freq = f;
    amp = new FloatList(SAMPLE_NUMBER);
    ampl = amplitude;
    for (int i = 0; i < SAMPLE_NUMBER; i++)
      amp.set(i, 0);
  }
  public void setAmplitude(float a) {
    ampl = a;
  }
  public void calculate() {
  }
}

class UnitImpulse extends Discreet {
  float firstSample;
  float jumpSample;
  public UnitImpulse(float f, float amplitude, float fS, float jS) {
    super(f, amplitude);
    firstSample = fS;
    jumpSample = jS;
  }
  public void calculate() {
    int j = 0;
    for (float i = -firstSample; i < firstSample; i++) {
      time[j] = i;
      if (i == jumpSample) {
        amp.set(j, ampl);
      } else {
        amp.set(j, 0.0);
      }
      j++;
    }
  }
}

class NoiseImpulse extends Discreet {
  float probability;
  float noiseTime;
  public NoiseImpulse(float f, float amplitude, float p, float nT) {
    super(f, amplitude);
    probability = 100*p;
    noiseTime = nT;
  }
  public void setProbability(float p) {
    probability = 100*p;
  }
  public void calculate() {
    int j = 0;
    for (float i = 0; i < noiseTime; i++) {
      time[j] = i;
      if ( random(100) < probability) { // probability to szansa na wystapienie na wykresie 1.0, trzeba obliczyc wartosc procentowa a potem skonstruowac if ktory dobrze zbalansuje 1.0 i 0.0
        amp.set(j, 1.0);
      } else {
        amp.set(j, 0.0);
      }
      j++;
    }
  }
}
