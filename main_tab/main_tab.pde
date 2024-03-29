import complexnumbers.*;
import controlP5.*;
import org.gicentre.utils.stat.*;

void setup() { /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////SETUP
  surface.setLocation(width/5, height/4);
  lineChart = new XYChart(this);
  lineChart2 = new XYChart(this);
  lineChart4up = new XYChart(this);
  lineChart4down = new XYChart(this);
  scatterplot = new XYChart(this);
  reconstructedChart = new XYChart(this);
  barChart = new BarChart(this);

  cp5 = new ControlP5(this);
  cp6 = new ControlP5(this);
  StaticDraw();
  S1.calculate();
  S2.calculate();
  S3.calculate();
  S4.calculate();
  S5.calculate();
  S6.calculate();
  S7.calculate();
  S8.calculate();
  S9.calculate();
  I1.calculate();
  I2.calculate();
  rectMode(CORNERS);
  textAlign(CENTER, CENTER);
  size(1280, 720);
  background(255);
  textSize(16);
}

void draw() { /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////DRAW
  surface.setTitle(nf(frameRate, 0, 1) + " FPS, f: " + 1/USER_PERIOD + ", czas wykonywania transformacji: " + transformationTime + "ms");
  background(255);
  fill(0);
  switch(wyborWykresu) {
  case 1:
    if (isComplexChartVisible) {
      chart(S1.time, S1.amp.array());
      //chart4(S1.time, S1.amp.array());
    } else {
      chart(S1.time, S1.amp.array());
      //chart4(S1.time, S1.amp.array());
    }
    signalType = "Szum o rozkładzie jednostajnym";
    signalName = "szumJednostajny";
    calculateData(S1);
    showSelectedReconstruction(S1);
    break;
  case 2:
    if (isComplexChartVisible) {
      chart(S2.time, S2.amp.array());
      //chart4(S2.time, S2.amp.array());
    } else {
      chart(S2.time, S2.amp.array());
      //chart4(S2.time, S2.amp.array());
    }
    signalType = "Szum gaussowski";
    calculateData(S2);
    showSelectedReconstruction(S2);
    break;
  case 3:
    if (isComplexChartVisible) {
      chart(S3.time, S3.amp.array());
      //chart4(S3.time, S3.amp.array());
    } else {
      chart(S3.time, S3.amp.array());
      //chart4(S3.time, S3.amp.array());
    }
    signalType = "Sygnał sinusoidalny";
    signalName = "sygnalSin";
    calculateData(S3);
    showSelectedReconstruction(S3);
    break;
  case 4:
    if (isComplexChartVisible) {
      chart(S4.time, S4.amp.array());
      //chart4(S4.time, S4.amp.array());
    } else {
      chart(S4.time, S4.amp.array());
      //chart4(S4.time, S4.amp.array());
    }
    signalType = "Sygnał sinusoidalny wyprostowany jednopołówkowo";
    signalName = "sygnalSinWyprJedn";
    calculateData(S4);
    showSelectedReconstruction(S4);
    break;
  case 5:
    if (isComplexChartVisible) {
      chart(S5.time, S5.amp.array());
      //chart4(S5.time, S5.amp.array());
    } else {
      chart(S5.time, S5.amp.array());
      //chart4(S5.time, S5.amp.array());
    }
    signalType = "Sygnał sinusoidalny wyprostowany dwupołówkowo";
    signalName = "sygnalSinWyprDwu";
    calculateData(S5);
    showSelectedReconstruction(S5);
    break;
  case 6:
    if (isComplexChartVisible) {
      chart(S6.time, S6.amp.array());
      //chart4(S6.time, S6.amp.array());
    } else {
      chart(S6.time, S6.amp.array());
      //chart4(S6.time, S6.amp.array());
    }
    signalType = "Sygnał prostokątny";
    signalName = "sygnalProstokatny";
    calculateData(S6);
    showSelectedReconstruction(S6);
    break;
  case 7:
    if (isComplexChartVisible) {
      chart(S7.time, S7.amp.array());
      //chart4(S7.time, S7.amp.array());
    } else {
      chart(S7.time, S7.amp.array());
      //chart4(S7.time, S7.amp.array());
    }
    signalType = "Sygnał prostokątny symetryczny";
    signalName = "sygnalProstokatnySym";
    calculateData(S7);
    showSelectedReconstruction(S7);
    break;
  case 8:
    if (isComplexChartVisible) {
      chart(S8.time, S8.amp.array());
      //chart4(S8.time, S8.amp.array());
    } else {
      chart(S8.time, S8.amp.array());
      //chart4(S8.time, S8.amp.array());
    }
    signalType = "Sygnał trójkątny";
    signalName = "sygnalTrojkatny";
    calculateData(S8);
    showSelectedReconstruction(S8);
    break;
  case 9:
    if (isComplexChartVisible) {
      chart(S9.time, S9.amp.array());
      //chart4(S9.time, S9.amp.array());
    } else {
      chart(S9.time, S9.amp.array());
      //chart4(S9.time, S9.amp.array());
    }
    signalType = "Skok jednostkowy";
    signalName = "sygnalJednostkowy";
    calculateData(S9);
    showSelectedReconstruction(S9);
    break;
  case 10:
    scatter(I1.time, I1.amp.array());
    impulsType = "Impuls jednostkowy";
    signalName = "impulsJednostkowy";
    break;
  case 11:
    scatter(I2.time, I2.amp.array());
    impulsType = "Szum impulsowy";
    signalName = "szumImpulsowy";
    break;
  case 0:
    try {
      impulsType = "Sygnal poddany operacji";
      signalName = "Sygnal poddany operacja";
      chart(S0.time, S0.amp.array());
      calculateData(S0);
    }
    catch (Exception e) {
      print("Wykres nie dziala");
    }
    impulsType = "Wynik operacji";
    signalName = "wynikOperacji";
    break;
  default:
    chart(S1.time, S1.amp.array());
    signalType = "Szum o rozkładzie jednostajnym";
    signalName = "szumJednostajny";
    break;
  }

  fill(0);

  if (numerZadania == 3) {
    try {
      showOperation();
    }
    catch (Exception e) {
      println("upsi pupsi " + millis());
    }
  }

  if (numerZadania == 4) {
    try {
      switch(wyborWykresu) {
      case 1:
        showBothCharts(S1);
        break;
      case 2:
        showBothCharts(S2);
        break;
      case 3:
        showBothCharts(S3);
        break;
      case 4:
        showBothCharts(S4);
        break;
      case 5:
        showBothCharts(S5);
        break;
      case 6:
        showBothCharts(S6);
        break;
      case 7:
        showBothCharts(S7);
        break;
      case 8:
        showBothCharts(S8);
        break;
      case 9:
        showBothCharts(S9);
        break;
      }
    }
    catch (Exception e) {
      println("upsi pupsi 4 " + millis());
      e.printStackTrace(System.out);
    }
  }


  setReconstructionType();
  reconstructedChart.setMaxY(lineChart.getMaxY());
  reconstructedChart.setMinY(lineChart.getMinY());
  reconstructedChart.setMaxX(lineChart.getMaxX());
  reconstructedChart.setMinX(lineChart.getMinX());
  barChart.setMaxValue(lineChart.getMaxY());
  barChart.setMinValue(lineChart.getMinY());
  if (wyborWykresu < 10) { // UI
    isItSignalOrImpulse = true;
    textAlign(CENTER, CENTER);
    textSize(20);
    text("Obecny sygnał (" + wyborWykresu + "): " + signalType, width/2, height*0.85);
    if (numerZadania == 2)text("Obecna rekonstrukcja (" + reconstructionChoice + "): " + reconstructionType, width/2, height*0.08);
    if (numerZadania == 3) {
      if (whichIsVisible == 2 && isOptionalFilterVisible == true) lineChart2.draw(0, height*0.1, width*0.85, height*0.65);
      if (whichIsVisible == 1)text("Splot " + convultionSignalType(operationSignalChoice1) + " i " + convultionSignalType(operationSignalChoice2), width/2, height*0.08);
      if (whichIsVisible == 3)text("Korelacja " + convultionSignalType(operationSignalChoice1) + " i " + convultionSignalType(operationSignalChoice2), width/2, height*0.08);
    }
    textSize(16);
    if (numerZadania != 4) lineChart.draw(0, height*0.1, width*0.85, height*0.65);
    if (numerZadania == 4 && isComplexChartVisible == true) {
      lineChart4up.draw(width*0.014, 0, width*0.83, height*0.4);
      lineChart4down.draw(width*0.014, height*0.4, width*0.83, height*0.4);
    }
    if (numerZadania == 2) {
      if (isReconstructionChartVisible && wyborWykresu >2) {
        if (showLineChart == true) reconstructedChart.draw(0, height*0.1, width*0.85, height*0.65);
        if (showBarChart == true) barChart.draw(0, height*0.1, width*0.85, height*0.65);
      }
    }
  } else {
    isItSignalOrImpulse = false;
    textSize(20);
    text("Obecny impuls (" + wyborWykresu + "): " + impulsType, width/2, height*0.05);
    if (numerZadania == 2)text("Obecna rekonstrukcja (" + reconstructionChoice + "): " + reconstructionType, width/2, height*0.08);
    textSize(16);
    scatterplot.draw(0, 0, width*0.85, height*0.65);
    //if (isReconstructionChartVisible && wyborWykresu >2) reconstructedChart.draw(0, height*0.1, width*0.85, height*0.65);
  }
  textSize(16);
  textAlign(LEFT);
  text("Alternatywny wybór grafu (od '1' do '-')", 20, 600);
  textAlign(LEFT);
  textSize(12);
  //text("Możliwość wyboru dezaktywuje się po najechaniu kursorem na okienka operacji: ", 20, 630);
  text(">", 230, 631);
  textSize(16);
  fill(0);
  if (numerZadania == 1)text("wykres 1", width*0.42, height*0.83);
  if (numerZadania == 1)text("operacja", width*0.48, height*0.83);
  if (numerZadania == 1)text("wykres 2", width*0.54, height*0.83);
  textAlign(CENTER);
  textSize(12);
  if (numerZadania == 1) text("(Wciśnij ENTER po wpisaniu każdej z wartości)", width*0.50, height*0.80);
  textSize(20);
  ActiveDraw();

  USER_AMPLITUDE = int(cp5.getController("amplitude").getValue()); //aktualizowanie co klatke amplitudy wybranej przez uzytkownika i odswiezenie jej w sygnalach
  USER_PERIOD = (cp5.getController("period").getValue());
  FILL_FACTOR = (cp5.getController("fill factor").getValue());
  QUANTIZATION_JUMP_SIZE = (cp5.getController("vertical jump size").getValue());
  SAMPLE_RATE = int(cp5.getController("sample rate").getValue());
  RECONSTRUCTED_SAMPLE_NUMBER = int((cp5.getController("reconstrucion sample number").getValue()));
  cp5.getController("reconstrucion sample number").setValue(RECONSTRUCTED_SAMPLE_NUMBER);
  convSignal2SampleNumber = int((cp5.getController("convolution sample number").getValue())) - int((cp5.getController("convolution sample number").getValue()))%10;
  delayCorelationNumber = int((cp5.getController("delay corelation number").getValue())) - int((cp5.getController("delay corelation number").getValue()))%10;
  corelationChoice = int((cp5.getController("corelation type").getValue()));
  if (corelationChoice == 1) {
    if (delayCorelationNumber > convSignal2SampleNumber) delayCorelationNumber = convSignal2SampleNumber;
  } else delayCorelationNumber = convSignal2SampleNumber;
  parametrM = int((cp5.getController("parametr m").getValue()));
  parametrK = int((cp5.getController("parametr k").getValue()));
  cp5.getController("convolution sample number").setValue(convSignal2SampleNumber);
  cp5.getController("delay corelation number").setValue(delayCorelationNumber);
  cp5.getController("parametr m").setValue(parametrM);
  cp5.getController("parametr k").setValue(parametrK);

  S1.setAmplitude(USER_AMPLITUDE);
  S2.setAmplitude(USER_AMPLITUDE);
  S3.setAmplitude(USER_AMPLITUDE);
  S4.setAmplitude(USER_AMPLITUDE);
  S5.setAmplitude(USER_AMPLITUDE);
  S6.setAmplitude(USER_AMPLITUDE);
  S7.setAmplitude(USER_AMPLITUDE);
  S8.setAmplitude(USER_AMPLITUDE);
  S9.setAmplitude(USER_AMPLITUDE);
  S3.setPeriod(USER_PERIOD);
  S4.setPeriod(USER_PERIOD);
  S5.setPeriod(USER_PERIOD);
  S6.setPeriod(USER_PERIOD);
  S7.setPeriod(USER_PERIOD);
  S8.setPeriod(USER_PERIOD);
  S9.setPeriod(USER_PERIOD);
  I1.setAmplitude(USER_AMPLITUDE);
  I2.setAmplitude(USER_AMPLITUDE);
  S6.setFillFactor(FILL_FACTOR);
  S7.setFillFactor(FILL_FACTOR);
  S8.setFillFactor(FILL_FACTOR);
  I2.setProbability(FILL_FACTOR);
  if (cp5.getController("amplitude").isMousePressed()) { //przeliczenie wartosci nowego sygnalu z nowa amplituda, dzieki temu slider nadaza za sygnalem i na odwrot, przelaczajac sygnal wartosc amplitudy sie zgadza a nie jest poprzednia zapisana
    S1.calculate();
    S2.calculate();
    S3.calculate();
    S4.calculate();
    S5.calculate();
    S6.calculate();
    S7.calculate();
    S8.calculate();
    S9.calculate();
    I1.calculate();
    I2.calculate();
  }
  if (cp5.getController("period").isMousePressed()) {
    S3.calculate();
    S4.calculate();
    S5.calculate();
    S6.calculate();
    S7.calculate();
    S8.calculate();
    S9.calculate();
  }
  if (cp5.getController("fill factor").isMousePressed()) {
    S6.calculate();
    S7.calculate();
    S8.calculate();
    I2.calculate();
  }
}
