import java.math.BigInteger;
import java.util.Random;

public class rsaSifreleme {
    private static String mesaj;

    private static BigInteger nBig;
    private static BigInteger asciiBig;
    private static BigInteger eBig;
    private static BigInteger dBig;
    private static char[] dizi;
    private static char[] metinSifrele;

    public rsaSifreleme(String mesaj){
        this.mesaj= mesaj;
        dizi = mesaj.toCharArray();
    }


    private static boolean tekMi(int e){
        for (int i = 2; i < e; i++){
            if(e % i == 0){
                return false;
            }
        }
        return true;
    }

    private static int dHesapla(int totient, int e) {

        for (int k = 1; k < totient; k++) {

            if (((totient * k + 1) % e) == 0) {

                return (((totient * k) + 1) / e);
            }
        }

        return 0;
    }

    private static BigInteger dHesapla2(BigInteger nBig, BigInteger ascii, BigInteger e) {

        BigInteger asciiExpE = BigInteger.valueOf(1);

        for (int i = 1; i <= e.intValue(); i++) {

            asciiExpE = ascii.multiply(asciiExpE);
        }

        BigInteger c = BigInteger.valueOf(1);

        c = asciiExpE.mod(nBig);

        return c;
    }

    public String anahtarOlustur(){
        int p= 41;
        int q= 43;
        int n = p * q;
        int totient = (p-1) * (q-1);
        int e;

        Random rastgele = new Random();
        do{
            e = rastgele.nextInt(totient);
        } while(!tekMi(e));
        int d = dHesapla(totient, e);
        System.out.println("public key:  ("+totient+"," +e+")");
        System.out.println("private key: ("+totient+"," +d+")\n");
        nBig = BigInteger.valueOf(n);
        eBig = BigInteger.valueOf(e);
        dBig = BigInteger.valueOf(d);
        return " ";
    }
    public char[] metinSifrele() {

        metinSifrele = new char[dizi.length];

        int metinSifreleIndex = 0;

        for (char letter : dizi) {

            int ascii = (int) letter;

            asciiBig = BigInteger.valueOf(ascii);

            BigInteger c = dHesapla2(nBig, asciiBig, eBig);

            metinSifrele[metinSifreleIndex++] = (char) c.intValue();
        }

        return metinSifrele;

    }

    public char[] metinCoz() {

        char[] metinCoz = new char[dizi.length];

        int metinCozIndex = 0;

        for (char letter : metinSifrele) {

            BigInteger c = BigInteger.valueOf((int) letter);

            BigInteger de = dHesapla2(nBig, c, dBig);

            metinCoz[metinCozIndex++] = (char) de.intValue();

        }

        return metinCoz;

    }

}
