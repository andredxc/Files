import java.io.*;

public class codigo {
    public static void main(String[] args) {
        String line1;
        String line2;

        line1 = readFile("in1.txt");
        line2 = readFile("in2.txt");

        System.out.println(
            longestSubstr(line1, line2)
            );
    }

    public static int longestSubstr(String first, String second) {     
        int maxLen = 0;
        int fl = first.length();
        int sl = second.length();
        short[][] table = new short[fl+1][sl+1];
    
        for (int i = 1; i <= fl; i++) {
            for (int j = 1; j <= sl; j++) {
                if (first.charAt(i-1) == second.charAt(j-1)) {
                        table[i][j] = (short) (table[i - 1][j - 1] + 1);
                        // if (table[i][j] > 100)
                        //     System.out.println(table[i][j]);
                    if (table[i][j] > maxLen)
                        maxLen = table[i][j];
                }
            }
        }
        return maxLen;
    }

    public static String readFile(String filename) {
        try {
            BufferedReader reader = new BufferedReader(new FileReader(filename));
            String line;
            line = reader.readLine();
            reader.close();
            return line;
        }
        catch (Exception e) {
            System.err.format("Exception occurred trying to read '%s'.", filename);
            e.printStackTrace();
            return null;
        }
    }
}