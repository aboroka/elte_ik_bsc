package linear.algebra;

import java.lang.Math;

public class GaussianElimination {
    private double[][] matrix;

    private int cols;
    private int rows;

    public GaussianElimination(int rows, int cols, double[][] matrix) {
        this.cols = cols;
        this.rows = rows;
        this.matrix = matrix;
    }

    public int getCols() {
        return cols;
    }

    public int getRows() {
        return rows;
    }

    public double[][] getMatrix() {
        return matrix;
    }

    public void setMatrix(double[][] matrix) {
        checkMatrixDimensions(matrix);
        this.matrix = matrix;
    }

    public void rowEchelonForm() {
        int h = 0;
        int k = 0;
        while (h < cols && k < rows) {
            int i_max = argMax(h, k);
            if (matrix[i_max][k] == 0)
                k++;
            else {
                swapRows(h, i_max);
                for (int i = h + 1; i < rows; i++) {
                    multiplyAndAddRow(i, h, k);
                }
                multiplyRow(h, k);
                h++;
                k++;
            }
        }
    }

    private int argMax(int row_index, int col_index) {
        int index = row_index;
        double max = Math.abs(matrix[row_index][col_index]);
        for (int i = row_index + 1; i < rows; i++) {
            if ((double) Math.abs(matrix[i][col_index]) > max) {
                max = Math.abs(matrix[i][col_index]);
                index = i;
            }
        }
        return index;
    }

    private void swapRows(int row_ind1, int row_ind2) {
        for (int i = 0; i < cols; i++) {
            double temp = matrix[row_ind1][i];
            matrix[row_ind1][i] = matrix[row_ind2][i];
            matrix[row_ind2][i] = temp;
        }
    }

    private void multiplyAndAddRow(int addRow, int mulRow, int colIndex) {
        double f = matrix[addRow][colIndex] / matrix[mulRow][colIndex];
        matrix[addRow][colIndex] = 0;
        for (int j = colIndex + 1; j < cols; j++) {
            matrix[addRow][j] = matrix[addRow][j] - matrix[mulRow][j] * f;
        }
    }

    private void multiplyRow(int row_index, int col_index) {
        double temp = matrix[row_index][col_index];
        for (int i = col_index; i < cols; i++) {
            matrix[row_index][i] = matrix[row_index][i] / temp;
        }
    }

    public void backSubstitution() {
        for (int i = rows - 1; i >= 0; i--) {
            if (matrix[i][i] == 0) {
                throw new IllegalArgumentException();
            } else {
                for(int j = i - 1; j > -1; j--)
                multiplyAndAddRow(j, i, i);
            }
        }
    }

    private void checkMatrixDimensions(double[][] matrix) {
        if (rows != matrix.length && cols != matrix[0].length) {
            throw new IllegalArgumentException("Error: cols és rows nem egyezik meg a jelenlegivel");
        }
    }

    public void print() {
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (matrix[i][j] < 0) {
                    System.out.print(matrix[i][j]);
                    switch(j){
                        case 0: System.out.print("x");
                        break;
                        case 1: System.out.print("y");
                        break;
                        case 2: System.out.print("z=");
                        break;
                        default: System.out.print("");
                    }
                } else {
                    System.out.print("+" + matrix[i][j]);
                    switch(j){
                        case 0: System.out.print("x");
                        break;
                        case 1: System.out.print("y");
                        break;
                        case 2: System.out.print("z=");
                        break;
                        default: System.out.print("");
                    }
                }
            }
            System.out.println();
        }
    }
}
