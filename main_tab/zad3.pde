void showOperation() {
  switch(operationSignalChoice1) {
  case 1:
    tempOperationSignal1 = new float[S1.amp.array().length];
    arrayCopy(S1.amp.array(), tempOperationSignal1);
    break;
  case 2:
    tempOperationSignal1 = new float[S2.amp.array().length];
    arrayCopy(S2.amp.array(), tempOperationSignal1);
    break;
  case 3:
    tempOperationSignal1 = new float[S3.amp.array().length];
    arrayCopy(S3.amp.array(), tempOperationSignal1);
    break;
  case 4:
    tempOperationSignal1 = new float[S4.amp.array().length];
    arrayCopy(S4.amp.array(), tempOperationSignal1);
    break;
  case 5:
    tempOperationSignal1 = new float[S5.amp.array().length];
    arrayCopy(S5.amp.array(), tempOperationSignal1);
    break;
  case 6:
    tempOperationSignal1 = new float[S6.amp.array().length];
    arrayCopy(S6.amp.array(), tempOperationSignal1);
    break;
  case 7:
    tempOperationSignal1 = new float[S7.amp.array().length];
    arrayCopy(S7.amp.array(), tempOperationSignal1);
    break;
  case 8:
    tempOperationSignal1 = new float[S8.amp.array().length];
    arrayCopy(S8.amp.array(), tempOperationSignal1);
    break;
  case 9:
    tempOperationSignal1 = new float[S9.amp.array().length];
    arrayCopy(S9.amp.array(), tempOperationSignal1);
    break;
  }

  switch(operationSignalChoice2) {
  case 1:
    tempOperationSignal1 = new float[S1.amp.array().length];
    arrayCopy(S1.amp.array(), tempOperationSignal2);
    break;
  case 2:
    tempOperationSignal1 = new float[S2.amp.array().length];
    arrayCopy(S2.amp.array(), tempOperationSignal2);
    break;
  case 3:
    tempOperationSignal2 = new float[S3.amp.array().length];
    arrayCopy(S3.amp.array(), tempOperationSignal2);
    break;
  case 4:
    tempOperationSignal2 = new float[S4.amp.array().length];
    arrayCopy(S4.amp.array(), tempOperationSignal2);
    break;
  case 5:
    tempOperationSignal2 = new float[S5.amp.array().length];
    arrayCopy(S5.amp.array(), tempOperationSignal2);
    break;
  case 6:
    tempOperationSignal2 = new float[S6.amp.array().length];
    arrayCopy(S6.amp.array(), tempOperationSignal2);
    break;
  case 7:
    tempOperationSignal2 = new float[S7.amp.array().length];
    arrayCopy(S7.amp.array(), tempOperationSignal2);
    break;
  case 8:
    tempOperationSignal2 = new float[S8.amp.array().length];
    arrayCopy(S8.amp.array(), tempOperationSignal2);
    break;
  case 9:
    tempOperationSignal2 = new float[S9.amp.array().length];
    arrayCopy(S9.amp.array(), tempOperationSignal2);
    break;
  }
  if (isConvolutionVisible) convolution(tempOperationSignal1, tempOperationSignal2);
  else if (isCorelationVisible) corelation(tempOperationSignal1, tempOperationSignal2);
  chart(operationSignalTime, operationSignalAmp);
}

void convolution(float[] sygnalA, float[] sygnalC) {
  float[] sygnalB = new float[convSignal2SampleNumber];
  arrayCopy(sygnalC, sygnalB, convSignal2SampleNumber);


  int dlugoscA = sygnalA.length;
  int dlugoscB = sygnalB.length;
  int dlugoscWyniku = dlugoscA + dlugoscB - 1; // Długość wynikowej tablicy splotu

  operationSignalAmp = new float[dlugoscWyniku]; // Tablica wynikowa

  // Wykonaj splot
  for (int i = 0; i < dlugoscWyniku; i++) {
    operationSignalAmp[i] = 0; // Zeruj wartość dla każdej próbki wynikowej

    for (int j = 0; j < dlugoscA; j++) {
      if (i - j >= 0 && i - j < dlugoscB) {
        // Pomnóż odpowiadające próbki sygnałów A i B oraz dodaj do wyniku
        operationSignalAmp[i] += sygnalA[j] * sygnalB[i - j];
      }
    }
  }

  operationSignalTime = new float[dlugoscWyniku];
  for (int i = 0; i<dlugoscWyniku; i++) {
    operationSignalTime[i] = map(i, 0, dlugoscWyniku, 0, SIGNAL_END);
  }
}

void corelation(float[] SignalA, float[] SignalB) {
}