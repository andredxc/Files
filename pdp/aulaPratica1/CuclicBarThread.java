package exemplos;
import exemplos.*;
import java.util.concurrent.BrokenBarrierException;
import java.util.ArrayList;
import java.util.concurrent.CyclicBarrier;

public class CuclicBarThread implements Runnable {

        CyclicBarrier barrier;
        CyclicBarrier finalBarrier;
		int index;
		ArrayList<Double> nums;

        public CuclicBarThread(CyclicBarrier barrier, CyclicBarrier finalBarrier, ArrayList<Double> nums, int index) {
            this.barrier = barrier;
			this.index = index;
			this.nums = nums;
			this.finalBarrier = finalBarrier;
        }

        @Override
        public void run() {
            try {
                for (int i = 1; i < 5; i++) {
		   			Thread.sleep(10);
                }
                System.out.println(Thread.currentThread().getName() + " :: Barreira 1: Esperando o primeiro estágio ser completado");
				nums.set(index, nums.get(index)+1);
				barrier.await();
			

                for (int i = 1; i < 5; i++) {
                    Thread.sleep(200);
                }
                System.out.println(Thread.currentThread().getName() + " :: Barreira 2: Esperando o segundo estágio ser completado");
				nums.set(index, nums.get(index)+1);
				barrier.await();

                for (int i = 1; i < 5; i++) {
		    		Thread.sleep(10);
                }
                System.out.println(Thread.currentThread().getName() + " :: Barreira 3: Esperando o terceiro estágio ser completado");
				nums.set(index, nums.get(index)+1);
				barrier.await();
			

                System.out.println(Thread.currentThread().getName()+" :: Thread encerrada");
				finalBarrier.await();
            } catch (Exception ex) {
                ex.printStackTrace();
            }



        }
    }
