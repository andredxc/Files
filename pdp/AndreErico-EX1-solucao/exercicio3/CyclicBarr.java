package exemplos;
import exemplos.*;
import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;
import java.util.ArrayList;

public class CyclicBarr {


        public static void main(String[] args) {

	
			ArrayList<Double> numVector = new ArrayList<Double>();
			int i, numThreads=5;

            CyclicBarrier barrier = new CyclicBarrier(numThreads, new Runnable() {
                private int count =1;
                @Override
                public void run() {
                    System.out.println("Barreira superada..!! "+(count++));
                }
            });

			CyclicBarrier finalBarrier = new CyclicBarrier(numThreads+1);

			for (i = 0; i <= numThreads-1; i++){
				numVector.add(0.0);
			}

			System.out.println("Vetor inicial: " + numVector);

            for (i = 0; i <= numThreads-1; i++) {

                Thread t = new Thread(new CuclicBarThread(barrier, finalBarrier, numVector, i));
                t.start();

            }

			try{
				finalBarrier.await();
			} catch (Exception ex) {
                ex.printStackTrace();
            }

			System.out.println("Resultado: " + numVector);

        }
    }
