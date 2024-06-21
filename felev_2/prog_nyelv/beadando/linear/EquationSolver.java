package linear;

import linear.algebra.GaussianElimination;

public class EquationSolver {
    public static double[][] stringsToDoubles(String[][] bemenet) {
        double[][] tomb = new double[bemenet.length][bemenet[0].length];
        for(int i = 0; i < bemenet.length; i++){
            for(int j = 0; j < bemenet[0].length; j++){
                tomb[i][j] = Double.parseDouble(bemenet[i][j]);
            }
        }
        return tomb;
    }

    public static void main(String[] args) {

        String[][] bemenet = new String[args.length][];
        String[] tokens = new String[args.length];

        for(int i = 0; i < args.length; i++){
            String[] test = args[i].split(",");
            bemenet[i] = new String[test.length];
            for(int j = 0; j < test.length; j++){
                bemenet[i][j] = test[j];
            }
        }
      
        double[][] matrix = stringsToDoubles(bemenet);

        GaussianElimination ahh = new GaussianElimination(3, 4, matrix);

        ahh.print(); 
        ahh.rowEchelonForm();

        System.out.println();

        ahh.print(); 
        ahh.backSubstitution();

        System.out.println();

        ahh.print();

    }
}
