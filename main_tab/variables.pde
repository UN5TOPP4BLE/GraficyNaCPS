//wybor zadania
int numerZadania = 4; //1-4

//kolor przycisku
int buttonColor = 200;

//flagi wykresow
boolean activeWriting = false;
Boolean showBarChart = false;
Boolean showLineChart = false;

//Zmienne bibliotek rysujacych
XYChart lineChart;
XYChart lineChart2;
XYChart lineChart4up;
XYChart lineChart4down;
XYChart scatterplot;
BarChart barChart;
XYChart reconstructedChart;
ControlP5 cp5, cp6;

//Zmienne dla uzytkownika
float USER_AMPLITUDE = 10; //amplituda
float USER_PERIOD = 2; //okres podstawowy dla sygnalow z okresem
float SIGNAL_START = 0.0; //poczatek sygnalu w sekundach
float SIGNAL_END = 10.0; //koniec sygnalu w sekundach
float FILL_FACTOR = 0.5; //wspolczynnik wypelnienia
float IMPULSE_FREQUENCY = 1000;
float IMPULSE_PROBABILITY = 0.25;
float QUANTIZATION_JUMP_SIZE = 2; //skok pionowy
float[] startEndAmp = {SIGNAL_START, SIGNAL_END, USER_AMPLITUDE}; //poczatek i koniec sygnalu oraz amplituda
int IMPULSE_NOISETIME = 50;
int SAMPLE_NUMBER = 512; //liczba probek
int RECONSTRUCTED_SAMPLE_NUMBER = 50;
int SAMPLE_RATE = 10;
int IMPULSE_AMPLITUDE = 10;
int IMPULSE_FIRSTSAMPLE = 25;
int IMPULSE_JUMPSAMPLE = 0;

////////////////ZADANIE 4
boolean isComplexChartVisible = true;
int complexChartsType = 1; //1 - gora to rzeczywiste, dol to urojone
                           //2 - gora to modul liczby zespolonej, dol to argument liczby w funkcji czestotliwosci
String whichChart4TypeIsVisible = "góra - rzeczywiste, dół - urojone";
int transformation4Type = 1; //1 - DIF FFT,2 - DCT, 3 - ten gosc z dluga nazwa
String transformation4TypeString = "DIF FFT";
float[] x;
float[] x0;
float[] signalRE;
float[] signalIM;
float[] signalMOD;
float[] signalARG;
int transformationTimeStart = 0;
int transformationTime = 0;

////////////////ZADANIE 3
//sploty
int convSignal2SampleNumber = SAMPLE_NUMBER;

//korelacje
int delayCorelationNumber = SAMPLE_NUMBER;
int corelationChoice = 1;

//filtracja
int filterPassChoice = 1; //1-dolnoprzepustowy, 2-srodkowoprzepustowy, 3-gornoprzepustowy
int filterWindowChoice = 1; //1-okno prostokatne, 2-okno hamminga, 3-okno hanninga, 4-okno blackmana *vine boom sound*
int parametrK = 8;
int parametrM = 7;
Boolean isOptionalFilterVisible = false;

//inne
int whichIsVisible = 0; //0-nic, 1-splot, 2-filtracja, 3-korelacja
String whichIsVisibleString = "nic";
////////////////ZADANIE 3


int operationSignalChoice1 = 3;
int operationSignalChoice2 = 5;
float[] operationSignalAmp;
float[] operationSignalTime;
float[] tempOperationSignal1;
float[] tempOperationSignal2;

//zmienne pomocnicze, przechowujace dane dynamicznie
float recTime[];
float recAmpl[];
float recOnlyValues[];
float[] calc1, calc2;
float[] calcResult = new float[SAMPLE_NUMBER];
float[] calcTime = new float[SAMPLE_NUMBER];

//flagi, tablice czyszczące
String signalType;
String impulsType;
String signalName;
String[] string1;
String[] string2;
String wykres1String, operacjaString, wykres2String; // zmienne do operacji na sygnalach
boolean isItSignalOrImpulse = true; // flaga okreslajaca czy wyswietalmy signaly czy impuls aby podmienic tekst w ui
boolean wasMousePressedLastFrame = false;
float[] toZeroX = {0, 0}; // pomocniczna tablica do wyzerowania wykresu, aby poprzedni nie chodzil na naastepny // tablica osi X
float[] toZeroY = {0, 0}; // -||- tablica osi Y
float[] loadedFloatList;
int w1, op, w2; // ^^ w formie intow

//wyborowe
int wyborWykresu = 3;
Boolean isReconstructionChartVisible = false;
int reconstructionChoice = 1;
String reconstructionType;

//sygnaly
Signal S0;

ContinuosSignal S1 = new ContinuosSignal(startEndAmp);
Gauss S2 = new Gauss(startEndAmp, 0, 1); //startEndAmp, srednia, odchylenie
Sinusoidal S3 = new Sinusoidal(startEndAmp, USER_PERIOD); //startEndAmp, okres, term
RectifiedOneSinusoidal S4 = new RectifiedOneSinusoidal(startEndAmp, USER_PERIOD); //startEndAmp, okres
RectifiedTwoSinusoidal S5 = new RectifiedTwoSinusoidal(startEndAmp, USER_PERIOD); //startEndAmp, okres
Rectangular S6 = new Rectangular(startEndAmp, USER_PERIOD, FILL_FACTOR); //startEndAmp, okres, wspolczynnik wypelnienia
SymmetricalRectangular S7 = new SymmetricalRectangular(startEndAmp, USER_PERIOD, FILL_FACTOR); //startEndAmp, okres, wspolczynnik wypelnienia
Triangular S8 = new Triangular(startEndAmp, USER_PERIOD, FILL_FACTOR); //startEndAmp, okres, wspolczynnik wypelnienia
UnitStroke S9 = new UnitStroke(startEndAmp, USER_PERIOD); //startEndAmp

UnitImpulse I1 = new UnitImpulse(IMPULSE_FREQUENCY, USER_AMPLITUDE, IMPULSE_FIRSTSAMPLE, IMPULSE_JUMPSAMPLE);
NoiseImpulse I2 = new NoiseImpulse(IMPULSE_FREQUENCY, USER_AMPLITUDE, FILL_FACTOR, IMPULSE_NOISETIME);
